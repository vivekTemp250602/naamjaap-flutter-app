import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BodhiTreePainter extends CustomPainter {
  final int leafCount;
  final List<Offset> _leafSockets = [];
  bool _treeGenerated = false;

  BodhiTreePainter({required this.leafCount});

  @override
  void paint(Canvas canvas, Size size) {
    final skyPaint = Paint()..color = const Color(0xFF0d47a1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), skyPaint);
    _drawStars(canvas, size, 150 + (leafCount ~/ 10));

    final trunkPaint = Paint()
      ..color = Colors.brown.shade800
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    final leafPaint = Paint()
      ..shader = ui.Gradient.radial(
        Offset.zero,
        5,
        [
          Colors.yellow.shade400.withAlpha(190),
          Colors.green.shade600.withAlpha(190)
        ],
      );
    final leafGlowPaint = Paint()
      ..color = Colors.yellow.withAlpha(100)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);

    canvas.save();
    canvas.translate(size.width / 2, size.height);

    if (!_treeGenerated) {
      final random = Random(1337);
      _generateTreeAndLeafSockets(
          canvas, const Offset(0, 0), -pi / 2, 120, 12, trunkPaint, random);
      _treeGenerated = true;
      _leafSockets.shuffle(random);
    } else {
      final random = Random(1337);
      _drawBranch(
          canvas, const Offset(0, 0), -pi / 2, 120, 12, trunkPaint, random);
    }

    for (int i = 0; i < leafCount && i < _leafSockets.length; i++) {
      final offset = _leafSockets[i];
      canvas.drawCircle(offset, 6, leafGlowPaint);
      canvas.drawCircle(offset, 4, leafPaint);
    }

    canvas.restore();
  }

  void _drawStars(Canvas canvas, Size size, int count) {
    final starPaint = Paint()..color = Colors.white.withAlpha(190);
    final random = Random(0);
    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.8;
      final radius = random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
  }

  // A simple recursive function to draw the branches without collecting sockets.
  void _drawBranch(Canvas canvas, Offset start, double angle, double length,
      double thickness, Paint paint, Random random) {
    if (length < 5) return;
    final end =
        Offset(start.dx + length * cos(angle), start.dy + length * sin(angle));
    paint.strokeWidth = thickness;
    canvas.drawLine(start, end, paint);
    final newLength = length * 0.75;
    final newThickness = thickness * 0.6;
    _drawBranch(canvas, end, angle - 0.4 + (random.nextDouble() * 0.2),
        newLength, newThickness, paint, random);
    _drawBranch(canvas, end, angle + 0.4 - (random.nextDouble() * 0.2),
        newLength, newThickness, paint, random);
  }

  // The Master Gardener function that draws the tree AND collects the leaf sockets.
  void _generateTreeAndLeafSockets(Canvas canvas, Offset start, double angle,
      double length, double thickness, Paint paint, Random random) {
    // Base case: If the branch is too small, it's a "twig".
    // We add its endpoint as a potential leaf socket and stop.
    if (length < 15) {
      _leafSockets.add(start);
      return;
    }

    final end =
        Offset(start.dx + length * cos(angle), start.dy + length * sin(angle));
    paint.strokeWidth = thickness;
    canvas.drawLine(start, end, paint);

    final newLength = length * 0.75;
    final newThickness = thickness * 0.6;

    _generateTreeAndLeafSockets(
        canvas,
        end,
        angle - 0.4 + (random.nextDouble() * 0.2),
        newLength,
        newThickness,
        paint,
        random);
    _generateTreeAndLeafSockets(
        canvas,
        end,
        angle + 0.4 - (random.nextDouble() * 0.2),
        newLength,
        newThickness,
        paint,
        random);
  }

  @override
  bool shouldRepaint(covariant BodhiTreePainter oldDelegate) {
    return oldDelegate.leafCount != leafCount;
  }
}
