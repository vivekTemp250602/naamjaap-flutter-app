import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';

// This is the key we'll use to save the user's choice
const String prefsKeyMalaType = 'selectedMalaType';

// This enum defines our available mala styles.
// We can easily add more here later (like .rudraksha, .sandalwood, etc.)
enum MalaType {
  regular,
  crystal,
  royal,
}

// Helper extension to get the display name
extension MalaTypeExtension on MalaType {
  String getDisplayName(BuildContext context) {
    switch (this) {
      case MalaType.regular:
        return AppLocalizations.of(context)!.malatype_regular;
      case MalaType.crystal:
        return AppLocalizations.of(context)!.malatype_crystal;
      case MalaType.royal:
        return AppLocalizations.of(context)!.malatype_royal;
    }
  }

  // Helper to get the Paint for a bead
  Paint getBeadPaint(BuildContext context) {
    switch (this) {
      case MalaType.regular:
        return Paint()
          ..color = Colors.brown[700]!
          ..style = PaintingStyle.fill;
      case MalaType.crystal:
        return Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withAlpha(200),
              Colors.blue.shade100.withAlpha(110)
            ],
            center: const Alignment(0.3, -0.3),
          ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8))
          ..style = PaintingStyle.fill;
      case MalaType.royal:
        return Paint()
          ..shader = const LinearGradient(
            colors: [Color(0xFFFDEB71), Color(0xFFF8D800)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8))
          ..style = PaintingStyle.fill;
    }
  }

  // Helper to get the Paint for the ACTIVE bead
  Paint getActiveBeadPaint(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    switch (this) {
      case MalaType.regular:
        return Paint()
          ..color = primary
          ..style = PaintingStyle.fill;
      case MalaType.crystal:
        return Paint()
          ..shader = RadialGradient(
            colors: [Colors.white, primary.withAlpha(140)],
            center: const Alignment(0.3, -0.3),
          ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8))
          ..style = PaintingStyle.fill
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2.0);
      case MalaType.royal:
        return Paint()
          ..shader = LinearGradient(
            colors: [Colors.orange.shade300, primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8))
          ..style = PaintingStyle.fill;
    }
  }

  // Helper to get the Paint for the MERU bead
  Paint getMeruBeadPaint(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;
    switch (this) {
      case MalaType.regular:
        return Paint()
          ..color = secondary
          ..style = PaintingStyle.fill;
      case MalaType.crystal:
        return Paint()
          ..color = Colors.blue.shade200
          ..style = PaintingStyle.fill;
      case MalaType.royal:
        return Paint()
          ..color = Colors.red.shade700 // A nice "ruby" contrast to the gold
          ..style = PaintingStyle.fill;
    }
  }
}
