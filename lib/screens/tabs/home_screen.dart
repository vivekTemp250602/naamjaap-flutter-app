import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/services/achievements_service.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/mantra_info_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/services/sync_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/mala_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum InfoLanguage { english, hindi, sanskrit }

class AnimatedBackground extends StatefulWidget {
  final List<String> imagePaths;

  const AnimatedBackground({super.key, required this.imagePaths});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    if (widget.imagePaths.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
        if (mounted) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % widget.imagePaths.length;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2),
      child: Container(
        key: ValueKey<String>(widget.imagePaths[_currentIndex]),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.imagePaths[_currentIndex]),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  // Services and controllers
  final AudioService _audioService = AudioService();
  final FirestoreService _firestoreService = FirestoreService();
  late final String _uid;
  late StreamSubscription<PlayerState> _playerStateSubscription;
  final AchievementsService _achievementsService = AchievementsService();
  late ConfettiController _malaConfettiController;
  SyncService? _syncService;

  // Ad Services variables
  static const String _screenName = 'home';
  final AdService _adService = AdService();

  // State variables
  int _totalMantraCount = 0;
  int _streakCount = 0;
  Map<String, int> _pendingJappsLedger = {};
  bool _isMuted = false;
  bool _isVibrationEnabled = true;
  bool _isPlaying = false;
  bool _isZenMode = false;
  Timer? _syncTimer;

