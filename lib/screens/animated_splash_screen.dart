import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'package:naamjaap/screens/tour_screen.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lotusController;
  late AnimationController _auraController;
  late AnimationController _particleController;
  late AnimationController _raysController;

  late Animation<double> _lotusScale;
  late Animation<double> _logoFade;

  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // 🔊 Play Om Sound
    _player.play(
      AssetSource("audio/om_chant.mp3"),
      volume: 0.35,
    );

    // 🌸 LOTUS BLOOM
    _lotusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _lotusScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _lotusController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _lotusController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    // 🌟 ROTATING HALO
    _auraController =
        AnimationController(vsync: this, duration: const Duration(seconds: 12))
          ..repeat();

    // ✨ FLOATING PARTICLES
    _particleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();

    // 🌞 RADIATING RAYS (new)
    _raysController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    _lotusController.forward();

    _lotusController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateAfter();
      }
    });
  }

  @override
  void dispose() {
    _lotusController.dispose();
    _auraController.dispose();
    _particleController.dispose();
    _raysController.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _navigateAfter() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenTour =
        prefs.getBool(AppConstants.prefsKeyHasSeenTour) ?? false;

    if (!hasSeenTour) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TourScreen()),
      );
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => MantraProvider(user.uid),
            child: MainAppScreens(user: user),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _lotusController,
          _auraController,
          _particleController,
          _raysController,
        ]),
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Colors.amber.shade50,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // ✨ FLOATING PARTICLES
                  CustomPaint(
                    painter: ParticlePainter(_particleController.value),
                    size: const Size(300, 300),
                  ),

                  // 🌞 DIVINE ROTATING RAYS (NEW)
                  CustomPaint(
                    painter: RaysPainter(_raysController.value),
                    size: const Size(260, 260),
                  ),

                  // 🌟 SOFT ROTATING HALO
                  Transform.rotate(
                    angle: _auraController.value * 2 * pi,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.orange.shade300.withOpacity(0.18),
                            Colors.deepOrange.shade200.withOpacity(0.04),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 🌸 LOTUS BLOOM ANIMATION
                  Transform.scale(
                    scale: _lotusScale.value,
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: LotusPainter(_lotusScale.value),
                    ),
                  ),

                  // 🕉️ LOGO FADE-IN
                  FadeTransition(
                    opacity: _logoFade,
                    child: Image.asset(
                      'assets/images/app_logo_simple.png',
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 🌸 LOTUS (same as before)
class LotusPainter extends CustomPainter {
  final double p;
  LotusPainter(this.p);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final flowerPaint = Paint()..style = PaintingStyle.fill;
    const petalCount = 8;

    for (int i = 0; i < petalCount; i++) {
      final ang = (i / petalCount) * 2 * pi;
      final len = radius * p;

      final path = Path();
      path.moveTo(center.dx, center.dy);

      final p1 = Offset(center.dx + len * 0.5 * cos(ang - 0.3),
          center.dy + len * 0.5 * sin(ang - 0.3));
      final p2 = Offset(center.dx + len * cos(ang), center.dy + len * sin(ang));
      final p3 = Offset(center.dx + len * 0.5 * cos(ang + 0.3),
          center.dy + len * 0.5 * sin(ang + 0.3));

      flowerPaint.shader = ui.Gradient.radial(
        p2,
        len,
        [Colors.orange.shade200, Colors.pink.shade300],
      );

      path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
      path.quadraticBezierTo(p3.dx, p3.dy, center.dx, center.dy);

      canvas.drawPath(path, flowerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ✨ FLOATING GOLDEN PARTICLES
class ParticlePainter extends CustomPainter {
  final double progress;
  ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = Random(10);
    final paint = Paint()..color = Colors.orange.shade300.withOpacity(0.45);

    for (int i = 0; i < 24; i++) {
      final x = rnd.nextDouble() * size.width;
      final y =
          (rnd.nextDouble() * size.height + progress * -200) % size.height;
      final r = rnd.nextDouble() * 3 + 1;

      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 🌞 RADIANT RAYS BEHIND LOTUS (NEW)
class RaysPainter extends CustomPainter {
  final double progress;
  RaysPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = Colors.deepOrange.shade200.withOpacity(0.32);

    const rayCount = 20;
    final radius = size.width / 2;

    for (int i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * pi + progress * 2 * pi;

      final start = Offset(
        center.dx + radius * 0.55 * cos(angle),
        center.dy + radius * 0.55 * sin(angle),
      );

      final end = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
