// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'ನಾಮ್ ಜಾಪ್‌ಗೆ ಸುಸ್ವಾಗತ';

  @override
  String get login_subtitle => 'ನಿಮ್ಮ ವೈಯಕ್ತಿಕ ಡಿಜಿಟಲ್ ಜಪ ಸಹಚರ.';

  @override
  String get login_termsAgreement => 'ನಾನು ';

  @override
  String get login_termsAndConditions => 'ನಿಯಮಗಳು ಮತ್ತು ನಿಬಂಧನೆಗಳನ್ನು';

  @override
  String get login_and => ' ಮತ್ತು ';

  @override
  String get login_privacyPolicy => 'ಗೌಪ್ಯತಾ ನೀತಿಯನ್ನು ಒಪ್ಪುತ್ತೇನೆ';

  @override
  String get login_signInWithGoogle => 'Google ಮೂಲಕ ಸೈನ್ ಇನ್ ಮಾಡಿ';

  @override
  String get nav_home => 'ಮುಖಪುಟ';

  @override
  String get nav_leaderboard => 'ಲೀಡರ್‌ಬೋರ್ಡ್';

  @override
  String get nav_wisdom => 'ಜ್ಞಾನ';

  @override
  String get nav_profile => 'ನನ್ನ ಪ್ರೊಫೈಲ್';

  @override
  String get home_tapToChant => 'ಜಪಿಸಲು ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get home_dayStreak => 'ದಿನದ ಸರಣಿ';

  @override
  String get home_total => 'ಒಟ್ಟು:';

  @override
  String get home_mantraInfo => 'ಮಂತ್ರದ ಮಾಹಿತಿ';

  @override
  String get dialog_close => 'ಮುಚ್ಚಿ';

  @override
  String get wisdom_title => 'ಇಂದಿನ ಜ್ಞಾನ';

  @override
  String get wisdom_dismissed =>
      'ಇಂದಿನ ಜ್ಞಾನವನ್ನು ಆಲೋಚಿಸಲಾಗಿದೆ.\nನಾಳೆ ಹೊಸ ಒಳನೋಟ ಬರುತ್ತದೆ.';

  @override
  String get wisdom_loading => 'ಜ್ಞಾನ ಲೋಡ್ ಆಗುತ್ತಿದೆ...';

  @override
  String get leaderboard_allTime => 'ಸಾರ್ವಕಾಲಿಕ';

  @override
  String get leaderboard_thisWeek => 'ಈ ವಾರ';

  @override
  String get leaderboard_yourProgress => 'ನಿಮ್ಮ ಪ್ರಗತಿ';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName ಅವರನ್ನು ದಾಟಲು $count ಜಪಗಳು';
  }

  @override
  String get leaderboard_empty => 'ಪ್ರಯಾಣ ಪ್ರಾರಂಭವಾಗುತ್ತದೆ!';

  @override
  String get leaderboard_emptySubtitle => 'ಲೀಡರ್‌ಬೋರ್ಡ್‌ನಲ್ಲಿ ಮೊದಲಿಗರಾಗಿರಿ!';

  @override
  String get leaderboard_isEmpty => 'ಲೀಡರ್‌ಬೋರ್ಡ್ ಖಾಲಿಯಾಗಿದೆ.';

  @override
  String get leaderboard_noBade => 'ಇನ್ನೂ ಬ್ಯಾಡ್ಜ್‌ಗಳಿಲ್ಲ';

  @override
  String get leaderboard_notOnBoard => 'ಬೋರ್ಡ್‌ನಲ್ಲಿ ಸ್ಥಾನ ಪಡೆಯಲು ಜಪಿಸುತ್ತಿರಿ!';

  @override
  String get leaderboard_topOfBoard => 'ನೀವು ಅಗ್ರಸ್ಥಾನದಲ್ಲಿದ್ದೀರಿ! ✨';

  @override
  String get leaderboard_noChants => 'ಇನ್ನೂ ಜಪಗಳಿಲ್ಲ';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'ಉನ್ನತ ಮಂತ್ರ: $mantra';
  }

  @override
  String get profile_yourProgress => 'ನಿಮ್ಮ ಪ್ರಗತಿ';

  @override
  String get profile_dailyStreak => 'ದೈನಂದಿನ ಸರಣಿ';

  @override
  String get profile_totalJapps => 'ಒಟ್ಟು ಜಪಗಳು';

  @override
  String get profile_globalRank => 'ಜಾಗತಿಕ ಶ್ರೇಣಿ';

  @override
  String get profile_mantraTotals => 'ಮಂತ್ರದ ಒಟ್ಟು ಮೊತ್ತ';

  @override
  String get profile_achievements => 'ಸಾಧನೆಗಳು';

  @override
  String get profile_shareProgress => 'ನಿಮ್ಮ ಪ್ರಗತಿಯನ್ನು ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get profile_badgesEmpty =>
      'ನಿಮ್ಮ ಮೊದಲ ಬ್ಯಾಡ್ಜ್ ಗಳಿಸಲು ಜಪಿಸಲು ಪ್ರಾರಂಭಿಸಿ!';

  @override
  String get profile_mantrasEmpty =>
      'ನಿಮ್ಮ ಒಟ್ಟು ಮೊತ್ತವನ್ನು ಇಲ್ಲಿ ನೋಡಲು ಜಪಿಸಲು ಪ್ರಾರಂಭಿಸಿ!';

  @override
  String get profile_shareApp => 'ನಾಮ್ ಜಾಪ್ ಹಂಚಿಕೊಳ್ಳಿ';

  @override
  String get profile_rateApp => 'ನಮ್ಮ ಅಪ್ಲಿಕೇಶನ್ ರೇಟ್ ಮಾಡಿ';

  @override
  String get profile_supportTitle => 'ನಾಮ್ ಜಾಪ್ ಬೆಂಬಲಿಸಿ';

  @override
  String get profile_supportSubtitle => 'ಅಪ್ಲಿಕೇಶನ್ ಚಾಲನೆಯಲ್ಲಿಡಲು ಸಹಾಯ ಮಾಡಿ';

  @override
  String get profile_myBodhi => 'ನನ್ನ ಬೋಧಿ ವೃಕ್ಷ';

  @override
  String get profile_myBodhiSubtitle => 'ನಿಮ್ಮ ಭಕ್ತಿಯ ದೃಶ್ಯ ಸಾಕ್ಷಿ.';

  @override
  String get profile_yourAchievement => 'ನಿಮ್ಮ ಸಾಧನೆಗಳು';

  @override
  String get profile_yourAchievements => 'ನಿಮ್ಮ ಸಾಧನೆಗಳು';

  @override
  String get profile_aMark => 'ನಿಮ್ಮ ಸಮರ್ಪಣೆಯ ಗುರುತು.';

  @override
  String get profile_changeName => 'ನಿಮ್ಮ ಹೆಸರು ಬದಲಾಯಿಸಿ';

  @override
  String get profile_enterName => 'ಹೊಸ ಹೆಸರು ನಮೂದಿಸಿ';

  @override
  String get settings_title => 'ಸೆಟ್ಟಿಂಗ್‌ಗಳು';

  @override
  String get settings_ambiance => 'ದೇವಾಲಯದ ವಾತಾವರಣ';

  @override
  String get settings_ambianceDesc =>
      'ಸೌಮ್ಯವಾದ ಹಿನ್ನೆಲೆ ದೇವಾಲಯದ ಶಬ್ದಗಳನ್ನು ಪ್ಲೇ ಮಾಡಿ.';

  @override
  String get settings_reminders => 'ದೈನಂದಿನ ಜ್ಞಾಪನೆಗಳು';

  @override
  String get settings_remindersDesc =>
      'ನೀವು ಇಂದು ಜಪಿಸದಿದ್ದರೆ ಅಧಿಸೂಚನೆಯನ್ನು ಪಡೆಯಿರಿ.';

  @override
  String get settings_language => 'ಅಪ್ಲಿಕೇಶನ್ ಭಾಷೆ';

  @override
  String get settings_feedback => 'ಪ್ರತಿಕ್ರಿಯೆ ಮತ್ತು ಬೆಂಬಲ';

  @override
  String get settings_feedbackDesc =>
      'ಬಗ್ ವರದಿ ಮಾಡಿ ಅಥವಾ ವೈಶಿಷ್ಟ್ಯವನ್ನು ಸೂಚಿಸಿ.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'ಗೌಪ್ಯತಾ ನೀತಿ';

  @override
  String get settings_terms => 'ನಿಯಮಗಳು ಮತ್ತು ನಿಬಂಧನೆಗಳು';

  @override
  String get settings_deleteAccount => 'ನನ್ನ ಖಾತೆಯನ್ನು ಅಳಿಸಿ';

  @override
  String get settings_signOut => 'ಸೈನ್ ಔಟ್';

  @override
  String get dialog_deleteTitle => 'ಖಾತೆಯನ್ನು ಅಳಿಸುವುದೇ?';

  @override
  String get dialog_deleteBody =>
      'ಈ ಕ್ರಿಯೆಯು ಶಾಶ್ವತವಾಗಿದೆ ಮತ್ತು ಅದನ್ನು ರದ್ದುಗೊಳಿಸಲಾಗುವುದಿಲ್ಲ. ನಿಮ್ಮ ಎಲ್ಲಾ ಜಪ ಡೇಟಾ, ಸಾಧನೆಗಳು ಮತ್ತು ವೈಯಕ್ತಿಕ ಮಾಹಿತಿಯನ್ನು ಶಾಶ್ವತವಾಗಿ ಅಳಿಸಲಾಗುತ್ತದೆ.\n\nನೀವು ಮುಂದುವರಿಯಲು ಖಚಿತವಾಗಿ ಬಯಸುವಿರಾ?';

  @override
  String get dialog_deleteConfirm => 'ಹೌದು, ನನ್ನ ಖಾತೆಯನ್ನು ಅಳಿಸಿ';

  @override
  String get dialog_continue => 'ಮುಂದುವರಿಸಿ';

  @override
  String get dialog_pressBack => 'ಹೊರಹೋಗಲು ಮತ್ತೊಮ್ಮೆ ಹಿಂದೆ ಒತ್ತಿರಿ';

  @override
  String get dialog_update => 'ನವೀಕರಣ ಅಗತ್ಯವಿದೆ';

  @override
  String get dialog_updateDesc =>
      'ಪ್ರಮುಖ ನವೀಕರಣಗಳೊಂದಿಗೆ ನಾಮ್ ಜಾಪ್‌ನ ಹೊಸ ಆವೃತ್ತಿ ಲಭ್ಯವಿದೆ. ಮುಂದುವರಿಸಲು ದಯವಿಟ್ಟು ಅಪ್ಲಿಕೇಶನ್ ನವೀಕರಿಸಿ.';

  @override
  String get dialog_updateNow => 'ಈಗ ನವೀಕರಿಸಿ';

  @override
  String get dialog_save => 'ಉಳಿಸಿ';

  @override
  String get dialog_something => 'ಏನೋ ತಪ್ಪಾಗಿದೆ.';

  @override
  String get dialog_cancel => 'ರದ್ದುಮಾಡಿ';

  @override
  String get misc_japps => 'ಜಪಗಳು';

  @override
  String get misc_days => 'ದಿನಗಳು';

  @override
  String get misc_badge => 'ಬ್ಯಾಡ್ಜ್‌ಗಳು';

  @override
  String get lang_chooseLang => 'ಮುಂದುವರಿಯಲು ನಿಮ್ಮ ಆದ್ಯತೆಯ ಭಾಷೆಯನ್ನು ಆರಿಸಿ';

  @override
  String get lang_searchLang => 'ಭಾಷೆಗಳನ್ನು ಹುಡುಕಿ';

  @override
  String get garden_totalMala => 'ಪೂರ್ಣಗೊಂಡ ಮಾಲೆಗಳು';

  @override
  String get misc_malas => 'ಮಾಲೆಗಳು';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName ಅವರನ್ನು ದಾಟಲು $count ಮಾಲೆಗಳು';
  }

  @override
  String get dialog_mic => 'ಆಡಿಯೋ ರೆಕಾರ್ಡ್ ಮಾಡಲು ಮೈಕ್ರೊಫೋನ್ ಅನುಮತಿ ಅಗತ್ಯವಿದೆ.';

  @override
  String get custom_create => 'ನಿಮ್ಮ ಮಂತ್ರವನ್ನು ರಚಿಸಿ';

  @override
  String get custom_yourMantra => 'ಮಂತ್ರದ ಹೆಸರು';

  @override
  String get custom_hint => 'ಉದಾ., ಓಂ ಗುರವೇ ನಮಃ';

  @override
  String get custom_back => 'ಹಿನ್ನೆಲೆ ಆರಿಸಿ:';

  @override
  String get custom_addVoice => 'ನಿಮ್ಮ ಧ್ವನಿಯನ್ನು ಸೇರಿಸಿ (ಐಚ್ಛಿಕ):';

  @override
  String get custom_recording => 'ರೆಕಾರ್ಡ್ ಆಗುತ್ತಿದೆ...';

  @override
  String get custom_tapToRecord => 'ರೆಕಾರ್ಡ್ ಮಾಡಲು ಮೈಕ್ ಟ್ಯಾಪ್ ಮಾಡಿ';

  @override
  String get custom_saveMantra => 'ಮಂತ್ರ ಉಳಿಸಿ';

  @override
  String get custom_micAccess =>
      'ಆಡಿಯೋ ರೆಕಾರ್ಡ್ ಮಾಡಲು ಮೈಕ್ರೊಫೋನ್ ಅನುಮತಿ ಅಗತ್ಯವಿದೆ.';

  @override
  String get profile_yourCustomMantra => 'ನನ್ನ ಕಸ್ಟಮ್ ಮಂತ್ರಗಳು';

  @override
  String get profile_noCustoms =>
      'ನೀವು ಇನ್ನೂ ಯಾವುದೇ ಕಸ್ಟಮ್ ಮಂತ್ರಗಳನ್ನು ಸೇರಿಸಿಲ್ಲ.';

  @override
  String get profile_addNewMantra => 'ಹೊಸ ಮಂತ್ರ ಸೇರಿಸಿ';

  @override
  String get dialog_profilePictureUpdate => 'ಪ್ರೊಫೈಲ್ ಚಿತ್ರ ನವೀಕರಿಸಲಾಗಿದೆ!';

  @override
  String get dialog_failedToUpload => 'ಚಿತ್ರ ಅಪ್‌ಲೋಡ್ ಮಾಡಲು ವಿಫಲವಾಗಿದೆ.';

  @override
  String get dialog_exceptionCard => 'ಹಂಚಿಕೊಳ್ಳಬಹುದಾದ ಕಾರ್ಡ್ ಸಂದರ್ಭ ಲಭ್ಯವಿಲ್ಲ.';

  @override
  String get dialog_checkoutMyProgress =>
      'ನಾಮ್‌ಜಾಪ್ ಅಪ್ಲಿಕೇಶನ್‌ನಲ್ಲಿ ನನ್ನ ಪ್ರಗತಿಯನ್ನು ಪರಿಶೀಲಿಸಿ!';

  @override
  String get dialog_couldNotOpenPS => 'Play Store ತೆರೆಯಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" ಅಳಿಸುವುದೇ?';
  }

  @override
  String get profile_deleteMantraSure =>
      'ನೀವು ಖಚಿತವಾಗಿರುವಿರಾ? ಈ ಮಂತ್ರಕ್ಕೆ ಸಂಬಂಧಿಸಿದ ಎಲ್ಲಾ ಜಪ ಎಣಿಕೆಗಳನ್ನು ಸಹ ಶಾಶ್ವತವಾಗಿ ಅಳಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get profile_yesDelete => 'ಹೌದು, ಅಳಿಸಿ';

  @override
  String get profile_couldNotUserData =>
      'ಬಳಕೆದಾರರ ಡೇಟಾ ಲೋಡ್ ಮಾಡಲು ಸಾಧ್ಯವಾಗಲಿಲ್ಲ.';

  @override
  String get misc_anonymous => 'ಅನಾಮಧೇಯ';
}
