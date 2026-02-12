import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';

const String prefsKeyMalaType = 'selectedMalaType';

enum MalaType {
  royal, // Gold (DEFAULT - Now First)
  pearl, // Moti
  crystal, // Spatik
  rudraksha, // Shiva's Tear
  sandalwood, // Chandan
  regular, // Tulsi/Wood
}

extension MalaTypeExtension on MalaType {
  String getDisplayName(BuildContext context) {
    switch (this) {
      case MalaType.regular:
        return AppLocalizations.of(context)!.malatype_regular;
      case MalaType.crystal:
        return AppLocalizations.of(context)!.malatype_crystal;
      case MalaType.royal:
        return AppLocalizations.of(context)!.malatype_royal;
      // You will need to add these keys to your .arb files later
      case MalaType.rudraksha:
        return "Rudraksha";
      case MalaType.sandalwood:
        return "Sandalwood";
      case MalaType.pearl:
        return "Pearl";
    }
  }
}
