// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

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
  String get profile_rateApp => 'எங்கள் பயன்பாட்டை மதிப்பிடவும்';

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

  @override
  String get misc_malas => 'மாலைகள்';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName ஐ கடக்க $count மாலைகள்';
  }

  @override
  String get dialog_mic => 'ஆடியோவைப் பதிவுசெய்ய மைக்ரோஃபோன் அனுமதி தேவை.';

  @override
  String get custom_create => 'உங்கள் மந்திரத்தை உருவாக்கவும்';

  @override
  String get custom_yourMantra => 'மந்திரத்தின் பெயர்';

  @override
  String get custom_hint => 'எ.கா., ஓம் குரவே நமஹ';

  @override
  String get custom_back => 'ஒரு பின்னணியைத் தேர்வுசெய்க:';

  @override
  String get custom_addVoice => 'உங்கள் குரலைச் சேர்க்கவும் (விருப்பத்தேர்வு):';

  @override
  String get custom_recording => 'பதிவுசெய்கிறது...';

  @override
  String get custom_tapToRecord => 'பதிவுசெய்ய மைக்கைத் தட்டவும்';

  @override
  String get custom_saveMantra => 'மந்திரத்தைச் சேமி';

  @override
  String get custom_micAccess =>
      'ஆடியோவைப் பதிவுசெய்ய மைக்ரோஃபோன் அனுமதி தேவை.';

  @override
  String get profile_yourCustomMantra => 'எனது தனிப்பயன் மந்திரங்கள்';

  @override
  String get profile_noCustoms =>
      'நீங்கள் இன்னும் எந்த தனிப்பயன் மந்திரங்களையும் சேர்க்கவில்லை.';

  @override
  String get profile_addNewMantra => 'புதிய மந்திரத்தைச் சேர்';

  @override
  String get dialog_profilePictureUpdate =>
      'சுயவிவரப் படம் புதுப்பிக்கப்பட்டது!';

  @override
  String get dialog_failedToUpload => 'படத்தைப் பதிவேற்ற முடியவில்லை.';

  @override
  String get dialog_exceptionCard => 'பகிரக்கூடிய அட்டை சூழல் கிடைக்கவில்லை.';

  @override
  String get dialog_couldNotOpenPS => 'Play Store ஐத் திறக்க முடியவில்லை.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" ஐ நீக்கவா?';
  }

  @override
  String get profile_deleteMantraSure =>
      'உங்களுக்கு உறுதியாகத் தெரியுமா? இந்த மந்திரத்துடன் தொடர்புடைய அனைத்து ஜப எண்ணிக்கைகளும் நிரந்தரமாக நீக்கப்படும்.';

  @override
  String get profile_yesDelete => 'ஆம், நீக்கு';

  @override
  String get profile_couldNotUserData => 'பயனர் தரவை ஏற்ற முடியவில்லை.';

  @override
  String get misc_anonymous => 'அடையாளம் தெரியாதவர்';

  @override
  String get profile_sankalpaSet => 'ஒரு புனித சபதம் செய்யுங்கள்';

  @override
  String get profile_sankalpaSubtitle => 'ஒரு தனிப்பட்ட ஜப இலக்கை அமைக்கவும்.';

  @override
  String get profile_sankalpaTitle => 'உங்கள் ஜப சங்கல்பம்';

  @override
  String get profile_sankalpaChanting => 'ஜபித்தல்';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount முறைகளை அடைய.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date க்குள்';
  }

  @override
  String get dialog_sankalpaTitle => 'உங்கள் ஜப சங்கல்பத்தை அமைக்கவும்';

  @override
  String get dialog_sankalpaSelectMantra => 'மந்திரத்தைத் தேர்ந்தெடுக்கவும்';

  @override
  String get dialog_sankalpaTargetCount => 'இலக்கு எண்ணிக்கை (எ.கா., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'இலக்கு தேதி';

  @override
  String get dialog_sankalpaSelectDate => 'ஒரு தேதியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get dialog_sankalpaSetPledge => 'என் சபதத்தை அமைக்கவும்';

  @override
  String get dialog_sankalpaError => 'அனைத்து புலங்களையும் சரியாக நிரப்பவும்.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'இலக்கு எண்ணிக்கை உங்கள் தற்போதைய எண்ணிக்கையை விட அதிகமாக இருக்க வேண்டும்.';

  @override
  String get support_openUPI => 'உங்கள் UPI செயலியைத் திறக்கிறது...';

  @override
  String get support_cannotOpenUPI => 'UPI செயலியைத் தொடங்க முடியவில்லை.';

  @override
  String get support_upiError =>
      'பிழை: திறக்க UPI செயலி எதுவும் கிடைக்கவில்லை.';

  @override
  String get support_chooseOffering => 'ஒரு காணிக்கையைத் தேர்ந்தெடுக்கவும்';

  @override
  String get support_enterAmt => 'அல்லது ஒரு விருப்பத் தொகையை உள்ளிடவும் (INR)';

  @override
  String get support_validAmt =>
      'தயவுசெய்து சரியான தொகையைத் தேர்ந்தெடுக்கவும் அல்லது உள்ளிடவும்.';

  @override
  String get support_now => 'இப்போது ஆதரிக்கவும்';

  @override
  String get home_chooseMala => 'உங்கள் மாலையைத் தேர்வு செய்யவும்';

  @override
  String get home_chooseMalaDesc =>
      'உங்கள் ஆன்மாவிடம் எதிரொலிக்கும் ஒரு பாணியைத் தேர்ந்தெடுக்கவும்.';

  @override
  String get tour_title1 => 'டிஜிட்டல் ஜப மாலை';

  @override
  String get tour_body1 =>
      'ஜபிக்க தட்டவும். நாங்கள் உங்கள் மணிகளை எண்ணுகிறோம், மாலைகளைக் கண்காணிக்கிறோம், உங்கள் தொடர்ச்சியை தானாகவே பராமரிக்கிறோம்.';

  @override
  String get tour_title2 => 'உலகளாவியத் தலைமைப் பலகை';

  @override
  String get tour_body2 =>
      'ஆயிரக்கணக்கானவர்களுடன் ஜபியுங்கள். ஆன்மீக முன்னேற்றம் மற்றும் நிலைத்தன்மை மூலம் உயருங்கள்.';

  @override
  String get tour_title3 => 'தினசரி ஞானம்';

  @override
  String get tour_body3 =>
      'பண்டைய நூல்களிலிருந்து தேர்ந்தெடுக்கப்பட்ட வசனங்களைப் பெறுங்கள் — பல மொழிகளில் கிடைக்கிறது.';

  @override
  String get tour_title4 => 'உங்கள் ஆன்மீக பயணம்';

  @override
  String get tour_body4 =>
      'மைல்கற்களைக் கண்காணிக்கவும், சங்கல்பங்களை அமைக்கவும், உங்கள் வளர்ச்சி மற்றும் சாதனைகளை சிந்திக்கவும்.';

  @override
  String get dialog_getStarted => 'தொடங்குங்கள்';

  @override
  String get dialog_next => 'அடுத்து';

  @override
  String get dialog_skip => 'தவிர்';

  @override
  String get malatype_regular => 'வழக்கமான';

  @override
  String get malatype_crystal => 'படிகம்';

  @override
  String get malatype_royal => 'ராயல் கோல்ட்';

  @override
  String get profile_abandon => 'சபதத்தை கைவிடு';

  @override
  String get profile_progress => 'முன்னேற்றம்';

  @override
  String get profile_deadline => 'கடைசி தேதி';

  @override
  String get profile_achieved => 'சாதித்தது!';

  @override
  String get support_donate => 'நன்கொடை';

  @override
  String get support_paymentSucc =>
      'Razorpay மூலம் பாதுகாப்பாகச் செயலாக்கப்படும் கொடுப்பனவுகள்';

  @override
  String get support_thank => '🙏 நன்றி';

  @override
  String get home_customizeMala => 'மாலையைத் தனிப்பயனாக்கு';

  @override
  String get dialog_checkoutMyProgress =>
      'நாம் ஜாப் பயன்பாட்டில் எனது முன்னேற்றத்தைப் பாருங்கள்!';

  @override
  String get appTitle => 'நாம் ஜாப்';

  @override
  String get login_welcome => 'நாம் ஜாப்பிற்கு வரவேற்கிறோம்';

  @override
  String get profile_shareApp => 'நாம் ஜாப்பைப் பகிரவும்';

  @override
  String get profile_supportTitle => 'நாம் ஜாப்பிற்கு ஆதரவளிக்கவும்';

  @override
  String get dialog_updateDesc =>
      'முக்கியமான புதுப்பிப்புகளுடன் நாம் ஜாப்பின் புதிய பதிப்பு கிடைக்கிறது. தொடர, பயன்பாட்டைப் புதுப்பிக்கவும்.';

  @override
  String get support_desc =>
      'நாம் ஜாப் என்பது அன்பின் உழைப்பு, ஒரு தனி டெவலப்பரால் உருவாக்கப்பட்டது. உங்கள் தன்னலமற்ற பங்களிப்பு (சேவை) சேவையகங்களை இயங்க வைக்கவும், விளம்பரங்களைக் குறைக்கவும், அனைத்து பக்தர்களுக்கும் பயன்பாட்டை இலவசமாக வைத்திருக்கவும் உதவுகிறது.';

  @override
  String get support_title => 'நாம் ஜாப் திட்டத்தை ஆதரிக்கவும்';

  @override
  String get support_afterTitile =>
      'நாம் ஜாப்பை ஆதரித்ததற்கு நன்றி — ஒவ்வொரு பங்களிப்பும் உதவுகிறது.';
}
