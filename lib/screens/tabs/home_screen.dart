import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:naamjaap/services/achievements_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:naamjaap/widgets/mala_widget.dart';
import 'package:naamjaap/widgets/quote_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final AchievementsService _achievementsService = AchievementsService();
  late ConfettiController _milestoneConfettiController;
  late ConfettiController _malaConfettiController;

  // State variables
  String _selectedMantra = AppConstants.hareKrishna;
  bool _isMuted = false;
  bool _isVibrationEnabled = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _uid = FirebaseAuth.instance.currentUser!.uid;
    _milestoneConfettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _malaConfettiController =
        ConfettiController(duration: const Duration(seconds: 3));

    _loadPreferences();

    _playerStateSubscription =
        _audioService.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => _isPlaying = state == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _milestoneConfettiController.dispose();
    _malaConfettiController.dispose();
    _playerStateSubscription.cancel();
    _audioService.dispose();
    super.dispose();
  }

  // --- Helper Methods ---

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedMantra =
        prefs.getString(AppConstants.prefsKeySelectedMantra) ??
            AppConstants.hareKrishna;
    final isVibrationEnabled =
        prefs.getBool(AppConstants.prefsKeyVibrationEnabled) ?? true;
    final isMuted = prefs.getBool(AppConstants.prefsKeyMute) ?? false;
    if (mounted) {
      setState(() {
        _selectedMantra = selectedMantra;
        _isMuted = isMuted;
      });
      await _audioService.setMuted(_isMuted);
    }
  }

  void _onMantraSelected(String mantra) async {
    if (_isPlaying) await _audioService.stop();
    setState(() {
      _selectedMantra = mantra;
    });
    await _saveSelectedMantra(mantra);
  }

  // This function now takes the current total count from the StreamBuilder.
  void _incrementCounter(int currentTotalCount) {
    if (_isVibrationEnabled) {
      HapticFeedback.lightImpact();
    }
    final mantraKey = _selectedMantra.toLowerCase().replaceAll(' ', '_');
    _firestoreService.updateJappCount(_uid, mantraKey);
    _achievementsService.checkAndAwardBadges(_uid);

    final newTotal = currentTotalCount + 1;
    if (newTotal > 0 && newTotal % 108 == 0) {
      _malaConfettiController.play();
    } else if (newTotal > 0 && newTotal % 500 == 0) {
      _milestoneConfettiController.play();
    }

    if (!_isPlaying) {
      final audioPath = AppConstants.mantraAudioPaths[_selectedMantra]!;
      _audioService.play(audioPath);
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

  @override
  Widget build(BuildContext context) {
    // We return to the simple and reliable StreamBuilder as the root.
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestoreService.getUserStatsStream(_uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final int streakCount = userData['currentStreak'] ?? 0;
        final jappsMap = userData['japps'] as Map<String, dynamic>? ?? {};
        final mantraKey = _selectedMantra.toLowerCase().replaceAll(' ', '_');
        final int totalMantraCount = jappsMap[mantraKey] as int? ?? 0;
        final int malaProgressCounter = totalMantraCount % 108;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Layer 1 & 2: Background and Overlay
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              child: Container(
                key: ValueKey<String>(_selectedMantra),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        AppConstants.mantraImagePaths[_selectedMantra]!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),

            // Layer 3: Main UI Scaffold
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Column(
                  children: [
                    // Top UI Elements
                    StreamBuilder<DocumentSnapshot>(
                      stream: _firestoreService.getDailyQuoteStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          // Don't show anything if there's no quote yet
                          return const SizedBox.shrink();
                        }
                        final quoteData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return QuoteCard(
                          text: quoteData['text'] ?? 'Loading wisdom...',
                          source: quoteData['source'] ?? '',
                        ).animate().fadeIn(duration: 600.ms);
                      },
                    ),

                    Chip(
                      avatar: Icon(Icons.local_fire_department,
                          color: Colors.orange.shade800),
                      label: Text('$streakCount Day Streak',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      backgroundColor: Colors.white.withOpacity(0.8),
                      elevation: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        height: 50,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children:
                                RemoteConfigService().mantras.map((mantra) {
                              final isSelected = _selectedMantra == mantra;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                child: GestureDetector(
                                  onTap: () => _onMantraSelected(mantra),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.orange.withOpacity(0.9)
                                          : Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: isSelected
                                              ? Colors.orange.shade300
                                              : Colors.white.withOpacity(0.5),
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
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(_isVibrationEnabled
                                ? Icons.vibration
                                : Icons.mobile_off_rounded),
                            iconSize:
                                28, // Slightly smaller for a cleaner look at the top
                            color: Colors.white.withOpacity(0.9),
                            onPressed: _toggleVibration,
                            tooltip: _isVibrationEnabled
                                ? 'Vibration On'
                                : 'Vibration Off',
                          ),
                          IconButton(
                            icon: Icon(
                                _isMuted ? Icons.volume_off : Icons.volume_up),
                            iconSize: 28,
                            color: Colors.white.withOpacity(0.9),
                            onPressed: _toggleMute,
                            tooltip: _isMuted ? 'Sound Off' : 'Sound On',
                          ),
                        ],
                      ),
                    ),

                    // Center UI Elements in an Expanded Stack
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

                          // Counter Box
                          GestureDetector(
                            onTap: () => _incrementCounter(totalMantraCount),
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
                                          .withOpacity(0.7),
                                      spreadRadius: 2,
                                      blurRadius: 20,
                                      offset: const Offset(0, 10)),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
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
                                                totalMantraCount > 0)
                                            ? "108"
                                            : (malaProgressCounter).toString(),
                                        key: ValueKey<int>(totalMantraCount),
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
                                      'Total: ${totalMantraCount.toString()}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
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

                    // Bottom UI Elements
                    Text('Tap to Chant',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Layer 4 & 5: The Confetti Animations
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _milestoneConfettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [Colors.green, Colors.blue, Colors.pink],
                gravity: 0.1,
                emissionFrequency: 0.03,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _malaConfettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.orange,
                  Colors.amber,
                  Colors.yellow,
                  Colors.white
                ],
                gravity: 0.2,
                emissionFrequency: 0.08,
                numberOfParticles: 30,
                maxBlastForce: 20,
                minBlastForce: 10,
              ),
            ),
          ],
        );
      },
    );
  }
}
