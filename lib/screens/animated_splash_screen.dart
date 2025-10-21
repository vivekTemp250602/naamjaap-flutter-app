import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'dart:math';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _lotusAnimation;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    _lotusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOut)),
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateUser();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateUser() {
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainAppScreens(user: user)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: const Size(200, 200),
                    painter: LotusPainter(_lotusAnimation.value),
                  ),
                  FadeTransition(
                    opacity: _logoAnimation,
                    child: Image.asset(
                      "assets/images/app_logo_simple.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LotusPainter extends CustomPainter {
  final double progress;

  LotusPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final petalCount = 8;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < petalCount; i++) {
      final angle = (i / petalCount) * 2 * pi;
      final petalLength = radius * progress;

      final path = Path();
      path.moveTo(center.dx, center.dy);

      final p1 = Offset(
        center.dx + petalLength * 0.5 * cos(angle - 0.3),
        center.dy + petalLength * 0.5 * sin(angle - 0.3),
      );
      final p2 = Offset(
        center.dx + petalLength * cos(angle),
        center.dy + petalLength * sin(angle),
      );
      final p3 = Offset(
        center.dx + petalLength * 0.5 * cos(angle + 0.3),
        center.dy + petalLength * 0.5 * sin(angle + 0.3),
      );

      paint.shader = ui.Gradient.radial(
        p2,
        petalLength,
        [Colors.orange.shade200, Colors.pink.shade300],
      );

      path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
      path.quadraticBezierTo(p3.dx, p3.dy, center.dx, center.dy);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
