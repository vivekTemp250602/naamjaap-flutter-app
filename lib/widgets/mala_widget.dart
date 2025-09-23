import 'dart:math';
import 'package:flutter/material.dart';

class MalaPainter extends CustomPainter {
  final int beadCount;
  final int activeBeadIndex;

  MalaPainter({required this.beadCount, required this.activeBeadIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Padding to accommodate the new outer border
    final radius = size.width / 2 - 25;

    // --- 1. Define all our paints ---

    // A paint for the thick outer border with a shimmering gradient
    final borderGradient = SweepGradient(
      center: Alignment.center,
      colors: [
        Colors.brown.shade900,
        Colors.amber.shade600,
        Colors.brown.shade900,
      ],
      stops: const [0.0, 0.5, 1.0],
    );
    final borderPaint = Paint()
      ..shader = borderGradient
          .createShader(Rect.fromCircle(center: center, radius: radius + 15))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // The thickness of the border

    // A subtle connecting string
    final stringPaint = Paint()
      ..color = Colors.brown.shade800.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // A paint for the "ghost" beads that show the full path
    final ghostBeadPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // A beautiful, natural wood gradient for the completed beads
    final beadGradient = RadialGradient(
      colors: [Colors.brown.shade400, Colors.brown.shade700],
      center: const Alignment(0.3, -0.3),
    );
    final beadPaint = Paint()
      ..shader = beadGradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    // A special, solid gold paint for the main "Guru" bead
    final meruBeadPaint = Paint()..color = Colors.amber.shade700;

    // --- 2. Draw the components in the correct order (bottom to top) ---

    // Draw the thick border FIRST, so it's behind everything.
    canvas.drawCircle(center, radius + 15, borderPaint);

    // Now, draw the connecting string.
    canvas.drawCircle(center, radius, stringPaint);

    // Draw the full "ghost" mala in the background.
    for (int i = 0; i < beadCount; i++) {
      final angle = (i / beadCount) * 2 * pi - (pi / 2);
      final beadPosition = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      // The Meru bead doesn't need a ghost as it's always visible.
      if (i != 0) {
        canvas.drawCircle(beadPosition, 8, ghostBeadPaint);
      }
    }

    // Now, only draw the completed beads on top of the ghosts.
    // The loop now only goes up to the current active bead.
    for (int i = 1; i <= activeBeadIndex; i++) {
      final angle = (i / beadCount) * 2 * pi - (pi / 2);
      final beadPosition = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      // Draw the solid, completed bead
      canvas.drawCircle(beadPosition, 8, beadPaint);
    }

    // Finally, draw the Meru (Guru) bead on top of everything.
    final meruPosition = Offset(center.dx, center.dy - radius);
    canvas.drawCircle(meruPosition, 12, meruBeadPaint);
  }

  @override
  bool shouldRepaint(covariant MalaPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex;
  }
}
