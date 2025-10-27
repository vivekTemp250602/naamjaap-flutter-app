import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MalaPainter extends CustomPainter {
  final int beadCount;
  final int activeBeadIndex;

  MalaPainter({required this.beadCount, required this.activeBeadIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 25;
    final beadRadius = 10.0;
    final guruBeadRadius = 18.0;

    // --- 1. Define all our paints ---
    final threadPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx - 5, 0),
        Offset(center.dx + 5, 0),
        [Colors.red.shade900, Colors.red.shade700],
      )
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Paint for the standard Rudraksha beads
    Paint rudrakshaPaint(Offset beadCenter) => Paint()
      ..shader = ui.Gradient.radial(
        beadCenter,
        beadRadius * 1.5,
        [Colors.brown.shade200, Colors.brown.shade700, Colors.brown.shade900],
        [0.0, 0.6, 1.0],
        TileMode.clamp,
      );

    // Paint for the BIG WHITE TRAVERSING BEAD
    final whiteActiveBeadPaint = Paint()
      ..shader = ui.Gradient.radial(
        // This shader is applied when drawing
        Offset.zero,
        beadRadius * 2.5,
        [Colors.white, Colors.white70, Colors.lightBlue.shade100],
        [0.0, 0.7, 1.0],
      )
      ..maskFilter = const MaskFilter.blur(
          BlurStyle.normal, 2.0); // Slight blur for a soft edge

    final texturePaint = Paint()
      ..color = Colors.black.withAlpha(70)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    // --- 2. Draw the Sacred Thread ---
    final path = Path();
    const gapAngle = 0.25;
    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2 + gapAngle,
      2 * pi - (gapAngle * 2),
    );
    canvas.drawPath(path, threadPaint);

    // --- 3. Draw the 108 Beads ---
    for (int i = 0; i < beadCount; i++) {
      final angle =
          (i / beadCount) * (2 * pi - (gapAngle * 2)) + (-pi / 2 + gapAngle);
      final beadCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      if (i == activeBeadIndex) {
        // --- DRAW THE BIG WHITE BEAD INSTEAD OF GLOWING ---
        const bigBeadRadius =
            16.0; // Define a new, larger radius for the active bead

        // 1. Apply a wide, blurred halo effect (optional, but enhances the "big" feel)
        final haloPaint = Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
        canvas.drawCircle(beadCenter, bigBeadRadius + 5, haloPaint);

        // 2. Draw the main big white bead
        // Since the shader requires the center, we must create a new Paint instance
        // or apply the shader before drawing if possible. Since the shader uses Offset.zero
        // above, we use `canvas.drawCircle` with the correct center and a new paint
        Paint finalWhitePaint = Paint()
          ..shader = ui.Gradient.radial(
            beadCenter,
            bigBeadRadius * 1.5,
            [Colors.white, Colors.white70, Colors.lightBlue.shade100],
            [0.0, 0.7, 1.0],
          )
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

        canvas.drawCircle(beadCenter, bigBeadRadius, finalWhitePaint);

        // Skip drawing the small rudraksha bead underneath
      } else {
        // Draw the standard small rudraksha bead
        _drawBead(canvas, beadCenter, beadRadius, rudrakshaPaint(beadCenter),
            texturePaint);
      }
    }

    // --- 4. Draw the Guru Bead & Tassel ---
    final guruBeadCenter = Offset(center.dx, center.dy - radius);
    _drawBead(canvas, guruBeadCenter, guruBeadRadius,
        rudrakshaPaint(guruBeadCenter), texturePaint);
    _drawTassel(canvas, guruBeadCenter, guruBeadRadius, threadPaint);
  }

  void _drawBead(Canvas canvas, Offset center, double radius, Paint beadPaint,
      Paint texturePaint) {
    canvas.drawCircle(center, radius, beadPaint);
    final path = Path();
    path.moveTo(center.dx - radius * 0.4, center.dy - radius * 0.7);
    path.quadraticBezierTo(
      center.dx - radius * 0.2,
      center.dy,
      center.dx - radius * 0.4,
      center.dy + radius * 0.7,
    );
    path.moveTo(center.dx + radius * 0.4, center.dy - radius * 0.7);
    path.quadraticBezierTo(
      center.dx + radius * 0.2,
      center.dy,
      center.dx + radius * 0.4,
      center.dy + radius * 0.7,
    );
    canvas.drawPath(path, texturePaint);
  }

  void _drawTassel(
      Canvas canvas, Offset guruCenter, double guruRadius, Paint threadPaint) {
    final tasselKnot = Offset(guruCenter.dx, guruCenter.dy + guruRadius + 10);

    canvas.drawLine(Offset(guruCenter.dx, guruCenter.dy + guruRadius),
        tasselKnot, threadPaint..strokeWidth = 3);

    final knotPaint = Paint()
      ..shader = ui.Gradient.radial(
        tasselKnot,
        8,
        [Colors.amber.shade200, Colors.amber.shade700],
      );
    canvas.drawCircle(tasselKnot, 8, knotPaint);

    final tasselCenterBottom = Offset(guruCenter.dx, tasselKnot.dy + 30);
    final tasselStrandPaint = Paint()
      ..color = Colors.red.shade800.withAlpha(200)
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    for (int i = -4; i <= 4; i++) {
      canvas.drawLine(
        tasselKnot,
        Offset(tasselCenterBottom.dx + i * 4,
            tasselCenterBottom.dy + (i.abs() % 2) * 5),
        tasselStrandPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MalaPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex;
  }
}
