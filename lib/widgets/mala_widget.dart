import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/utils/mala_type.dart';
import 'package:provider/provider.dart';

class MalaWidget extends StatelessWidget {
  final int beadCount;
  final int activeBeadIndex;

  const MalaWidget({
    super.key,
    this.beadCount = 109,
    required this.activeBeadIndex,
  });

  @override
  Widget build(BuildContext context) {
    final malaType = Provider.of<MantraProvider>(context).selectedMalaType;

    return SizedBox(
      width: 340,
      height: 340,
      child: ClipRect(
        child: RepaintBoundary(
          child: CustomPaint(
            painter: MalaPainter(
              beadCount: beadCount,
              activeBeadIndex: activeBeadIndex,
              malaType: malaType,
              context: context,
            ),
          ),
        ),
      ),
    );
  }
}

class MalaPainter extends CustomPainter {
  final int beadCount;
  final int activeBeadIndex;
  final MalaType malaType;
  final BuildContext context;

  MalaPainter({
    required this.beadCount,
    required this.activeBeadIndex,
    required this.malaType,
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 20;
    final double angleStep = 2 * pi / beadCount;

    // --- Thread Color Logic ---
    final Color threadColor;
    double strokeWidth = 1.6;

    switch (malaType) {
      case MalaType.royal:
        threadColor = const Color(0xFFD4AF37).withAlpha(200);
        strokeWidth = 3.0;
        break;
      case MalaType.crystal:
        threadColor = Colors.white.withAlpha(125);
        break;
      case MalaType.rudraksha:
        threadColor = const Color(0xFF5D4037).withAlpha(200); // Dark brown
        strokeWidth = 2.0;
        break;
      case MalaType.sandalwood:
        threadColor = const Color(0xFFD7CCC8).withAlpha(180); // Light beige
        break;
      case MalaType.pearl:
        threadColor = Colors.white.withAlpha(180);
        break;
      default:
        threadColor = Colors.brown[900]!.withAlpha(160);
    }

    // Draw Thread
    final Paint threadPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = threadColor;

    canvas.drawCircle(center, radius, threadPaint);

    // --- Draw Beads ---
    for (int i = 0; i < beadCount; i++) {
      final angle = -pi / 2 + i * angleStep;
      final beadCenter = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );

      final beadRadius = i == activeBeadIndex ? 10.0 : 6.5;
      _drawBead(canvas, beadCenter, beadRadius, i == activeBeadIndex);
    }

    // --- Meru bead ---
    final meruCenter = Offset(center.dx, center.dy - radius - 12);
    _drawMeruBead(canvas, meruCenter);
  }

  // ---------------- DRAW BEAD -------------------
  void _drawBead(Canvas canvas, Offset center, double radius, bool isActive) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // --- 1. RUDRAKSHA 🕉️ (Textured Dark Orange) ---
    if (malaType == MalaType.rudraksha) {
      if (isActive) {
        // Active Glow
        canvas.drawCircle(
            center,
            radius + 5,
            Paint()
              ..color = Colors.orange.withOpacity(0.4)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10));
      }

      // Simulation of rough texture using multi-stop gradient
      paint.shader = ui.Gradient.radial(
        center,
        radius,
        [
          const Color(0xFF8D6E63), // Light highlight
          const Color(0xFF5D4037), // Mid
          const Color(0xFF3E2723), // Dark crevices
          const Color(0xFF3E2723),
        ],
        [0.0, 0.4, 0.8, 1.0],
      );
      canvas.drawCircle(center, radius, paint);

