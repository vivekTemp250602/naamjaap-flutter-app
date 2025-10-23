// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'నామ్ జాప్‌కు స్వాగతం';

  @override
  String get login_subtitle => 'మీ వ్యక్తిగత డిజిటల్ జప సహచరుడు.';

  @override
  String get login_termsAgreement => 'నేను ';

  @override
  String get login_termsAndConditions => 'నియమాలు మరియు షరతులను';

  @override
  String get login_and => ' మరియు ';

  @override
  String get login_privacyPolicy => 'గోప్యతా విధానాన్ని అంగీకరిస్తున్నాను';

  @override
  String get login_signInWithGoogle => 'Googleతో సైన్ ఇన్ చేయండి';

  @override
  String get nav_home => 'హోమ్';

  @override
  String get nav_leaderboard => 'లీడర్‌బోర్డ్';

  @override
  String get nav_wisdom => 'జ్ఞానం';

  @override
  String get nav_profile => 'నా ప్రొఫైల్';

  @override
  String get home_tapToChant => 'జపించడానికి నొక్కండి';

  @override
  String get home_dayStreak => 'రోజుల పరంపర';

  @override
  String get home_total => 'మొత్తం:';

  @override
  String get home_mantraInfo => 'మంత్ర సమాచారం';

  @override
  String get dialog_close => 'మూసివేయండి';

  @override
  String get wisdom_title => 'నేటి జ్ఞానం';

  @override
  String get wisdom_dismissed =>
      'నేటి జ్ఞానం గురించి ఆలోచించబడింది.\nరేపు కొత్త అంతర్దృష్టి వస్తుంది.';

  @override
  String get wisdom_loading => 'జ్ఞానం లోడ్ అవుతోంది...';

  @override
  String get leaderboard_allTime => 'అన్ని సమయాలు';

  @override
  String get leaderboard_thisWeek => 'ఈ వారం';

  @override
  String get leaderboard_yourProgress => 'మీ పురోగతి';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerNameను అధిగమించడానికి $count జపాలు';
  }

  @override
  String get leaderboard_empty => 'ప్రయాణం ప్రారంభమవుతుంది!';

  @override
  String get leaderboard_emptySubtitle =>
      'లీడర్‌బోర్డ్‌లో మొదటి స్థానంలో నిలవండి!';

  @override
  String get leaderboard_isEmpty => 'లీడర్‌బోర్డ్ ఖాళీగా ఉంది.';

  @override
  String get leaderboard_noBade => 'ఇంకా బ్యాడ్జ్‌లు లేవు';

  @override
  String get leaderboard_notOnBoard =>
      'బోర్డుపైకి రావడానికి జపించడం కొనసాగించండి!';

  @override
  String get leaderboard_topOfBoard => 'మీరు అగ్రస్థానంలో ఉన్నారు! ✨';

  @override
  String get leaderboard_noChants => 'ఇంకా జపాలు లేవు';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'అగ్ర మంత్రం: $mantra';
  }

  @override
  String get profile_yourProgress => 'మీ పురోగతి';

  @override
  String get profile_dailyStreak => 'రోజువారీ పరంపర';

  @override
  String get profile_totalJapps => 'మొత్తం జపాలు';

  @override
  String get profile_globalRank => 'గ్లోబల్ ర్యాంక్';

  @override
  String get profile_mantraTotals => 'మంత్రం మొత్తాలు';

  @override
  String get profile_achievements => 'విజయాలు';

  @override
  String get profile_shareProgress => 'మీ పురోగతిని పంచుకోండి';

  @override
  String get profile_badgesEmpty =>
      'మీ మొదటి బ్యాడ్జ్‌ను సంపాదించడానికి జపించడం ప్రారంభించండి!';

  @override
  String get profile_mantrasEmpty =>
      'మీ మొత్తాలను ఇక్కడ చూడటానికి జపించడం ప్రారంభించండి!';

  @override
  String get profile_shareApp => 'నామ్ జాప్‌ను పంచుకోండి';

  @override
  String get profile_rateApp => 'మా యాప్‌ను రేట్ చేయండి';

  @override
  String get profile_supportTitle => 'నామ్ జాప్‌కు మద్దతు ఇవ్వండి';

  @override
  String get profile_supportSubtitle => 'యాప్‌ను నడుపుతూ ఉంచడంలో సహాయపడండి';

  @override
  String get profile_myBodhi => 'నా బోధి వృక్షం';

  @override
  String get profile_myBodhiSubtitle => 'మీ భక్తికి దృశ్య నిరూపణ.';

  @override
  String get profile_yourAchievement => 'మీ విజయాలు';

  @override
  String get profile_yourAchievements => 'మీ విజయాలు';

  @override
  String get profile_aMark => 'మీ అంకితభావానికి గుర్తు.';

  @override
  String get profile_changeName => 'మీ పేరు మార్చుకోండి';

  @override
  String get profile_enterName => 'కొత్త పేరు నమోదు చేయండి';

  @override
  String get settings_title => 'సెట్టింగ్‌లు';

  @override
  String get settings_ambiance => 'ఆలయ వాతావరణం';

  @override
  String get settings_ambianceDesc =>
      'తేలికపాటి నేపథ్య ఆలయ శబ్దాలను ప్లే చేయండి.';

  @override
  String get settings_reminders => 'రోజువారీ రిమైండర్‌లు';

  @override
  String get settings_remindersDesc =>
      'మీరు ఈరోజు జపించకపోతే నోటిఫికేషన్ పొందండి.';

  @override
  String get settings_language => 'యాప్ భాష';

  @override
  String get settings_feedback => 'అభిప్రాయం & మద్దతు';

  @override
  String get settings_feedbackDesc =>
      'బగ్‌ను నివేదించండి లేదా ఫీచర్‌ను సూచించండి.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'గోప్యతా విధానం';

  @override
  String get settings_terms => 'నియమాలు మరియు షరతులు';

  @override
  String get settings_deleteAccount => 'నా ఖాతాను తొలగించండి';

  @override
  String get settings_signOut => 'సైన్ అవుట్';

  @override
  String get dialog_deleteTitle => 'ఖాతాను తొలగించాలా?';

  @override
  String get dialog_deleteBody =>
      'ఈ చర్య శాశ్వతమైనది మరియు రద్దు చేయబడదు. మీ జపం డేటా, విజయాలు మరియు వ్యక్తిగత సమాచారం మొత్తం శాశ్వతంగా తొలగించబడుతుంది.\n\nమీరు ఖచ్చితంగా కొనసాగాలనుకుంటున్నారా?';

  @override
  String get dialog_deleteConfirm => 'అవును, నా ఖాతాను తొలగించు';

  @override
  String get dialog_continue => 'కొనసాగించు';

  @override
  String get dialog_pressBack => 'నిష్క్రమించడానికి మళ్లీ వెనుకకు నొక్కండి';

  @override
  String get dialog_update => 'నవీకరణ అవసరం';

  @override
  String get dialog_updateDesc =>
      'ముఖ్యమైన నవీకరణలతో నామ్ జాప్ యొక్క కొత్త వెర్షన్ అందుబాటులో ఉంది. కొనసాగించడానికి దయచేసి యాప్‌ను నవీకరించండి.';

  @override
  String get dialog_updateNow => 'ఇప్పుడే నవీకరించండి';

  @override
  String get dialog_save => 'సేవ్ చేయి';

  @override
  String get dialog_something => 'ఏదో పొరపాటు జరిగింది.';

  @override
  String get dialog_cancel => 'రద్దు చేయి';

  @override
  String get misc_japps => 'జపాలు';

  @override
  String get misc_days => 'రోజులు';

  @override
  String get misc_badge => 'బ్యాడ్జ్‌లు';

  @override
  String get lang_chooseLang => 'కొనసాగడానికి మీకు ఇష్టమైన భాషను ఎంచుకోండి';

  @override
  String get lang_searchLang => 'భాషలను శోధించండి';

  @override
  String get garden_totalMala => 'పూర్తయిన మాలలు';
}
