import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/services/achievements_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/mantra_info_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/services/sync_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/mala_widget.dart';
import 'package:naamjaap/widgets/quote_card.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';

enum InfoLanguage { english, hindi, sanskrit }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Services and controllers
  final AudioService _audioService = AudioService();
  final FirestoreService _firestoreService = FirestoreService();
  late final String _uid;
  late StreamSubscription<PlayerState> _playerStateSubscription;
  // final AchievementsService _achievementsService = AchievementsService();
  late ConfettiController _malaConfettiController;
  SyncService? _syncService;

  // State variables - The UI is now driven by this fast, local state.
  int _totalMantraCount = 0; // The last known total from Firestore
  int _streakCount = 0;
  Map<String, int> _pendingJappsLedger =
      {}; // The local "notebook" for unsynced chants
  String _selectedMantra = AppConstants.hareKrishna;
  bool _isMuted = false;
  bool _isVibrationEnabled = true;
  bool _isPlaying = false;
  bool _isQuoteDismissedToday = false;
  bool _isLoading = true;
  bool _isZenMode = false;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser!.uid;
    _malaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    // Initialize the SyncService and give it a command (_onSyncComplete) to run after it finishes.
    _syncService = SyncService(
      connectivityService:
          Provider.of<ConnectivityService>(context, listen: false),
      firestoreService: _firestoreService,
      uid: _uid,
      onSyncComplete: _onSyncComplete,
    );

    _initializeScreen();

    _playerStateSubscription =
        _audioService.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _syncTimer?.cancel();
    _syncService?.syncPendingData();
    _syncService?.dispose();
    _malaConfettiController.dispose();
    _playerStateSubscription.cancel();
    _audioService.dispose();
    super.dispose();
  }

  // --- Helper Methods ---

  Future<void> _initializeScreen() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();

    // Load user preferences
    final lastDismissedDate = prefs.getString('lastQuoteDismissedDate') ?? '';
    final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final selectedMantra =
        prefs.getString(AppConstants.prefsKeySelectedMantra) ??
            AppConstants.hareKrishna;
    final isMuted = prefs.getBool(AppConstants.prefsKeyMute) ?? false;
    final isVibrationEnabled =
        prefs.getBool(AppConstants.prefsKeyVibrationEnabled) ?? true;

    // Load any pending japps from the last session
    final ledgerJson = prefs.getString('pendingJappsLedger');
    final Map<String, int> pendingJappsLedger = ledgerJson != null
        ? Map<String, int>.from(json.decode(ledgerJson))
        : {};

    // Fetch the latest totals from Firestore once to get our baseline
    await _loadTotalCounts(selectedMantra);

    if (mounted) {
      setState(() {
        _isQuoteDismissedToday = lastDismissedDate == todayDate;
        _selectedMantra = selectedMantra;
        _isMuted = isMuted;
        _isVibrationEnabled = isVibrationEnabled;
        _pendingJappsLedger = pendingJappsLedger;
        _isLoading = false;
      });
      await _audioService.setMuted(_isMuted);
    }
  }

  Future<void> _loadTotalCounts(String mantra) async {
    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists || !mounted) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
    final mantraKey = mantra.toLowerCase().replaceAll(' ', '_');

    setState(() {
      _totalMantraCount = jappsMap[mantraKey] as int? ?? 0;
      _streakCount = userData['currentStreak'] ?? 0;
    });
  }

  // This is the command that the SyncService runs after it successfully uploads data.
  void _onSyncComplete() {
    if (mounted) {
      print("Sync complete! Refreshing totals from Firestore.");
      // After a sync, we clear the local "notebook" and fetch the new, updated totals.
      setState(() {
        _pendingJappsLedger = {};
      });
      _loadTotalCounts(_selectedMantra);
    }
  }

  void _onMantraSelected(String mantra) async {
    await _syncService?.syncPendingData();
    if (_isPlaying) await _audioService.stop();
    setState(() {
      _selectedMantra = mantra;
    });
    await _saveSelectedMantra(mantra);
    await _loadTotalCounts(mantra);
  }

  Future<void> _incrementCounter() async {
    if (_isVibrationEnabled) HapticFeedback.lightImpact();

    final mantraKey = _selectedMantra.toLowerCase().replaceAll(' ', '_');

    // 1. Instantly update the local "notebook" for a fast UI feel.
    setState(() {
      _pendingJappsLedger[mantraKey] =
          (_pendingJappsLedger[mantraKey] ?? 0) + 1;
    });

    // 2. Save the updated notebook to the phone's storage.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'pendingJappsLedger', json.encode(_pendingJappsLedger));

    // 3. Reset a timer. After 5 seconds of inactivity, it will try to sync.
    _syncTimer?.cancel();
    _syncTimer = Timer(
        const Duration(seconds: 5), () => _syncService?.syncPendingData());

    // 4. Check for mala completion using the combined total.
    final currentTotal =
        _totalMantraCount + (_pendingJappsLedger[mantraKey] ?? 0);
    if (currentTotal > 0 && currentTotal % 108 == 0) {
      _malaConfettiController.play();
      _audioService.playOneShotSound('assets/audio/mala_complete.mp3');
    }

    if (!_isPlaying) {
      _audioService.play(AppConstants.mantraAudioPaths[_selectedMantra]!);
    }
  }

  Future<void> _saveSelectedMantra(String mantra) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsKeySelectedMantra, mantra);
  }

  void _toggleMute() async {
    final newMuteStatus = !_isMuted;
    setState(() {
      _isMuted = newMuteStatus;
    });
    await _audioService.setMuted(newMuteStatus);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsKeyMute, newMuteStatus);
  }

  void _toggleVibration() async {
    final newStatus = !_isVibrationEnabled;
    setState(() {
      _isVibrationEnabled = newStatus;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsKeyVibrationEnabled, newStatus);
  }

  Future<void> _dismissQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await prefs.setString('lastQuoteDismissedDate', todayDate);
    if (mounted) {
      setState(() {
        _isQuoteDismissedToday = true;
      });
    }
  }

  void _showMantraInfo() {
    final descriptions = MantraInfoService.getDescription(_selectedMantra);
    InfoLanguage selectedLanguage = InfoLanguage.english;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            String displayText;
            switch (selectedLanguage) {
              case InfoLanguage.hindi:
                displayText = descriptions['hi']!;
                break;
              case InfoLanguage.sanskrit:
                displayText = descriptions['sa']!;
                break;
              case InfoLanguage.english:
                displayText = descriptions['en']!;
            }

            return AlertDialog(
              title: Text(_selectedMantra),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Text(
                          displayText,
                          style: const TextStyle(height: 1.5),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 24,
                    ),
                    ToggleButtons(
                      isSelected: [
                        selectedLanguage == InfoLanguage.english,
                        selectedLanguage == InfoLanguage.hindi,
                        selectedLanguage == InfoLanguage.sanskrit,
                      ],
                      onPressed: (index) {
                        setDialogState(() {
                          selectedLanguage = InfoLanguage.values[index];
                        });
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      children: const [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text('English')),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text('हिन्दी')),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text('Sanskrit')),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Close"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void toggleZenMode() {
    setState(() {
      _isZenMode = !_isZenMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final connectivityService = Provider.of<ConnectivityService>(context);
    final mantraKey = _selectedMantra.toLowerCase().replaceAll(' ', '_');
    final pendingCount = _pendingJappsLedger[mantraKey] ?? 0;

    // The "Mala Progress" is now the Firestore total + any unsynced local chants.
    final displayTotal = _totalMantraCount + pendingCount;
    final malaProgressCounter = displayTotal % 108;

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          child: Container(
            key: ValueKey<String>(_selectedMantra),
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(AppConstants.mantraImagePaths[_selectedMantra]!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withAlpha(140),
              Colors.black.withAlpha(70),
              Colors.black.withAlpha(140)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : Column(
                    children: [
                      if (!_isQuoteDismissedToday)
                        StreamBuilder<DocumentSnapshot>(
                          stream: _firestoreService.getDailyQuoteStream(),
                          builder: (context, quoteSnapshot) {
                            if (quoteSnapshot.hasError ||
                                !quoteSnapshot.hasData ||
                                !quoteSnapshot.data!.exists) {
                              return QuoteCard(
                                textEN: AppConstants.defaultQuote['text_en']!,
                                textHI: AppConstants.defaultQuote['text_hi']!,
                                textSA: AppConstants.defaultQuote['text_sa']!,
                                source: AppConstants.defaultQuote['source']!,
                              );
                            }
                            final quoteData = quoteSnapshot.data!.data()
                                as Map<String, dynamic>;
                            if (!quoteData.containsKey('text_en') ||
                                !quoteData.containsKey('text_hi') ||
                                !quoteData.containsKey('text_sa')) {
                              return QuoteCard(
                                textEN: AppConstants.defaultQuote['text_en']!,
                                textHI: AppConstants.defaultQuote['text_hi']!,
                                textSA: AppConstants.defaultQuote['text_sa']!,
                                source: AppConstants.defaultQuote['source']!,
                              );
                            }
                            return Dismissible(
                              key: ValueKey(quoteData['source']),
                              onDismissed: (direction) => _dismissQuote(),
                              child: QuoteCard(
                                textEN: quoteData['text_en'] ?? '...',
                                textHI: quoteData['text_hi'] ?? '...',
                                textSA: quoteData['text_sa'] ?? '...',
                                source: quoteData['source'] ?? '...',
                              ),
                            );
                          },
                        ),
                      Chip(
                        avatar: Icon(Icons.local_fire_department,
                            color: Colors.orange.shade800),
                        label: Text('$_streakCount Day Streak',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        backgroundColor: Colors.white.withAlpha(190),
                        elevation: 4,
                      ),

                      // Mantra Selector
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                ...RemoteConfigService().mantras.map((mantra) {
                                  final isSelected = _selectedMantra == mantra;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: GestureDetector(
                                      onTap: () => _onMantraSelected(mantra),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.orange.withAlpha(210)
                                              : Colors.black.withAlpha(70),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: isSelected
                                                  ? Colors.orange.shade300
                                                  : Colors.white.withAlpha(128),
                                              width: 2),
                                        ),
                                        child: Text(mantra,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.normal)),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Mantra Info Button
                      TextButton.icon(
                        onPressed: _showMantraInfo,
                        icon: const Icon(Icons.info_outline),
                        label: const Text("Mantra Info"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white.withAlpha(220),
                        ),
                      ),

                      // Internet Status - Vibration - Sound
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Online Status
                            Icon(
                              connectivityService.isOnline
                                  ? Icons.cloud_done_outlined
                                  : Icons.cloud_off_outlined,
                              color: connectivityService.isOnline
                                  ? Colors.green.shade300
                                  : Colors.red.shade300,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            // Vibration Status
                            IconButton(
                              icon: Icon(_isVibrationEnabled
                                  ? Icons.vibration
                                  : Icons.mobile_off_rounded),
                              iconSize: 28,
                              color: Colors.white.withAlpha(210),
                              onPressed: _toggleVibration,
                              tooltip: _isVibrationEnabled
                                  ? 'Vibration On'
                                  : 'Vibration Off',
                            ),

                            // Sound Status
                            IconButton(
                              icon: Icon(_isMuted
                                  ? Icons.volume_off
                                  : Icons.volume_up),
                              iconSize: 28,
                              color: Colors.white.withAlpha(210),
                              onPressed: _toggleMute,
                              tooltip: _isMuted ? 'Sound Off' : 'Sound On',
                            ),
                          ],
                        ),
                      ),

                      // Tap to Chant Button
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 340,
                              height: 340,
                              child: CustomPaint(
                                painter: MalaPainter(
                                  beadCount: 108,
                                  activeBeadIndex: malaProgressCounter,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _incrementCounter,
                              child: Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orange.shade700,
                                  gradient: RadialGradient(colors: [
                                    Colors.orange.shade500,
                                    Colors.orange.shade800
                                  ]),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orange.shade900
                                            .withAlpha(160),
                                        spreadRadius: 2,
                                        blurRadius: 20,
                                        offset: const Offset(0, 10)),
                                    BoxShadow(
                                        color: Colors.black.withAlpha(129),
                                        spreadRadius: 10,
                                        blurRadius: 40),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return ScaleTransition(
                                              scale: animation, child: child);
                                        },
                                        child: Text(
                                          (malaProgressCounter == 0 &&
                                                  displayTotal > 0)
                                              ? "108"
                                              : (malaProgressCounter)
                                                  .toString(),
                                          key: ValueKey<int>(displayTotal),
                                          style: const TextStyle(
                                            fontSize: 72,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.black54,
                                                  offset: Offset(2.0, 2.0))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Total: ${displayTotal.toString()}',
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(170),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Tap to Chant',
                          style: TextStyle(
                              color: Colors.white.withAlpha(190),
                              fontSize: 18)),
                      const SizedBox(height: 36),
                    ],
                  ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _malaConfettiController,
            emissionFrequency: 0,
            numberOfParticles: 60,
            maxBlastForce: 50,
            minBlastForce: 20,
            gravity: 0.1,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.orange,
              Colors.amber,
              Colors.yellow,
              Colors.white,
            ],
          ),
        ),
      ],
    );
  }
}
