import 'dart:math';
import 'package:flutter/material.dart';

class MalaPainter extends CustomPainter {
  final int beadCount;
  final int activeBeadIndex;

  MalaPainter({required this.beadCount, required this.activeBeadIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20; // Padding for shadows

    // --- 1. Define all our paints ---

    final stringPaint = Paint()
      ..color = Colors.brown.shade900.withOpacity(0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final beadHolePaint = Paint()..color = Colors.black.withOpacity(0.5);

    // --- 2. Draw the connecting string FIRST ---
    canvas.drawCircle(center, radius, stringPaint);

    // --- 3. Loop and draw each bead with details ---
    for (int i = 0; i < beadCount; i++) {
      final angle = (i / beadCount) * 2 * pi - (pi / 2);
      final beadPosition = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      // We skip drawing bead #0 here; the Meru bead is drawn last.
      if (i != 0) {
        final isBeadActive = i == activeBeadIndex;

        // Define the gradient based on whether the bead is active
        final beadGradient = RadialGradient(
          // MODIFIED: A warmer, more balanced brown for the inactive beads.
          colors: isBeadActive
              ? [
                  Colors.amber.shade300,
                  Colors.orange.shade800
                ] // Rich gold for active
              : [
                  Colors.brown.shade400,
                  Colors.brown.shade700
                ], // A beautiful, natural wood look
          center: const Alignment(0.3, -0.3),
          radius: 0.8,
        );

        final beadPaint = Paint()
          ..shader = beadGradient
              .createShader(Rect.fromCircle(center: beadPosition, radius: 10));

        // Draw the shadow for depth
        final path = Path()
          ..addOval(Rect.fromCircle(center: beadPosition, radius: 10));
        canvas.drawShadow(path, Colors.black.withOpacity(0.5), 4.0, true);

        // Draw the main bead
        canvas.drawCircle(beadPosition, 10, beadPaint);

        // Draw the string holes for realism
        final holeOffset = Offset.fromDirection(angle + (pi / 2), 1.5);
        canvas.drawCircle(beadPosition - holeOffset, 1.5, beadHolePaint);
        canvas.drawCircle(beadPosition + holeOffset, 1.5, beadHolePaint);
      }
    }

    // --- 4. Draw the special Guru Bead (Meru) LAST so it's on top ---
    final meruPosition = Offset(center.dx, center.dy - radius);
    final meruGradient = RadialGradient(
      // MODIFIED: A richer, but not overly dark, gradient for the Guru bead.
      colors: [Colors.brown.shade600, Colors.black.withOpacity(0.8)],
      center: const Alignment(0.3, -0.3),
    );
    final meruPaint = Paint()
      ..shader = meruGradient
          .createShader(Rect.fromCircle(center: meruPosition, radius: 15));

    // Meru Shadow
    final meruPath = Path()
      ..addOval(Rect.fromCircle(center: meruPosition, radius: 15));
    canvas.drawShadow(meruPath, Colors.black.withOpacity(0.7), 6.0, true);

    // Meru Bead
    canvas.drawCircle(meruPosition, 15, meruPaint);

    // Meru String Holes
    canvas.drawCircle(
        Offset(meruPosition.dx - 2, meruPosition.dy), 2, beadHolePaint);
    canvas.drawCircle(
        Offset(meruPosition.dx + 2, meruPosition.dy), 2, beadHolePaint);

    // Meru decorative cap
    final capPaint = Paint()..color = Colors.amber.shade700;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(meruPosition.dx, meruPosition.dy - 16),
            width: 12,
            height: 4),
        capPaint);
  }

  @override
  bool shouldRepaint(covariant MalaPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex;
  }
}
