import 'dart:math';
import 'package:flutter/material.dart';

class MalaPainter extends CustomPainter {
  final int beadCount;
  final int activeBeadIndex;

  MalaPainter({required this.beadCount, required this.activeBeadIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius =
        size.width / 2 - 25; // More padding for the glow and larger beads

    // --- 1. Define all our new, high-contrast paints ---

    // A thicker, more prominent connecting string
    final stringPaint = Paint()
      ..color = Colors.orange.shade900.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0; // MODIFIED: Thicker string

    // A subtle, warm glow effect for the beads
    final glowPaint = Paint()
      ..color = Colors.amber.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    // The beautiful gradient for a standard, inactive golden bead
    final beadGradient = RadialGradient(
      colors: [Colors.amber.shade200, Colors.deepOrange.shade900],
      center:
          const Alignment(-0.5, -0.5), // Moves the highlight to the top-left
      radius: 0.8,
    );
    final beadPaint = Paint()
      ..shader = beadGradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    // A brighter, more luminous gradient for the currently active bead
    final activeBeadGradient = RadialGradient(
      colors: [Colors.yellow.shade400, Colors.amber.shade600],
      center: const Alignment(-0.5, -0.5),
    );
    final activeBeadPaint = Paint()
      ..shader = activeBeadGradient
          .createShader(Rect.fromCircle(center: center, radius: radius));

    // A special, solid gold paint for the main "Guru" bead
    final meruBeadPaint = Paint()..color = Colors.amber.shade700;

    // --- 2. Draw the components in the correct order (bottom to top) ---

    // First, draw the connecting string.
    canvas.drawCircle(center, radius, stringPaint);

    // Loop through and draw all 108 beads.
    for (int i = 0; i < beadCount; i++) {
      final angle = (i / beadCount) * 2 * pi - (pi / 2);
      final beadPosition = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      // We skip drawing bead #0 here; the Meru bead is drawn last.
      if (i != 0) {
        final isBeadActive = i == activeBeadIndex;

        // MODIFIED: Bead radius is now much larger for better visibility
        const beadRadius = 12.0;

        // First, draw the soft glow behind the bead
        canvas.drawCircle(beadPosition, beadRadius, glowPaint);
        // Then, draw the main bead on top of the glow
        canvas.drawCircle(beadPosition, beadRadius,
            isBeadActive ? activeBeadPaint : beadPaint);
      }
    }

    // Finally, draw the Meru (Guru) bead on top of everything.
    final meruPosition = Offset(center.dx, center.dy - radius);
    const meruRadius = 18.0; // MODIFIED: A much larger Guru bead

    // Draw the glow and the main bead for the Meru
    canvas.drawCircle(meruPosition, meruRadius, glowPaint);
    canvas.drawCircle(meruPosition, meruRadius, meruBeadPaint);
  }

  @override
  bool shouldRepaint(covariant MalaPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex;
  }
}
