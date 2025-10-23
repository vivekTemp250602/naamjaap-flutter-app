// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'நாம் ஜாப்பிற்கு வரவேற்கிறோம்';

  @override
  String get login_subtitle => 'உங்கள் தனிப்பட்ட டிஜிட்டல் ஜப துணை.';

  @override
  String get login_termsAgreement => 'நான் ';

  @override
  String get login_termsAndConditions => 'விதிமுறைகள் மற்றும் நிபந்தனைகள்';

  @override
  String get login_and => ' மற்றும் ';

  @override
  String get login_privacyPolicy => 'தனியுரிமைக் கொள்கையை ஒப்புக்கொள்கிறேன்';

  @override
  String get login_signInWithGoogle => 'Google உடன் உள்நுழைக';

  @override
  String get nav_home => 'முகப்பு';

  @override
  String get nav_leaderboard => 'தலைமைப் பலகை';

  @override
  String get nav_wisdom => 'ஞானம்';

  @override
  String get nav_profile => 'என் சுயவிவரம்';

  @override
  String get home_tapToChant => 'ஜபிக்க தட்டவும்';

  @override
  String get home_dayStreak => 'நாள் தொடர்ச்சி';

  @override
  String get home_total => 'மொத்தம்:';

  @override
  String get home_mantraInfo => 'மந்திரத் தகவல்';

  @override
  String get dialog_close => 'மூடுக';

  @override
  String get wisdom_title => 'இன்றைய ஞானம்';

  @override
  String get wisdom_dismissed =>
      'இன்றைய ஞானம் சிந்திக்கப்பட்டது.\nநாளை ஒரு புதிய நுண்ணறிவு வரும்.';

  @override
  String get wisdom_loading => 'ஞானம் ஏற்றப்படுகிறது...';

  @override
  String get leaderboard_allTime => 'எல்லா காலத்திலும்';

  @override
  String get leaderboard_thisWeek => 'இந்த வாரம்';

  @override
  String get leaderboard_yourProgress => 'உங்கள் முன்னேற்றம்';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName ஐ கடக்க $count ஜபங்கள்';
  }

  @override
  String get leaderboard_empty => 'பயணம் தொடங்குகிறது!';

  @override
  String get leaderboard_emptySubtitle =>
      'தலைமைப் பலகையில் இடம்பிடித்த முதல் நபராக இருங்கள்!';

  @override
  String get leaderboard_isEmpty => 'தலைமைப் பலகை காலியாக உள்ளது.';

  @override
  String get leaderboard_noBade => 'இன்னும் பேட்ஜ்கள் இல்லை';

  @override
  String get leaderboard_notOnBoard =>
      'பலகையில் இடம் பெற ஜபித்துக் கொண்டே இருங்கள்!';

  @override
  String get leaderboard_topOfBoard => 'நீங்கள் முதலிடத்தில் இருக்கிறீர்கள்! ✨';

  @override
  String get leaderboard_noChants => 'இன்னும் ஜபங்கள் இல்லை';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'சிறந்த மந்திரம்: $mantra';
  }

  @override
  String get profile_yourProgress => 'உங்கள் முன்னேற்றம்';

  @override
  String get profile_dailyStreak => 'தினசரி தொடர்ச்சி';

  @override
  String get profile_totalJapps => 'மொத்த ஜபங்கள்';

  @override
  String get profile_globalRank => 'உலகளாவிய தரவரிசை';

  @override
  String get profile_mantraTotals => 'மந்திர மொத்தங்கள்';

  @override
  String get profile_achievements => 'சாதனைகள்';

  @override
  String get profile_shareProgress => 'உங்கள் முன்னேற்றத்தைப் பகிரவும்';

  @override
  String get profile_badgesEmpty =>
      'உங்கள் முதல் பேட்ஜைப் பெற ஜபிக்கத் தொடங்குங்கள்!';

  @override
  String get profile_mantrasEmpty =>
      'உங்கள் மொத்த எண்ணிக்கையை இங்கே காண ஜபிக்கத் தொடங்குங்கள்!';

  @override
  String get profile_shareApp => 'நாம் ஜாப்பைப் பகிரவும்';

  @override
  String get profile_rateApp => 'எங்கள் பயன்பாட்டை மதிப்பிடவும்';

  @override
  String get profile_supportTitle => 'நாம் ஜாப்பிற்கு ஆதரவளிக்கவும்';

  @override
  String get profile_supportSubtitle => 'பயன்பாட்டை இயங்க வைக்க உதவுங்கள்';

  @override
  String get profile_myBodhi => 'என் போதி மரம்';

  @override
  String get profile_myBodhiSubtitle => 'உங்கள் பக்திக்கு ஒரு காட்சி சான்று.';

  @override
  String get profile_yourAchievement => 'உங்கள் சாதனைகள்';

  @override
  String get profile_yourAchievements => 'உங்கள் சாதனைகள்';

  @override
  String get profile_aMark => 'உங்கள் அர்ப்பணிப்பின் அடையாளம்.';

  @override
  String get profile_changeName => 'உங்கள் பெயரை மாற்றவும்';

  @override
  String get profile_enterName => 'புதிய பெயரை உள்ளிடவும்';

  @override
  String get settings_title => 'அமைப்புகள்';

  @override
  String get settings_ambiance => 'கோவில் சூழல்';

  @override
  String get settings_ambianceDesc => 'லேசான பின்னணி கோவில் ஒலிகளை இயக்கவும்.';

  @override
  String get settings_reminders => 'தினசரி நினைவூட்டல்கள்';

  @override
  String get settings_remindersDesc =>
      'இன்று நீங்கள் ஜபிக்கவில்லை என்றால் அறிவிப்பைப் பெறுங்கள்.';

  @override
  String get settings_language => 'பயன்பாட்டு மொழி';

  @override
  String get settings_feedback => 'கருத்து மற்றும் ஆதரவு';

  @override
  String get settings_feedbackDesc =>
      'ஒரு பிழையைப் புகாரளிக்கவும் அல்லது ஒரு அம்சத்தைப் பரிந்துரைக்கவும்.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'தனியுரிமைக் கொள்கை';

  @override
  String get settings_terms => 'விதிமுறைகள் மற்றும் நிபந்தனைகள்';

  @override
  String get settings_deleteAccount => 'எனது கணக்கை நீக்கு';

  @override
  String get settings_signOut => 'வெளியேறு';

  @override
  String get dialog_deleteTitle => 'கணக்கை நீக்கவா?';

  @override
  String get dialog_deleteBody =>
      'இந்தச் செயல் நிரந்தரமானது மற்றும் செயல்தவிர்க்க முடியாது. உங்கள் ஜபத் தரவு, சாதனைகள் மற்றும் தனிப்பட்ட தகவல்கள் அனைத்தும் நிரந்தரமாக அழிக்கப்படும்.\n\nநீங்கள் தொடர விரும்புகிறீர்கள் என்பது உறுதியாகத் தெரியுமா?';

  @override
  String get dialog_deleteConfirm => 'ஆம், எனது கணக்கை நீக்கு';

  @override
  String get dialog_continue => 'தொடர்க';

  @override
  String get dialog_pressBack => 'வெளியேற மீண்டும் பின் அழுத்தவும்';

  @override
  String get dialog_update => 'புதுப்பிப்பு தேவை';

  @override
  String get dialog_updateDesc =>
      'முக்கியமான புதுப்பிப்புகளுடன் நாம் ஜாப்பின் புதிய பதிப்பு கிடைக்கிறது. தொடர, பயன்பாட்டைப் புதுப்பிக்கவும்.';

  @override
  String get dialog_updateNow => 'இப்போதே புதுப்பிக்கவும்';

  @override
  String get dialog_save => 'சேமி';

  @override
  String get dialog_something => 'ஏதோ தவறு நடந்துவிட்டது.';

  @override
  String get dialog_cancel => 'ரத்துசெய்';

  @override
  String get misc_japps => 'ஜபங்கள்';

  @override
  String get misc_days => 'நாட்கள்';

  @override
  String get misc_badge => 'பேட்ஜ்கள்';

  @override
  String get lang_chooseLang =>
      'தொடர உங்களுக்கு விருப்பமான மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get lang_searchLang => 'மொழிகளைத் தேடுங்கள்';

  @override
  String get garden_totalMala => 'முழுமையான மாலைகள்';
}
