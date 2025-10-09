import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BodhiTreePainter extends CustomPainter {
  final int leafCount;

  BodhiTreePainter({required this.leafCount});

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    // Background sky with stars
    final skyPaint = Paint()..color = const Color(0xFF0d47a1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);
    _drawStars(canvas, size, 100);

    final trunkPaint = Paint()
      ..color = Colors.brown.shade800
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final leafPaint = Paint()
      ..shader = ui.Gradient.radial(
        Offset.zero,
        5,
        [Colors.yellow.shade600, Colors.green.shade800],
      );

    // Tree starts from the bottom center
    final startPoint = Offset(size.width / 2, size.height);

    // Use a seeded random for deterministic "randomness"
    final random = Random(1);

    // Draw the main trunk and branches
    _drawBranch(canvas, startPoint, -pi / 2, 80, 10, trunkPaint, random);

    // Draw the leaves
    _drawLeaves(
        canvas, startPoint, -pi / 2, 80, 10, leafPaint, random, leafCount);
  }

  void _drawStars(Canvas canvas, Size size, int count) {
    final starPaint = Paint()..color = Colors.white.withAlpha(190);
    final random = Random(0);
    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y =
          random.nextDouble() * size.height * 0.8; // Only in the upper part
      final radius = random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
  }

  void _drawBranch(Canvas canvas, Offset start, double angle, double length,
      double thickness, Paint paint, Random random) {
    if (length < 10) return;

    final end = Offset(
      start.dx + length * cos(angle),
      start.dy + length * sin(angle),
    );
    paint.strokeWidth = thickness;
    canvas.drawLine(start, end, paint);

    final newLength = length * (0.7 + random.nextDouble() * 0.1);
    final newThickness = thickness * 0.7;

    // Create 2 to 3 new branches
    final branches = 2 + random.nextInt(2);
    for (int i = 0; i < branches; i++) {
      final angleOffset = (random.nextDouble() - 0.5) * (pi / 2);
      _drawBranch(canvas, end, angle + angleOffset, newLength, newThickness,
          paint, random);
    }
  }

  void _drawLeaves(Canvas canvas, Offset start, double angle, double length,
      double thickness, Paint paint, Random random, int leavesToDraw) {
    if (length < 20 || leavesToDraw <= 0) return;

    final end = Offset(
      start.dx + length * cos(angle),
      start.dy + length * sin(angle),
    );

    // Draw a leaf at the end of some branches
    if (random.nextDouble() > 0.5) {
      canvas.save();
      canvas.translate(end.dx, end.dy);
      canvas.drawCircle(Offset.zero, 4 + random.nextDouble() * 2, paint);
      canvas.restore();
      leavesToDraw--;
    }

    final newLength = length * (0.7 + random.nextDouble() * 0.1);
    final newThickness = thickness * 0.7;
    final branches = 2 + random.nextInt(2);
    for (int i = 0; i < branches; i++) {
      final angleOffset = (random.nextDouble() - 0.5) * (pi / 2);
      _drawLeaves(canvas, end, angle + angleOffset, newLength, newThickness,
          paint, random, leavesToDraw);
    }
  }

  @override
  bool shouldRepaint(covariant BodhiTreePainter oldDelegate) {
    return oldDelegate.leafCount != leafCount;
  }
}
