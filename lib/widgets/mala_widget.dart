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

    // --- Thread ---
    final Paint threadPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = malaType == MalaType.royal ? 3.0 : 1.6
      ..color = (malaType == MalaType.royal)
          ? const Color(0xFFD4AF37).withAlpha(200)
          : (malaType == MalaType.crystal)
              ? Colors.white.withAlpha(125)
              : Colors.brown[900]!.withAlpha(160);

    canvas.drawCircle(center, radius, threadPaint);

    // --- Beads ---
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

    // ACTIVE BEAD — CUSTOM FOR EACH TYPE
    if (isActive) {
      switch (malaType) {
        // ----------------- Regular 🟤 -----------------
        case MalaType.regular:
          double bigR = radius + 6;

          canvas.drawCircle(
            center,
            bigR + 4,
            Paint()
              ..color = Colors.white.withAlpha(135)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12),
          );

          canvas.drawCircle(
            center,
            bigR,
            Paint()
              ..shader = ui.Gradient.radial(
                center,
                bigR * 1.4,
                [Colors.white, Colors.white70, Colors.orange.shade200],
                [0.0, 0.45, 1.0],
              ),
          );
          return;

        // ----------------- Crystal 🤍 -----------------
        case MalaType.crystal:
          double bigR2 = radius + 8;

          canvas.drawCircle(
            center,
            bigR2 + 4,
            Paint()
              ..color = Colors.blue.shade100.withAlpha(120)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20),
          );

          canvas.drawCircle(
            center,
            bigR2,
            Paint()
              ..shader = ui.Gradient.radial(
                center,
                bigR2 * 1.5,
                [
                  Colors.white.withAlpha(220),
                  Colors.blueGrey.shade50,
                  Colors.blueGrey.shade200.withAlpha(160),
                ],
                [0.0, 0.35, 1.0],
              ),
          );

          canvas.drawCircle(
            center + Offset(-bigR2 * 0.3, -bigR2 * 0.3),
            bigR2 * 0.25,
            Paint()..color = Colors.white.withAlpha(210),
          );
          return;

        // ----------------- Royal Gold 👑 -----------------
        case MalaType.royal:
          double glowR = radius + 10;

          // Soft dark backing for contrast on any background
          canvas.drawCircle(
            center,
            glowR + 6,
            Paint()
              ..color = Colors.black.withAlpha(110)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
          );

          // Controlled golden aura
          canvas.drawCircle(
            center,
            glowR + 3,
            Paint()
              ..color = Colors.amber.shade200.withAlpha(110)
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14),
          );

          // Clean metallic gold bead - smoother gradient
          canvas.drawCircle(
            center,
            glowR,
            Paint()
              ..shader = ui.Gradient.radial(
                center,
                glowR * 1.25,
                [
                  const Color(0xFFFFF8D8), // bright top
                  const Color(0xFFFFD36B), // mid
                  const Color(0xFFB8860B), // shadow gold
                ],
                [0.0, 0.55, 1.0],
              ),
          );

          // Subtle highlight
          canvas.drawCircle(
            center + Offset(-glowR * 0.28, -glowR * 0.28),
            glowR * 0.22,
            Paint()..color = Colors.white.withAlpha(155),
          );

          return;
      }
    }

    // NON-ACTIVE BEADS
    switch (malaType) {
      case MalaType.regular:
        paint.color = Colors.brown[700]!;
        canvas.drawCircle(center, radius, paint);
        break;

      case MalaType.crystal:
        paint.shader = ui.Gradient.radial(
          center,
          radius * 1.2,
          [
            Colors.white.withAlpha(210),
            Colors.blueGrey.shade100.withAlpha(90),
          ],
        );
        canvas.drawCircle(center, radius, paint);
        break;

      case MalaType.royal:
        // Thin crisp outline
        canvas.drawCircle(
          center,
          radius + 1.2,
          Paint()
            ..color = Colors.black.withAlpha(120)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.4,
        );

        // Metallic gold bead
        paint.shader = ui.Gradient.radial(
          center,
          radius * 1.4,
          [
            const Color(0xFFFFF6CC),
            const Color(0xFFFFCC4D),
            const Color(0xFFB07A0A),
          ],
          [0.0, 0.55, 1.0],
        );

        canvas.drawCircle(center, radius, paint);

        // tiny highlight
        canvas.drawCircle(
          center + Offset(-radius * 0.25, -radius * 0.25),
          radius * 0.18,
          Paint()..color = Colors.white.withAlpha(140),
        );
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
        paint.shader = ui.Gradient.radial(
          center,
          radius * 1.3,
          [
            const Color(0xFFFFF4C0),
            const Color(0xFFFFBF3F),
            const Color(0xFF9C6A1F),
          ],
          [0.0, 0.5, 1.0],
        );
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
