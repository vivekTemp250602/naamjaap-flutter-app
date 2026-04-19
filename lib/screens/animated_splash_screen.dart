import 'dart:async';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/providers/locale_provider.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/language_selector_page.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/services/version_check_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  // Controllers
  late AnimationController _mainSequence; // Controls entry flow
  late AnimationController _rotateController; // Rotating halo
  late AnimationController _pulseController; // Breathing effect
  late AnimationController _particleController; // Floating dust

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // 1. Play Divine Sound
    _player.play(AssetSource("audio/om_chant.mp3"), volume: 0.6);

    // 2. Setup Animations
    _mainSequence = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Total splash duration
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _mainSequence.forward();

    // 3. Navigation Listener (Trigger logic when animation is done)
    _mainSequence.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkVersionAndNavigate(); // Changed function call
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _mainSequence.dispose();
    _rotateController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    _player.dispose();
    super.dispose();
  }

  // --- NEW: VERSION CHECK + NAVIGATION ---
  Future<void> _checkVersionAndNavigate() async {
    if (!mounted) return;

    // 1. Perform Version Check (This might show a blocking dialog)
    await VersionCheckService.checkVersion(context);

    // 2. Verify if we can proceed (Double check logic)
    // If the dialog was shown and user didn't update, they are stuck there (good).
    // If the dialog was NOT shown, we proceed.

    // We fetch info again quickly to be safe
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final int currentCode = int.parse(packageInfo.buildNumber);
    final int minCode = RemoteConfigService().minRequiredVersionCode;

    // Only navigate if version is valid
    if (currentCode >= minCode) {
      await _navigateAfter();
    }
  }

  Future<void> _navigateAfter() async {
    // 1. Get Dependencies
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    if (!mounted) return;

    Widget nextScreen;

    // 2. Logic Flow
    if (!localeProvider.isLocaleSet) {
      // A. First Run: Select Language
      nextScreen = const LanguageSelectorPage(uid: "", isFirstRun: true);
    } else {
      // B. Language is set: Check Auth
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // Not logged in -> Login Screen
        nextScreen = const LoginScreen();
      } else {
        // Logged in -> Main App
        nextScreen = ChangeNotifierProvider(
          create: (_) => MantraProvider(user.uid),
          child: MainAppScreens(user: user),
        );
      }
    }

    // 3. Navigate
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => nextScreen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 1. DIVINE BACKGROUND (Radial Glow)
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center:
                        const Alignment(0, -0.2), // Light centered behind head
                    radius: 1.2 + (_pulseController.value * 0.1),
                    colors: [
                      const Color(0xFFFFCC80), // Bright Gold Center
                      const Color(0xFFFF8C00), // Saffron
                      const Color(0xFF5D1049), // Deep Spiritual Purple
                      const Color(0xFF000000), // Void
                    ],
                    stops: const [0.0, 0.3, 0.6, 1.0],
                  ),
                ),
              );
            },
          ),

          // 2. ROTATING SACRED RAYS (The Halo)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            child: CustomPaint(
              painter: DivineRaysPainter(_rotateController),
              size: const Size(400, 400),
            ),
          ),

          // 3. RISING GOLDEN DUST
          CustomPaint(
            painter: GoldenDustPainter(_particleController),
            size: Size.infinite,
          ),

          // 4. THE DIVINE FIGURE (Premanand Ji)
          Positioned(
            bottom: 0, // Anchored to bottom
            left: 0,
            right: 0,
            top: 100, // Push down slightly
            child: AnimatedBuilder(
              animation: _mainSequence,
              builder: (context, child) {
                // Intro Animation: Slide Up + Fade In
                final slideVal = CurvedAnimation(
                  parent: _mainSequence,
                  curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
                ).value;

                // Continuous Breathing
                final breathVal = _pulseController.value * 0.03;

                return Transform.scale(
                  scale: 0.9 +
                      (0.1 * slideVal) +
                      breathVal, // Grow in, then breathe
                  child: Opacity(
                    opacity: slideVal,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/blessing_figure.webp', // USER: Ensure this file exists!
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 5. APP TITLE (Overlay at bottom)
          Positioned(
            bottom: 60,
            child: AnimatedBuilder(
              animation: _mainSequence,
              builder: (context, child) {
                final val = CurvedAnimation(
                        parent: _mainSequence,
                        curve: const Interval(0.5, 1.0, curve: Curves.easeOut))
                    .value;

                return Opacity(
                  opacity: val,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - val)),
                    child: Column(
                      children: [
                        Text(
                          "NAAM JAAP",
                          style: TextStyle(
                            fontFamily: 'Serif',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  color: Colors.orange.shade900,
                                  blurRadius: 20),
                              const Shadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                  offset: Offset(2, 2))
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Chant. Connect. Transcend.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1.5,
                            shadows: const [
                              Shadow(color: Colors.black, blurRadius: 4)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- PAINTERS ---

// 🌞 Rotating Rays of Light
class DivineRaysPainter extends CustomPainter {
  final Animation<double> animation;
  DivineRaysPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // Rotate the canvas
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(animation.value * 2 * math.pi);

    const rayCount = 12;
    for (int i = 0; i < rayCount; i++) {
      // Draw a ray
      final path = Path();
      path.moveTo(0, 0);
      path.lineTo(-15, -size.width); // Wide at ends
      path.lineTo(15, -size.width);
      path.close();
      canvas.drawPath(path, paint);
      canvas.rotate(2 * math.pi / rayCount);
    }
    canvas.restore();

    // Inner Glow Circle
    final glowPaint = Paint()
      ..shader = RadialGradient(
              colors: [Colors.orange.withOpacity(0.4), Colors.transparent])
          .createShader(Rect.fromCircle(center: center, radius: 100));
    canvas.drawCircle(center, 100, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ✨ Rising Golden Dust
class GoldenDustPainter extends CustomPainter {
  final Animation<double> animation;
  final List<_Particle> particles = [];

  GoldenDustPainter(this.animation) : super(repaint: animation) {
    final rnd = math.Random(42);
    for (int i = 0; i < 40; i++) {
      particles.add(_Particle(rnd));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      p.update(size.height, animation.value);
      final paint = Paint()
        ..color = Colors.amber.withOpacity(p.opacity * 0.8)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2); // Glowy dots

      canvas.drawCircle(Offset(p.x * size.width, p.y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Particle {
  late double x;
  late double y;
  late double size;
  late double opacity;
  late double speed;

  _Particle(math.Random rnd) {
    reset(rnd, true);
  }

  void reset(math.Random rnd, bool startRandomY) {
    x = rnd.nextDouble();
    y = startRandomY ? rnd.nextDouble() * 1000 : 1000; // Start below screen
    size = 1.0 + rnd.nextDouble() * 3;
    opacity = 0.2 + rnd.nextDouble() * 0.6;
    speed = 0.5 + rnd.nextDouble() * 1.5;
  }

  void update(double height, double time) {
    y -= speed;
    if (y < -50) {
      // Reset to bottom
      y = height + 50;
      x = math.Random().nextDouble() * 1.0; // New random X
    }
  }
}