      // Add "grooves" (Simple dots to simulate texture)
      if (isActive) {
        final p = Paint()..color = Colors.black12;
        canvas.drawCircle(center + const Offset(2, 2), 2, p);
        canvas.drawCircle(center + const Offset(-2, -2), 2, p);
      }
      return;
    }

    // --- 2. SANDALWOOD 🌳 (Matte Beige) ---
    if (malaType == MalaType.sandalwood) {
      if (isActive) {
        canvas.drawCircle(
            center,
            radius + 5,
            Paint()
              ..color = const Color(0xFFFFE0B2).withOpacity(0.5)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10));
      }

      paint.shader = ui.Gradient.radial(
        center,
        radius,
        [
          const Color(0xFFFFF3E0), // Very light wood
          const Color(0xFFFFCC80), // Sandalwood core
          const Color(0xFFE65100), // Dark edge
        ],
        [0.0, 0.7, 1.0],
      );
      canvas.drawCircle(center, radius, paint);
      return;
    }

    // --- 3. PEARL ⚪ (Glossy White) ---
    if (malaType == MalaType.pearl) {
      if (isActive) {
        canvas.drawCircle(
            center,
            radius + 6,
            Paint()
              ..color = Colors.white.withOpacity(0.4)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12));
      }

      // Pearl body
      paint.shader = ui.Gradient.radial(
          center,
          radius,
          [Colors.white, const Color(0xFFECEFF1), Colors.grey.shade400],
          [0.1, 0.8, 1.0]);
      canvas.drawCircle(center, radius, paint);

      // Specular Highlight (The "shine")
      canvas.drawCircle(center + Offset(-radius * 0.3, -radius * 0.3),
          radius * 0.25, Paint()..color = Colors.white.withOpacity(0.9));
      return;
    }

    // --- EXISTING TYPES (Regular, Crystal, Royal) ---
    // (Kept your existing logic here, simplified for brevity in this snippet)

    if (isActive) {
      switch (malaType) {
        case MalaType.regular:
          double bigR = radius + 6;
          canvas.drawCircle(
              center,
              bigR + 4,
              Paint()
                ..color = Colors.white.withAlpha(135)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12));
          canvas.drawCircle(
              center,
              bigR,
              Paint()
                ..shader = ui.Gradient.radial(
                    center,
                    bigR * 1.4,
                    [Colors.white, Colors.white70, Colors.orange.shade200],
                    [0.0, 0.45, 1.0]));
          break;
        case MalaType.crystal:
          double bigR2 = radius + 8;
          canvas.drawCircle(
              center,
              bigR2 + 4,
              Paint()
                ..color = Colors.blue.shade100.withAlpha(120)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20));
          canvas.drawCircle(
              center,
              bigR2,
              Paint()
                ..shader = ui.Gradient.radial(center, bigR2 * 1.5, [
                  Colors.white.withAlpha(220),
                  Colors.blueGrey.shade50,
                  Colors.blueGrey.shade200.withAlpha(160)
                ], [
                  0.0,
                  0.35,
                  1.0
                ]));
          break;
        case MalaType.royal:
          double glowR = radius + 10;
          canvas.drawCircle(
              center,
              glowR + 6,
              Paint()
                ..color = Colors.black.withAlpha(110)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18));
          canvas.drawCircle(
              center,
              glowR + 3,
              Paint()
                ..color = Colors.amber.shade200.withAlpha(110)
                ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14));
          canvas.drawCircle(
              center,
              glowR,
              Paint()
                ..shader = ui.Gradient.radial(center, glowR * 1.25, [
                  const Color(0xFFFFF8D8),
                  const Color(0xFFFFD36B),
                  const Color(0xFFB8860B)
                ], [
                  0.0,
                  0.55,
                  1.0
                ]));
          break;
        default:
          break;
      }
      return;
    }

    // Passive Beads
    switch (malaType) {
      case MalaType.regular:
        paint.color = Colors.brown[700]!;
        canvas.drawCircle(center, radius, paint);
        break;
      case MalaType.crystal:
        paint.shader = ui.Gradient.radial(center, radius * 1.2, [
          Colors.white.withAlpha(210),
          Colors.blueGrey.shade100.withAlpha(90)
        ]);
        canvas.drawCircle(center, radius, paint);
        break;
      case MalaType.royal:
        canvas.drawCircle(
            center,
            radius + 1.2,
            Paint()
              ..color = Colors.black.withAlpha(120)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1.4);
        paint.shader = ui.Gradient.radial(center, radius * 1.4, [
          const Color(0xFFFFF6CC),
          const Color(0xFFFFCC4D),
          const Color(0xFFB07A0A)
        ], [
          0.0,
          0.55,
          1.0
        ]);
        canvas.drawCircle(center, radius, paint);
        break;
      default:
        break;
    }
  }

  // ---------------- DRAW MERU BEAD -------------------
  void _drawMeruBead(Canvas canvas, Offset center) {
    double radius = 14;
    final Paint paint = Paint()..style = PaintingStyle.fill;

    switch (malaType) {
      case MalaType.regular:
        paint.color = Colors.red.shade900;
        break;
      case MalaType.crystal:
        paint.color = Colors.blue.shade100;
        break;
      case MalaType.royal:
        paint.shader = ui.Gradient.radial(center, radius * 1.3, [
          const Color(0xFFFFF4C0),
          const Color(0xFFFFBF3F),
          const Color(0xFF9C6A1F)
        ], [
          0.0,
          0.5,
          1.0
        ]);
        break;
      case MalaType.rudraksha:
        paint.color = const Color(0xFF3E2723); // Deepest brown
        break;
      case MalaType.sandalwood:
        paint.color = const Color(0xFFFFCC80); // Deep sand
        break;
      case MalaType.pearl:
        paint.shader = ui.Gradient.radial(
            center, radius, [Colors.white, Colors.grey.shade300]);
        break;
    }
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant MalaPainter oldDelegate) {
    return oldDelegate.activeBeadIndex != activeBeadIndex ||
        oldDelegate.malaType != malaType;
  }
}
