// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'ਨਾਮ ਜਾਪ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ';

  @override
  String get login_subtitle => 'ਤੁਹਾਡਾ ਨਿੱਜੀ ਡਿਜੀਟਲ ਜਾਪ ਸਾਥੀ।';

  @override
  String get login_termsAgreement => 'ਮੈਂ ';

  @override
  String get login_termsAndConditions => 'ਨਿਯਮ ਅਤੇ ਸ਼ਰਤਾਂ';

  @override
  String get login_and => ' ਅਤੇ ';

  @override
  String get login_privacyPolicy => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ ਨਾਲ ਸਹਿਮਤ ਹਾਂ';

  @override
  String get login_signInWithGoogle => 'Google ਨਾਲ ਸਾਈਨ ਇਨ ਕਰੋ';

  @override
  String get nav_home => 'ਹੋਮ';

  @override
  String get nav_leaderboard => 'ਲੀਡਰਬੋਰਡ';

  @override
  String get nav_wisdom => 'ਗਿਆਨ';

  @override
  String get nav_profile => 'ਮੇਰੀ ਪ੍ਰੋਫਾਈਲ';

  @override
  String get home_tapToChant => 'ਜਾਪ ਕਰਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get home_dayStreak => 'ਦਿਨ ਦੀ ਸਟ੍ਰੀਕ';

  @override
  String get home_total => 'ਕੁੱਲ:';

  @override
  String get home_mantraInfo => 'ਮੰਤਰ ਦੀ ਜਾਣਕਾਰੀ';

  @override
  String get dialog_close => 'ਬੰਦ ਕਰੋ';

  @override
  String get wisdom_title => 'ਅੱਜ ਦਾ ਗਿਆਨ';

  @override
  String get wisdom_dismissed =>
      'ਅੱਜ ਦੇ ਗਿਆਨ \'ਤੇ ਵਿਚਾਰ ਕੀਤਾ ਗਿਆ ਹੈ।\nਇੱਕ ਨਵੀਂ ਸੂਝ ਕੱਲ੍ਹ ਆਵੇਗੀ।';

  @override
  String get wisdom_loading => 'ਗਿਆਨ ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get leaderboard_allTime => 'ਹਮੇਸ਼ਾ ਦਾ';

  @override
  String get leaderboard_thisWeek => 'ਇਸ ਹਫ਼ਤੇ';

  @override
  String get leaderboard_yourProgress => 'ਤੁਹਾਡੀ ਤਰੱਕੀ';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName ਨੂੰ ਪਾਰ ਕਰਨ ਲਈ $count ਜਾਪ';
  }

  @override
  String get leaderboard_empty => 'ਯਾਤਰਾ ਸ਼ੁਰੂ ਹੁੰਦੀ ਹੈ!';

  @override
  String get leaderboard_emptySubtitle => 'ਲੀਡਰਬੋਰਡ \'ਤੇ ਪਹਿਲੇ ਸਥਾਨ \'ਤੇ ਆਓ!';

  @override
  String get leaderboard_isEmpty => 'ਲੀਡਰਬੋਰਡ ਖਾਲੀ ਹੈ।';

  @override
  String get leaderboard_noBade => 'ਅਜੇ ਤੱਕ ਕੋਈ ਬੈਜ ਨਹੀਂ';

  @override
  String get leaderboard_notOnBoard => 'ਬੋਰਡ \'ਤੇ ਆਉਣ ਲਈ ਜਾਪ ਕਰਦੇ ਰਹੋ!';

  @override
  String get leaderboard_topOfBoard => 'ਤੁਸੀਂ ਸਿਖਰ \'ਤੇ ਹੋ! ✨';

  @override
  String get leaderboard_noChants => 'ਅਜੇ ਤੱਕ ਕੋਈ ਜਾਪ ਨਹੀਂ';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'ਸਿਖਰ ਦਾ ਮੰਤਰ: $mantra';
  }

  @override
  String get profile_yourProgress => 'ਤੁਹਾਡੀ ਤਰੱਕੀ';

  @override
  String get profile_dailyStreak => 'ਰੋਜ਼ਾਨਾ ਸਟ੍ਰੀਕ';

  @override
  String get profile_totalJapps => 'ਕੁੱਲ ਜਾਪ';

  @override
  String get profile_globalRank => 'ਗਲੋਬਲ ਰੈਂਕ';

  @override
  String get profile_mantraTotals => 'ਮੰਤਰ ਕੁੱਲ';

  @override
  String get profile_achievements => 'ਪ੍ਰਾਪਤੀਆਂ';

  @override
  String get profile_shareProgress => 'ਆਪਣੀ ਤਰੱਕੀ ਸਾਂਝੀ ਕਰੋ';

  @override
  String get profile_badgesEmpty =>
      'ਆਪਣਾ ਪਹਿਲਾ ਬੈਜ ਕਮਾਉਣ ਲਈ ਜਾਪ ਕਰਨਾ ਸ਼ੁਰੂ ਕਰੋ!';

  @override
  String get profile_mantrasEmpty =>
      'ਆਪਣੇ ਕੁੱਲ ਜੋੜ ਇੱਥੇ ਦੇਖਣ ਲਈ ਜਾਪ ਕਰਨਾ ਸ਼ੁਰੂ ਕਰੋ!';

  @override
  String get profile_shareApp => 'ਨਾਮ ਜਾਪ ਸਾਂਝਾ ਕਰੋ';

  @override
  String get profile_rateApp => 'ਸਾਡੀ ਐਪ ਨੂੰ ਰੇਟ ਕਰੋ';

  @override
  String get profile_supportTitle => 'ਨਾਮ ਜਾਪ ਦਾ ਸਮਰਥਨ ਕਰੋ';

  @override
  String get profile_supportSubtitle => 'ਐਪ ਨੂੰ ਚਲਾਉਂਦੇ ਰਹਿਣ ਵਿੱਚ ਮਦਦ ਕਰੋ';

  @override
  String get profile_myBodhi => 'ਮੇਰਾ ਬੋਧੀ ਰੁੱਖ';

  @override
  String get profile_myBodhiSubtitle => 'ਤੁਹਾਡੀ ਸ਼ਰਧਾ ਦਾ ਇੱਕ ਦ੍ਰਿਸ਼ ਪ੍ਰਮਾਣ।';

  @override
  String get profile_yourAchievement => 'ਤੁਹਾਡੀਆਂ ਪ੍ਰਾਪਤੀਆਂ';

  @override
  String get profile_yourAchievements => 'ਤੁਹਾਡੀਆਂ ਪ੍ਰਾਪਤੀਆਂ';

  @override
  String get profile_aMark => 'ਤੁਹਾਡੇ ਸਮਰਪਣ ਦਾ ਨਿਸ਼ਾਨ।';

  @override
  String get profile_changeName => 'ਆਪਣਾ ਨਾਮ ਬਦਲੋ';

  @override
  String get profile_enterName => 'ਨਵਾਂ ਨਾਮ ਦਰਜ ਕਰੋ';

  @override
  String get settings_title => 'ਸੈਟਿੰਗਾਂ';

  @override
  String get settings_ambiance => 'ਮੰਦਰ ਦਾ ਮਾਹੌਲ';

  @override
  String get settings_ambianceDesc => 'ਹਲਕੀ ਪਿੱਠਭੂਮੀ ਮੰਦਰ ਦੀਆਂ ਆਵਾਜ਼ਾਂ ਚਲਾਓ।';

  @override
  String get settings_reminders => 'ਰੋਜ਼ਾਨਾ ਰੀਮਾਈਂਡਰ';

  @override
  String get settings_remindersDesc =>
      'ਜੇਕਰ ਤੁਸੀਂ ਅੱਜ ਜਾਪ ਨਹੀਂ ਕੀਤਾ ਹੈ ਤਾਂ ਇੱਕ ਸੂਚਨਾ ਪ੍ਰਾਪਤ ਕਰੋ।';

  @override
  String get settings_language => 'ਐਪ ਦੀ ਭਾਸ਼ਾ';

  @override
  String get settings_feedback => 'ਫੀਡਬੈਕ ਅਤੇ ਸਹਾਇਤਾ';

  @override
  String get settings_feedbackDesc =>
      'ਕਿਸੇ ਬੱਗ ਦੀ ਰਿਪੋਰਟ ਕਰੋ ਜਾਂ ਕਿਸੇ ਵਿਸ਼ੇਸ਼ਤਾ ਦਾ ਸੁਝਾਅ ਦਿਓ।';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'ਗੋਪਨੀਯਤਾ ਨੀਤੀ';

  @override
  String get settings_terms => 'ਨਿਯਮ ਅਤੇ ਸ਼ਰਤਾਂ';

  @override
  String get settings_deleteAccount => 'ਮੇਰਾ ਖਾਤਾ ਮਿਟਾਓ';

  @override
  String get settings_signOut => 'ਸਾਈਨ ਆਉਟ ਕਰੋ';

  @override
  String get dialog_deleteTitle => 'ਖਾਤਾ ਮਿਟਾਉਣਾ ਹੈ?';

  @override
  String get dialog_deleteBody =>
      'ਇਹ ਕਾਰਵਾਈ ਸਥਾਈ ਹੈ ਅਤੇ ਇਸਨੂੰ ਵਾਪਸ ਨਹੀਂ ਕੀਤਾ ਜਾ ਸਕਦਾ। ਤੁਹਾਡਾ ਸਾਰਾ ਜਾਪ ਡੇਟਾ, ਪ੍ਰਾਪਤੀਆਂ, ਅਤੇ ਨਿੱਜੀ ਜਾਣਕਾਰੀ ਸਥਾਈ ਤੌਰ \'ਤੇ ਮਿਟਾ ਦਿੱਤੀ ਜਾਵੇਗੀ।\n\nਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ \'ਤੇ ਅੱਗੇ ਵਧਣਾ ਚਾਹੁੰਦੇ ਹੋ?';

  @override
  String get dialog_deleteConfirm => 'ਹਾਂ, ਮੇਰਾ ਖਾਤਾ ਮਿਟਾਓ';

  @override
  String get dialog_continue => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get dialog_pressBack => 'ਬਾਹਰ ਜਾਣ ਲਈ ਦੁਬਾਰਾ ਵਾਪਸ ਦਬਾਓ';

  @override
  String get dialog_update => 'ਅੱਪਡੇਟ ਲੋੜੀਂਦਾ ਹੈ';

  @override
  String get dialog_updateDesc =>
      'ਨਾਮ ਜਾਪ ਦਾ ਇੱਕ ਨਵਾਂ ਸੰਸਕਰਣ ਮਹੱਤਵਪੂਰਨ ਅੱਪਡੇਟਾਂ ਨਾਲ ਉਪਲਬਧ ਹੈ। ਜਾਰੀ ਰੱਖਣ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਐਪ ਨੂੰ ਅੱਪਡੇਟ ਕਰੋ।';

  @override
  String get dialog_updateNow => 'ਹੁਣੇ ਅੱਪਡੇਟ ਕਰੋ';

  @override
  String get dialog_save => 'ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get dialog_something => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ।';

  @override
  String get dialog_cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get misc_japps => 'ਜਾਪ';

  @override
  String get misc_days => 'ਦਿਨ';

  @override
  String get misc_badge => 'ਬੈਜ';

  @override
  String get lang_chooseLang => 'ਜਾਰੀ ਰੱਖਣ ਲਈ ਆਪਣੀ ਪਸੰਦੀਦਾ ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get lang_searchLang => 'ਭਾਸ਼ਾਵਾਂ ਖੋਜੋ';

  @override
  String get garden_totalMala => 'ਪੂਰੀਆਂ ਹੋਈਆਂ ਮਾਲਾਵਾਂ';

  @override
  String get misc_malas => 'ਮਾਲਾਵਾਂ';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName ਨੂੰ ਪਾਰ ਕਰਨ ਲਈ $count ਮਾਲਾਵਾਂ';
  }

  @override
  String get dialog_mic => 'ਆਡੀਓ ਰਿਕਾਰਡ ਕਰਨ ਲਈ ਮਾਈਕ੍ਰੋਫੋਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੈ।';

  @override
  String get custom_create => 'ਆਪਣਾ ਮੰਤਰ ਬਣਾਓ';

  @override
  String get custom_yourMantra => 'ਮੰਤਰ ਦਾ ਨਾਮ';

  @override
  String get custom_hint => 'ਜਿਵੇਂ ਕਿ, ਓਮ ਗੁਰਵੇ ਨਮਹ';

  @override
  String get custom_back => 'ਇੱਕ ਪਿਛੋਕੜ ਚੁਣੋ:';

  @override
  String get custom_addVoice => 'ਆਪਣੀ ਆਵਾਜ਼ ਸ਼ਾਮਲ ਕਰੋ (ਵਿਕਲਪਿਕ):';

  @override
  String get custom_recording => 'ਰਿਕਾਰਡਿੰਗ ਹੋ ਰਹੀ ਹੈ...';

  @override
  String get custom_tapToRecord => 'ਰਿਕਾਰਡ ਕਰਨ ਲਈ ਮਾਈਕ \'ਤੇ ਟੈਪ ਕਰੋ';

  @override
  String get custom_saveMantra => 'ਮੰਤਰ ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get custom_micAccess =>
      'ਆਡੀਓ ਰਿਕਾਰਡ ਕਰਨ ਲਈ ਮਾਈਕ੍ਰੋਫੋਨ ਦੀ ਇਜਾਜ਼ਤ ਦੀ ਲੋੜ ਹੈ।';

  @override
  String get profile_yourCustomMantra => 'ਮੇਰੇ ਕਸਟਮ ਮੰਤਰ';

  @override
  String get profile_noCustoms =>
      'ਤੁਸੀਂ ਅਜੇ ਤੱਕ ਕੋਈ ਕਸਟਮ ਮੰਤਰ ਸ਼ਾਮਲ ਨਹੀਂ ਕੀਤੇ ਹਨ।';

  @override
  String get profile_addNewMantra => 'ਨਵਾਂ ਮੰਤਰ ਸ਼ਾਮਲ ਕਰੋ';

  @override
  String get dialog_profilePictureUpdate => 'ਪ੍ਰੋਫਾਈਲ ਤਸਵੀਰ ਅੱਪਡੇਟ ਕੀਤੀ ਗਈ!';

  @override
  String get dialog_failedToUpload => 'ਚਿੱਤਰ ਅੱਪਲੋਡ ਕਰਨ ਵਿੱਚ ਅਸਫਲ।';

  @override
  String get dialog_exceptionCard => 'ਸਾਂਝਾ ਕਰਨ ਯੋਗ ਕਾਰਡ ਸੰਦਰਭ ਉਪਲਬਧ ਨਹੀਂ ਹੈ।';

  @override
  String get dialog_checkoutMyProgress => 'ਨਾਮਜਾਪ ਐਪ \'ਤੇ ਮੇਰੀ ਤਰੱਕੀ ਦੇਖੋ!';

  @override
  String get dialog_couldNotOpenPS => 'ਪਲੇ ਸਟੋਰ ਨਹੀਂ ਖੋਲ੍ਹ ਸਕਿਆ।';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" ਨੂੰ ਮਿਟਾਉਣਾ ਹੈ?';
  }

  @override
  String get profile_deleteMantraSure =>
      'ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਹੋ? ਇਸ ਮੰਤਰ ਨਾਲ ਜੁੜੀਆਂ ਸਾਰੀਆਂ ਜਾਪ ਗਿਣਤੀਆਂ ਵੀ ਸਥਾਈ ਤੌਰ \'ਤੇ ਮਿਟਾ ਦਿੱਤੀਆਂ ਜਾਣਗੀਆਂ।';

  @override
  String get profile_yesDelete => 'ਹਾਂ, ਮਿਟਾਓ';

  @override
  String get profile_couldNotUserData => 'ਉਪਭੋਗਤਾ ਡੇਟਾ ਲੋਡ ਨਹੀਂ ਕੀਤਾ ਜਾ ਸਕਿਆ।';

  @override
  String get misc_anonymous => 'ਅਗਿਆਤ';
}
