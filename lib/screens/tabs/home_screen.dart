import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/custom_mantra_editor.dart';
import 'package:naamjaap/services/achievements_service.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/mantra_info_service.dart';
import 'package:naamjaap/services/rating_service.dart';
import 'package:naamjaap/services/sync_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/utils/mala_type.dart';
import 'package:naamjaap/widgets/mala_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:showcaseview/showcaseview.dart';

enum InfoLanguage { english, hindi, sanskrit }

class ZenithSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles;
  final math.Random random = math.Random();

  ZenithSparkles(this.controller, this.sparkles) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height, size.width);
      paint.color = Colors.white.withOpacity(s.opacity * 0.5);
      canvas.drawCircle(Offset(s.x, s.y), s.size, paint);
      paint.color = Colors.amber.withOpacity(s.opacity * 0.2);
      canvas.drawCircle(Offset(s.x, s.y), s.size * 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Sparkle {
  late double x;
  late double y;
  late double speedY;
  late double speedX;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Sparkle(this.rnd) {
    reset(true);
  }

  void reset(bool startRandom) {
    x = rnd.nextDouble() * 500;
    y = startRandom ? rnd.nextDouble() * 800 : 900;
    speedY = 0.5 + rnd.nextDouble() * 1.5;
    speedX = (rnd.nextDouble() - 0.5) * 0.2;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height, double width) {
    y -= speedY;
    x += speedX;
    if (y < -50) reset(false);
  }
}

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
          setState(() =>
              _currentIndex = (_currentIndex + 1) % widget.imagePaths.length);
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
      duration: const Duration(seconds: 3),
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
  final User? user;
  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  // Services
  final AudioService _audioService = AudioService();
  final FirestoreService _firestoreService = FirestoreService();
  final AchievementsService _achievementsService = AchievementsService();
  StreamSubscription<DocumentSnapshot>? _userDocSubscription;
  final AdService _adService = AdService();
  static const String _screenName = 'home';

  late final String _uid;
  late final bool _isGuest;

  // Controllers
  late StreamSubscription<PlayerState> _playerStateSubscription;
  late ConfettiController _malaConfettiController;
  late AnimationController _particleController;
  late AnimationController _pulseController;
  late PageController _carouselController;
  final RatingService _ratingService = RatingService();
  SyncService? _syncService;

  // State
  int _dbMantraCount = 0;
  // int _totalMantraCount = 0;
  Map<String, dynamic> _pendingEvents = {};
  bool _isMuted = false;
  bool _isVibrationEnabled = true;
  bool _isPlaying = false;
  Timer? _syncTimer;
  final List<_Sparkle> _sparkles = [];

  // Tour Keys
  final GlobalKey _keyCarousel = GlobalKey();
  final GlobalKey _keyMala = GlobalKey();
  final GlobalKey _keyDock = GlobalKey();

  @override
  void initState() {
    super.initState();
    _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        });

    final random = math.Random();
    for (int i = 0; i < 40; i++) {
      _sparkles.add(_Sparkle(random));
    }

    _uid = widget.user?.uid ?? 'guest';
    _isGuest = widget.user == null;

    _malaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _particleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..repeat();
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _carouselController = PageController(viewportFraction: 0.65);

    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);

    void providerListener() {
      if (!mantraProvider.isLoading) {
        // Once loaded, force a data fetch for the selected mantra
        if (!_isGuest) {
          _fetchInitialDataFromFirestore(mantraProvider.selectedMantra?.id);
        }
        mantraProvider
            .removeListener(providerListener); // Detach listener once done
      }
    }

    mantraProvider.addListener(providerListener);

    if (!_isGuest) {
      _syncService = SyncService(
        connectivityService:
            Provider.of<ConnectivityService>(context, listen: false),
        firestoreService: _firestoreService,
        uid: _uid,
        onSyncComplete: () => _onSyncComplete(mantraProvider),
      );
    }

    _loadPreferences();

    _userDocSubscription =
        _firestoreService.getUserStatsStream(_uid).listen((snapshot) {
      if (snapshot.exists && mounted) {
        final data = snapshot.data() as Map<String, dynamic>;
        final jappsMap = data['japps'] as Map<String, dynamic>? ?? {};

        // Get ID directly from provider context safely
        final currentMantraId =
            Provider.of<MantraProvider>(context, listen: false)
                .selectedMantra
                ?.id;

        setState(() {
          // If provider isn't ready yet, we might miss this update,
          // but the providerListener above handles the initial load.
          // This handles subsequent real-time updates.
          if (currentMantraId != null) {
            _dbMantraCount = jappsMap[currentMantraId] as int? ?? 0;
          }
        });
      }
    });

    _playerStateSubscription =
        _audioService.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _startHomeTour());
  }

  @override
  void dispose() {
    _userDocSubscription?.cancel();
    _adService.disposeAdForScreen(_screenName);
    _syncTimer?.cancel();
    _syncService?.syncPendingData();
    _syncService?.dispose();
    _malaConfettiController.dispose();
    _playerStateSubscription.cancel();
    _audioService.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  // --- LOGIC ---

  Future<void> _fetchInitialDataFromFirestore(String? mantraId) async {
    if (mantraId == null) return;
    final doc = await _firestoreService.getUserDocument(_uid);
    if (doc.exists && mounted) {
      final data = doc.data() as Map<String, dynamic>;
      final jappsMap = data['japps'] as Map<String, dynamic>? ?? {};
      setState(() {
        _dbMantraCount = jappsMap[mantraId] as int? ?? 0;
      });
    }
  }

  void _startHomeTour() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenTour = prefs.getBool('has_seen_home_tour') ?? false;

    if (!hasSeenTour) {
      ShowCaseWidget.of(context)
          .startShowCase([_keyCarousel, _keyMala, _keyDock]);
      await prefs.setBool('has_seen_home_tour', true);
    }
  }

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

  // Future<void> _loadInitialCounts() async {
  //   if (_isGuest) return;
  //   final userDoc = await _firestoreService.getUserDocument(_uid);
  //   if (!userDoc.exists || !mounted) return;
  //   final userData = userDoc.data() as Map<String, dynamic>;
  //   final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
  //   final mantraProvider = Provider.of<MantraProvider>(context, listen: false);
  //   final mantraKey = mantraProvider.selectedMantra?.id ?? '';

  //   if (mantraProvider.selectedMantra != null) {
  //     final index =
  //         mantraProvider.allMantras.indexOf(mantraProvider.selectedMantra!);
  //     if (index != -1 && _carouselController.hasClients) {
  //       _carouselController.jumpToPage(index);
  //     }
  //   }

  //   setState(() {
  //     _totalMantraCount = jappsMap[mantraKey] as int? ?? 0;
  //   });
  // }

  // ... [Keep _loadTotalCounts, _onSyncComplete, _onMantraSelected] ...
  // Future<void> _loadTotalCounts(String mantraId) async {
  //   if (_isGuest) {
  //     setState(() => _totalMantraCount = 0);
  //     return;
  //   }
  //   final userDoc = await _firestoreService.getUserDocument(_uid);
  //   if (!userDoc.exists || !mounted) return;
  //   final userData = userDoc.data() as Map<String, dynamic>;
  //   final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
  //   setState(() => _totalMantraCount = jappsMap[mantraId] as int? ?? 0);
  // }

  void _onSyncComplete(MantraProvider provider) {
    if (mounted) {
      setState(() => _pendingEvents.clear());
    }
  }

  void _onMantraSelected(Mantra mantra) async {
    if (_isPlaying) await _audioService.stopMantra();
    setState(() {
      _isPlaying = false;
    });

    await _syncService?.syncPendingData();
    Provider.of<MantraProvider>(context, listen: false)
        .setSelectedMantra(mantra);

    if (!_isGuest) {
      final userDoc = await _firestoreService.getUserDocument(_uid);
      if (userDoc.exists && mounted) {
        final data = userDoc.data() as Map<String, dynamic>;
        final jappsMap = data['japps'] as Map<String, dynamic>? ?? {};
        setState(() {
          _dbMantraCount = jappsMap[mantra.id] as int? ?? 0;
          _pendingEvents.clear();
        });
      }
    } else {
      setState(() => _dbMantraCount = 0);
    }
  }

  Future<void> _incrementCounter() async {
    // 1. Haptic Feedback
    if (_isVibrationEnabled) HapticFeedback.mediumImpact();

    final provider = Provider.of<MantraProvider>(context, listen: false);
    final selectedMantra = provider.selectedMantra!;
    final mantraKey = selectedMantra.id;

    // 🪄 RESTORED: Only call the audio player if it's actually stopped. ZERO LAG!
    if (!_isPlaying && !_isMuted) {
      setState(() => _isPlaying = true);
      String path = selectedMantra.isCustom
          ? selectedMantra.customAudioPath!
          : selectedMantra.audioPath;
      if (!selectedMantra.isCustom && path.startsWith('assets/')) {
        path = path.replaceFirst('assets/', '');
      }
      _audioService.startMantraLoop(path, selectedMantra.isCustom);
    }

    if (_isGuest) {
      setState(() => _dbMantraCount++);
      if (_dbMantraCount > 0 && _dbMantraCount % 108 == 0) {
        _celebrateMala();
      }
      return;
    }

    // --- SYNC GLITCH FIX ---
    final String eventId = DateTime.now().microsecondsSinceEpoch.toString();

    setState(() {
      _pendingEvents[eventId] = {'mantraId': mantraKey};
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pendingJapaEvents', json.encode(_pendingEvents));

    _syncTimer?.cancel();
    _syncTimer = Timer(
        const Duration(seconds: 5), () => _syncService?.syncPendingData());

    final int pendingForMantra =
        _pendingEvents.values.where((e) => e['mantraId'] == mantraKey).length;

    final int currentTotal = _dbMantraCount + pendingForMantra;

    if (currentTotal > 0 && currentTotal % 108 == 0) {
      _celebrateMala();
      _achievementsService.checkAndAwardBadges(_uid);
      _ratingService.checkAndAskForReview();
    }
  }

  void _celebrateMala() {
    _malaConfettiController.play();
    // Play one-shot sound on top of the looping mantra audio
    _audioService.playOneShotSound('assets/audio/mala_complete.mp3');
  }

  void _toggleMute() async {
    final newMuteStatus = !_isMuted;
    setState(() => _isMuted = newMuteStatus);
    await _audioService.setMuted(newMuteStatus);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsKeyMute, newMuteStatus);
  }

  void _toggleVibration() async {
    final newStatus = !_isVibrationEnabled;
    setState(() => _isVibrationEnabled = newStatus);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.prefsKeyVibrationEnabled, newStatus);
  }

  // --- DIALOGS & SHEETS ---

  void _showMantraInfo(String mantraName) {
    final descriptions = MantraInfoService.getDescription(mantraName);
    InfoLanguage selectedLanguage = InfoLanguage.hindi;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            String displayText = descriptions['en'] ?? '';
            if (selectedLanguage == InfoLanguage.hindi) {
              displayText = descriptions['hi'] ?? displayText;
            } else if (selectedLanguage == InfoLanguage.sanskrit) {
              displayText = descriptions['sa'] ?? displayText;
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Material(
                  color: Colors.transparent,
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Curves.easeOutBack),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF4A0E4E), Color(0xFF100505)],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color:
                                      const Color(0xFFFFD700).withOpacity(0.3),
                                  width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.purple.shade900.withOpacity(0.5),
                                    blurRadius: 40,
                                    spreadRadius: 2)
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // --- HEADER ---
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white
                                                .withOpacity(0.1)))),
                                child: Column(
                                  children: [
                                    const Icon(Icons.auto_stories_rounded,
                                        color: Color(0xFFFFD700), size: 32),
                                    const SizedBox(height: 10),
                                    Text(
                                      mantraName,
                                      style: const TextStyle(
                                          fontFamily: 'Serif',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFFD700),
                                          letterSpacing: 1,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 4,
                                                offset: Offset(0, 2))
                                          ]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),

                              // --- CONTENT BODY ---
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 24, 24, 10),
                                child: SizedBox(
                                  height: 200,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      child: Text(
                                        displayText,
                                        key: ValueKey<String>(displayText +
                                            selectedLanguage.toString()),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          height: 1.6,
                                          color: Colors.white.withOpacity(0.9),
                                          fontFamily: selectedLanguage ==
                                                  InfoLanguage.english
                                              ? 'Serif'
                                              : 'Sans',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // --- LANGUAGE TABS ---
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(50),
                                      border:
                                          Border.all(color: Colors.white10)),
                                  child: Row(
                                    children: [
                                      _buildLangTab(
                                          "English",
                                          InfoLanguage.english,
                                          selectedLanguage,
                                          (val) => setDialogState(
                                              () => selectedLanguage = val)),
                                      _buildLangTab(
                                          "हिन्दी",
                                          InfoLanguage.hindi,
                                          selectedLanguage,
                                          (val) => setDialogState(
                                              () => selectedLanguage = val)),
                                      _buildLangTab(
                                          "Sanskrit",
                                          InfoLanguage.sanskrit,
                                          selectedLanguage,
                                          (val) => setDialogState(
                                              () => selectedLanguage = val)),
                                    ],
                                  ),
                                ),
                              ),

                              // --- CLOSE BUTTON ---
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    backgroundColor:
                                        Colors.white.withOpacity(0.1),
                                  ),
                                  // LOC: Close
                                  child: Text(
                                    AppLocalizations.of(context)!.dialog_close,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLangTab(String label, InfoLanguage lang, InfoLanguage current,
      ValueChanged<InfoLanguage> onSelect) {
    final bool isSelected = lang == current;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onSelect(lang);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFF8C00) : Colors.transparent,
              borderRadius: BorderRadius.circular(40),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                          color: Colors.orange.withOpacity(0.4), blurRadius: 10)
                    ]
                  : null),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13),
          ),
        ),
      ),
    );
  }

  void _showMalaStyleSheet(BuildContext context) {
    final mantraProvider = Provider.of<MantraProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return ChangeNotifierProvider.value(
          value: mantraProvider,
          child: Consumer<MantraProvider>(
            builder: (context, provider, child) {
              return ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(35)),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF4A0E4E).withOpacity(0.95),
                          const Color(0xFF2E0422).withOpacity(0.95),
                          Colors.black.withOpacity(0.98),
                        ],
                      ),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(35)),
                      border: Border(
                        top: BorderSide(
                            color: const Color(0xFFFFD700).withOpacity(0.3),
                            width: 1.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade900.withOpacity(0.4),
                          blurRadius: 50,
                          spreadRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 1. Handle Bar
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFD700).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.orange.withOpacity(0.3),
                                      blurRadius: 10)
                                ]),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // 2. Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.palette_rounded,
                                color: Color(0xFFFFD700), size: 24),
                            const SizedBox(width: 12),
                            // LOC: Choose Your Mala
                            Text(
                              AppLocalizations.of(context)!.home_chooseMala,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Serif',
                                  letterSpacing: 0.5,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        offset: Offset(0, 2))
                                  ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // LOC: Select the sacred beads...
                        Text(
                          AppLocalizations.of(context)!.home_chooseMalaDesc,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.6),
                            fontFamily: 'Sans',
                          ),
                        ),

                        const SizedBox(height: 35),

                        // 3. Premium Horizontal List
                        SizedBox(
                          height: 160,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: MalaType.values.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 20),
                            itemBuilder: (context, index) {
                              final type = MalaType.values[index];
                              final isSelected =
                                  provider.selectedMalaType == type;

                              return GestureDetector(
                                onTap: () {
                                  provider.setSelectedMalaType(type);
                                  HapticFeedback.selectionClick();
                                },
                                child: AnimatedContainer(
                                  duration: 300.ms,
                                  curve: Curves.easeOutCubic,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    gradient: isSelected
                                        ? LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.orange.shade900
                                                  .withOpacity(0.4),
                                              Colors.deepOrange.shade900
                                                  .withOpacity(0.6),
                                            ],
                                          )
                                        : LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white.withOpacity(0.05),
                                              Colors.white.withOpacity(0.02),
                                            ],
                                          ),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFFFD700)
                                          : Colors.white.withOpacity(0.1),
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                                color: Colors.orange
                                                    .withOpacity(0.3),
                                                blurRadius: 20,
                                                offset: const Offset(0, 5))
                                          ]
                                        : [],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Bead Preview
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected
                                              ? Colors.black.withOpacity(0.3)
                                              : Colors.white.withOpacity(0.05),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                      color: Colors.orange
                                                          .withOpacity(0.4),
                                                      blurRadius: 15)
                                                ]
                                              : null,
                                        ),
                                        child: CustomPaint(
                                          size: const Size(45, 45),
                                          painter: MalaPainter(
                                            beadCount: 1,
                                            activeBeadIndex: 0,
                                            malaType: type,
                                            context: context,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 18),
                                      // Label
                                      Text(
                                        type.getDisplayName(context),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: isSelected
                                              ? FontWeight.w800
                                              : FontWeight.w500,
                                          color: isSelected
                                              ? const Color(0xFFFFD700)
                                              : Colors.white70,
                                          fontSize: 14,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // --- UI WIDGETS ---

  Widget _buildTopStreakBadge() {
    if (_isGuest) return const SizedBox(height: 40);

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestoreService.getUserStatsStream(_uid),
      builder: (context, snapshot) {
        int streak = 0;
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          streak = data['currentStreak'] ?? 0;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_fire_department_rounded,
                  color: Colors.orangeAccent, size: 20),
              const SizedBox(width: 6),
              // LOC: Streak Days
              Text("$streak ${AppLocalizations.of(context)!.misc_days}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ).animate().fadeIn().slideY(begin: -1, end: 0);
      },
    );
  }

  Widget _build3DMantraCarousel(
      List<Mantra> allMantras, Mantra selectedMantra) {
    // ... [Keep this widget's logic exactly as is] ...
    // Just minimal localization if any inside here (none found usually)
    // Just providing structure
    return SizedBox(
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _carouselController,
            itemCount: allMantras.length,
            onPageChanged: (index) {
              _onMantraSelected(allMantras[index]);
              HapticFeedback.selectionClick();
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _carouselController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_carouselController.position.haveDimensions) {
                    value = _carouselController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  } else {
                    value = (index == allMantras.indexOf(selectedMantra))
                        ? 1.0
                        : 0.7;
                  }
                  final isSelected = value > 0.9;
                  return Center(
                    child: Transform.scale(
                      scale: value.clamp(0.85, 1.0),
                      child: Opacity(
                        opacity: value.clamp(0.6, 1.0),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(colors: [
                                    Colors.orange.shade400,
                                    Colors.deepOrange
                                  ])
                                : null,
                            color: isSelected
                                ? null
                                : Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color:
                                    isSelected ? Colors.white : Colors.white24,
                                width: isSelected ? 2 : 1),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                        color: Colors.orange.withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 1)
                                  ]
                                : null,
                          ),
                          child: Text(
                            allMantras[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            left: 8,
            child: _buildNavButton(
              icon: Icons.arrow_back_ios_new_rounded,
              condition: _carouselController.hasClients &&
                  _carouselController.position.haveDimensions &&
                  (_carouselController.page ?? 0) > 0.1,
              onTap: () {
                _carouselController.previousPage(
                    duration: 300.ms, curve: Curves.easeOutCubic);
                HapticFeedback.selectionClick();
              },
            ),
          ),
          Positioned(
            right: 8,
            child: _buildNavButton(
              icon: Icons.arrow_forward_ios_rounded,
              condition: _carouselController.hasClients &&
                  _carouselController.position.haveDimensions &&
                  (_carouselController.page ?? 0) < allMantras.length - 1.1,
              onTap: () {
                _carouselController.nextPage(
                    duration: 300.ms, curve: Curves.easeOutCubic);
                HapticFeedback.selectionClick();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      {required IconData icon,
      required bool condition,
      required VoidCallback onTap}) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: condition ? 1.0 : 0.0,
      child: condition
          ? GestureDetector(
              onTap: onTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildFloatingDock(Mantra selectedMantra) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDockItem(
                  _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  _toggleMute,
                  _isMuted ? Colors.redAccent : Colors.white),
              const SizedBox(width: 20),
              _buildDockItem(Icons.palette_rounded,
                  () => _showMalaStyleSheet(context), Colors.white),
              const SizedBox(width: 20),
              _buildDockItem(Icons.info_outline_rounded,
                  () => _showMantraInfo(selectedMantra.name), Colors.white),
              const SizedBox(width: 20),
              _buildDockItem(
                  _isVibrationEnabled
                      ? Icons.vibration_rounded
                      : Icons.smartphone_rounded,
                  _toggleVibration,
                  _isVibrationEnabled ? Colors.greenAccent : Colors.grey),
              if (!_isGuest) ...[
                const SizedBox(width: 20),
                _buildDockItem(Icons.add_rounded, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider.value(
                              value: Provider.of<MantraProvider>(context,
                                  listen: false),
                              child: const CustomMantraEditor())));
                }, Colors.amber),
              ]
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 1, end: 0);
  }

  Widget _buildDockItem(IconData icon, VoidCallback onTap, Color color) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Icon(icon, color: color, size: 26),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // Get the ad for this screen
    final bannerAd = _adService.getAdForScreen(_screenName);
    final isAdLoaded =
        bannerAd != null && _adService.isAdLoadedForScreen(_screenName);

    return Consumer<MantraProvider>(builder: (context, mantraProvider, child) {
      // 1. Handle Loading State
      if (mantraProvider.isLoading || mantraProvider.selectedMantra == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final selectedMantra = mantraProvider.selectedMantra!;
      final allMantras = mantraProvider.allMantras;

      // 2. Calculate Counts
      final int displayTotal;
      final int malaProgressCounter;

      if (_isGuest) {
        displayTotal = _dbMantraCount;
        malaProgressCounter = displayTotal % 108;
      } else {
        final mantraKey = selectedMantra.id;
        final pendingForMantra = _pendingEvents.values
            .where((e) => e['mantraId'] == mantraKey)
            .length;
        displayTotal = _dbMantraCount + pendingForMantra;
        malaProgressCounter = displayTotal % 108;
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // -------------------------------------------------------------
            // SECTION A: THE ADVERTISEMENTS
            // This is kept separate at the top. Nothing can overlap it.
            // -------------------------------------------------------------
            Container(
              width: double.infinity,
              color: Colors.black, // Ensures solid background behind ad
              child: SafeArea(
                bottom: false, // Only padding for top notch
                child: isAdLoaded
                    ? Container(
                        alignment: Alignment.center,
                        width: bannerAd.size.width.toDouble(),
                        height: bannerAd.size.height.toDouble(),
                        child: AdWidget(ad: bannerAd),
                      )
                    : const SizedBox.shrink(), // Takes 0 space if no ad
              ),
            ),

            // -------------------------------------------------------------
            // SECTION B: THE APP CONTENT
            // Everything else (Background, Sparkles, Game) lives here
            // -------------------------------------------------------------
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Layer 1: Background Image
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: selectedMantra.isCustom
                        ? AppConstants.getBackgroundById(
                                selectedMantra.backgroundId!)
                            .child
                        : AnimatedBackground(
                            key: ValueKey<String>(selectedMantra.id),
                            imagePaths: AppConstants
                                .mantraImagePaths[selectedMantra.name]!,
                          ),
                  ),

                  // Layer 2: Black Gradient Overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),

                  // Layer 3: Sparkles (Confined to this Expanded area)
                  CustomPaint(
                    painter: ZenithSparkles(_particleController, _sparkles),
                  ),

                  // Layer 4: Main UI Elements
                  Column(
                    children: [
                      const SizedBox(height: 10),

                      // Streak Badge
                      _buildTopStreakBadge(),

                      const SizedBox(height: 20),

                      // Carousel Tour
                      _buildShowcase(
                        key: _keyCarousel,
                        title: AppLocalizations.of(context)!
                            .tour_home_carousel_title,
                        description: AppLocalizations.of(context)!
                            .tour_home_carousel_desc,
                        child:
                            _build3DMantraCarousel(allMantras, selectedMantra),
                      ),

                      const Spacer(),

                      // Mala Tour & Interaction
                      _buildShowcase(
                        key: _keyMala,
                        title:
                            AppLocalizations.of(context)!.tour_home_mala_title,
                        description:
                            AppLocalizations.of(context)!.tour_home_mala_desc,
                        child: GestureDetector(
                          onTap: _incrementCounter,
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              // Responsive sizing: use 85% of screen width, capped at 320
                              final screenWidth = MediaQuery.of(context).size.width;
                              final malaSize = (screenWidth * 0.85).clamp(240.0, 320.0);
                              final innerSize = malaSize * 0.75;
                              final counterFontSize = (malaSize * 0.25).clamp(56.0, 80.0);
                              return Container(
                                width: malaSize,
                                height: malaSize,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(
                                          0.2 + (_pulseController.value * 0.1)),
                                      blurRadius:
                                          40 + (_pulseController.value * 20),
                                      spreadRadius: 5,
                                    )
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    MalaWidget(
                                      activeBeadIndex: malaProgressCounter,
                                      beadCount: 109,
                                    ),
                                    Container(
                                      width: innerSize,
                                      height: innerSize,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            Colors.orange.shade400
                                                .withOpacity(0.9),
                                            Colors.deepOrange.shade900
                                                .withOpacity(0.95),
                                          ],
                                          center: const Alignment(-0.2, -0.2),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                          ),
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: const Offset(-10, -10),
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AnimatedSwitcher(
                                              duration: 150.ms,
                                              transitionBuilder:
                                                  (child, anim) =>
                                                      ScaleTransition(
                                                          scale: anim,
                                                          child: child),
                                              child: Text(
                                                (malaProgressCounter == 0 &&
                                                        displayTotal > 0)
                                                    ? "108"
                                                    : "$malaProgressCounter",
                                                key: ValueKey(
                                                    malaProgressCounter),
                                                style: TextStyle(
                                                  fontSize: counterFontSize,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  fontFamily: 'Serif',
                                                  height: 1.0,
                                                  shadows: const [
                                                    Shadow(
                                                      color: Colors.black45,
                                                      blurRadius: 10,
                                                      offset: Offset(2, 4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "${AppLocalizations.of(context)!.home_total} $displayTotal",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontSize: 16,
                                                letterSpacing: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Dock Tour
                      _buildShowcase(
                        key: _keyDock,
                        title: AppLocalizations.of(context)!
                            .tour_home_toolkit_title,
                        description: AppLocalizations.of(context)!
                            .tour_home_toolkit_desc,
                        child: _buildFloatingDock(selectedMantra),
                      ),

                      const SizedBox(height: 16),

                      // Provide safe-area bottom padding dynamically
                      SizedBox(height: MediaQuery.of(context).padding.bottom + 80),
                    ],
                  ),

                  // Layer 5: Confetti
                  // This sits at the top of the Expanded widget.
                  // Because it is in the Expanded widget, "TopCenter" here means
                  // immediately BELOW the Ad. It cannot touch the Ad.
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController: _malaConfettiController,
                      numberOfParticles: 50,
                      blastDirectionality: BlastDirectionality.explosive,
                      colors: const [
                        Colors.orange,
                        Colors.yellow,
                        Colors.white
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildShowcase({
    required GlobalKey key,
    required String title,
    required String description,
    required Widget child,
  }) {
    return Showcase(
      key: key,
      title: title,
      description: description,
      targetShapeBorder: const CircleBorder(),
      tooltipBackgroundColor: const Color(0xFF1A1A1A),
      textColor: Colors.white,
      titleTextStyle: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
      descTextStyle: const TextStyle(fontSize: 14, color: Colors.white70),
      tooltipPadding: const EdgeInsets.all(20),
      tooltipBorderRadius: BorderRadius.circular(20),
      child: child,
    );
  }
}