  @override
  void initState() {
    super.initState();
    _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        });
    _uid = FirebaseAuth.instance.currentUser!.uid;
    _malaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);

    _syncService = SyncService(
      connectivityService:
          Provider.of<ConnectivityService>(context, listen: false),
      firestoreService: _firestoreService,
      uid: _uid,
      onSyncComplete: () => _onSyncComplete(mantraProvider),
    );

    _loadPreferences();
    _loadInitialCounts();

    _playerStateSubscription =
        _audioService.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    _syncTimer?.cancel();
    _syncService?.syncPendingData();
    _syncService?.dispose();
    _malaConfettiController.dispose();
    _playerStateSubscription.cancel();
    _audioService.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // --- Helper Methods ---

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _isMuted = prefs.getBool(AppConstants.prefsKeyMute) ?? false;
        _isVibrationEnabled =
            prefs.getBool(AppConstants.prefsKeyVibrationEnabled) ?? true;
      });
      await _audioService.setMuted(_isMuted);
    }
  }

  Future<void> _loadInitialCounts() async {
    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists || !mounted) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);

    // Use the provider's selected mantra to get the right count
    final mantraKey = mantraProvider.selectedMantra?.id ?? '';

    setState(() {
      _totalMantraCount = jappsMap[mantraKey] as int? ?? 0;
      _streakCount = userData['currentStreak'] ?? 0;
    });
  }

  Future<void> _loadTotalCounts(String mantraId) async {
    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists || !mounted) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};

    setState(() {
      _totalMantraCount = jappsMap[mantraId] as int? ?? 0;
      _streakCount = userData['currentStreak'] ?? 0;
    });
  }

  // This is the command that the SyncService runs after it successfully uploads data.
  void _onSyncComplete(MantraProvider provider) {
    if (mounted) {
      print("Sync complete! Refreshing totals from Firestore.");
      setState(() {
        _pendingJappsLedger = {};
      });
      // We get the mantraId from the provider
      _loadInitialCounts();
    }
  }

  Future<void> _saveSelectedMantra(String mantraId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsKeySelectedMantra, mantraId);
  }

  void _onMantraSelected(Mantra mantra) async {
    await _syncService?.syncPendingData();
    if (_isPlaying) await _audioService.stop();

    // Tell the provider to change
    Provider.of<MantraProvider>(context, listen: false)
        .setSelectedMantra(mantra);

    // Load the new counts
    await _loadTotalCounts(mantra.id);
  }

  Future<void> _incrementCounter() async {
    if (_isVibrationEnabled) HapticFeedback.lightImpact();

    final mantraKey =
        Provider.of<MantraProvider>(context, listen: false).selectedMantra!.id;

    setState(() {
      _pendingJappsLedger[mantraKey] =
          (_pendingJappsLedger[mantraKey] ?? 0) + 1;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'pendingJappsLedger', json.encode(_pendingJappsLedger));

    _syncTimer?.cancel();
    _syncTimer = Timer(
        const Duration(seconds: 5), () => _syncService?.syncPendingData());

    final currentTotal =
        _totalMantraCount + (_pendingJappsLedger[mantraKey] ?? 0);
    if (currentTotal > 0 && currentTotal % 108 == 0) {
      _malaConfettiController.play();
      _audioService.playOneShotSound('assets/audio/mala_complete.mp3');
      _firestoreService.incrementTotalMalas(_uid);
      _achievementsService.checkAndAwardBadges(_uid);
    }

    if (!_isPlaying) {
      _audioService.play(Provider.of<MantraProvider>(context, listen: false)
          .selectedMantra!
          .audioPath);
    }
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

  void _showMantraInfo(String mantraName) {
    final descriptions = MantraInfoService.getDescription(mantraName);
    InfoLanguage selectedLanguage = InfoLanguage.english;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            String displayText = descriptions['en'] ?? '';

            switch (selectedLanguage) {
              case InfoLanguage.hindi:
                displayText = descriptions['hi'] ?? displayText;
                break;
              case InfoLanguage.sanskrit:
                displayText = descriptions['sa'] ?? displayText;
                break;
              case InfoLanguage.english:
                displayText = descriptions['en'] ?? displayText;
                break;
            }

            return AlertDialog(
              title: Text(mantraName),
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
                    const Divider(height: 24),
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
                  child: Text(AppLocalizations.of(context)!.dialog_close),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onMantraSwiped(
      DragEndDetails details, List<Mantra> allMantras, Mantra selectedMantra) {
    if (details.primaryVelocity == null) return;

    final int currentIndex = allMantras.indexOf(selectedMantra);
    if (currentIndex == -1) return;

    if (details.primaryVelocity! < 0) {
      // Swiped Left (velocity is negative) -> Go to NEXT mantra
      final int nextIndex = (currentIndex + 1) % allMantras.length;
      _onMantraSelected(allMantras[nextIndex]);
    } else if (details.primaryVelocity! > 0) {
      // Swiped Right (velocity is positive) -> Go to PREVIOUS mantra
      final int prevIndex =
          (currentIndex - 1 + allMantras.length) % allMantras.length;
      _onMantraSelected(allMantras[prevIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);
    final connectivityService = Provider.of<ConnectivityService>(context);

    return Consumer<MantraProvider>(builder: (context, mantraProvider, child) {
      if (mantraProvider.isLoading || mantraProvider.selectedMantra == null) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final selectedMantra = mantraProvider.selectedMantra!;
      final allMantras = mantraProvider.allMantras;

      // Variables
      final mantraKey = selectedMantra.id;
      final pendingCount = _pendingJappsLedger[mantraKey] ?? 0;
      final displayTotal = _totalMantraCount + pendingCount;
      final malaProgressCounter = displayTotal % 108;
      return Stack(
        children: [
          /// Mantra Background
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: selectedMantra.isCustom
                  ? AppConstants.getBackgroundById(selectedMantra.backgroundId!)
                      .child
                  : AnimatedBackground(
                      key: ValueKey<String>(selectedMantra.id),
                      imagePaths:
                          AppConstants.mantraImagePaths[selectedMantra.name]!,
                    )),
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
                child: Column(
              children: [
                Chip(
                  avatar: Icon(Icons.local_fire_department,
                      color: Colors.orange.shade800),
                  label: Text(
                      '$_streakCount ${AppLocalizations.of(context)!.home_dayStreak} ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: allMantras.map((mantra) {
                          final isSelected = selectedMantra.id == mantra.id;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () => _onMantraSelected(mantra),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.orange.withAlpha(210)
                                      : Colors.black.withAlpha(70),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.orange.shade300
                                        : Colors.white.withAlpha(128),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  mantra.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Mantra Info Button
                TextButton.icon(
                  onPressed: () => _showMantraInfo(selectedMantra.name),
                  icon: const Icon(Icons.info_outline),
                  label: Text(AppLocalizations.of(context)!.home_mantraInfo),
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
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
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
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) =>
                        _onMantraSwiped(details, allMantras, selectedMantra),
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
                                    color:
                                        Colors.orange.shade900.withAlpha(160),
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
                                    duration: const Duration(milliseconds: 200),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return ScaleTransition(
                                          scale: animation, child: child);
                                    },
                                    child: Text(
                                      (malaProgressCounter == 0 &&
                                              displayTotal > 0)
                                          ? "108"
                                          : (malaProgressCounter).toString(),
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
                                    '${AppLocalizations.of(context)!.home_total}: ${displayTotal.toString()}',
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
                ),
                Text("",
                    style: TextStyle(
                        color: Colors.white.withAlpha(190), fontSize: 18)),
                const SizedBox(height: 36),

                if (bannerAd != null &&
                    _adService.isAdLoadedForScreen(_screenName))
                  Container(
                    alignment: Alignment.center,
                    width: bannerAd.size.width.toDouble(),
                    height: bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: bannerAd),
                  ),
              ],
            )),
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
    });
  }
}
