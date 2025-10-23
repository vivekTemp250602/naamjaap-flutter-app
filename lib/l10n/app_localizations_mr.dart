// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'नाम जापमध्ये आपले स्वागत आहे';

  @override
  String get login_subtitle => 'तुमचा वैयक्तिक डिजिटल जप साथीदार.';

  @override
  String get login_termsAgreement => 'मी ';

  @override
  String get login_termsAndConditions => 'नियम आणि अटी';

  @override
  String get login_and => ' आणि ';

  @override
  String get login_privacyPolicy => 'गोपनीयता धोरणाशी सहमत आहे';

  @override
  String get login_signInWithGoogle => 'Google ने साइन इन करा';

  @override
  String get nav_home => 'होम';

  @override
  String get nav_leaderboard => 'लीडरबोर्ड';

  @override
  String get nav_wisdom => 'ज्ञान';

  @override
  String get nav_profile => 'माझे प्रोफाइल';

  @override
  String get home_tapToChant => 'जप करण्यासाठी टॅप करा';

  @override
  String get home_dayStreak => 'दिवसांची सलगता';

  @override
  String get home_total => 'एकूण:';

  @override
  String get home_mantraInfo => 'मंत्राची माहिती';

  @override
  String get dialog_close => 'बंद करा';

  @override
  String get wisdom_title => 'आजचे ज्ञान';

  @override
  String get wisdom_dismissed =>
      'आजच्या ज्ञानावर चिंतन केले आहे.\nउद्या एक नवीन अंतर्दृष्टी येईल.';

  @override
  String get wisdom_loading => 'ज्ञान लोड होत आहे...';

  @override
  String get leaderboard_allTime => 'सर्वकालीन';

  @override
  String get leaderboard_thisWeek => 'या आठवड्यात';

  @override
  String get leaderboard_yourProgress => 'तुमची प्रगती';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName ला मागे टाकण्यासाठी $count जप';
  }

  @override
  String get leaderboard_empty => 'प्रवास सुरू होतो!';

  @override
  String get leaderboard_emptySubtitle => 'लीडरबोर्डवर प्रथम येणारे व्हा!';

  @override
  String get leaderboard_isEmpty => 'लीडरबोर्ड रिक्त आहे.';

  @override
  String get leaderboard_noBade => 'अद्याप बॅज नाहीत';

  @override
  String get leaderboard_notOnBoard => 'बोर्डवर येण्यासाठी जप करत रहा!';

  @override
  String get leaderboard_topOfBoard => 'तुम्ही शीर्षस्थानी आहात! ✨';

  @override
  String get leaderboard_noChants => 'अद्याप जप नाही';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'शीर्ष मंत्र: $mantra';
  }

  @override
  String get profile_yourProgress => 'तुमची प्रगती';

  @override
  String get profile_dailyStreak => 'दैनिक सलगता';

  @override
  String get profile_totalJapps => 'एकूण जप';

  @override
  String get profile_globalRank => 'जागतिक रँक';

  @override
  String get profile_mantraTotals => 'मंत्रांची एकूण संख्या';

  @override
  String get profile_achievements => 'उपलब्धी';

  @override
  String get profile_shareProgress => 'तुमची प्रগती शेअर करा';

  @override
  String get profile_badgesEmpty => 'तुमचा पहिला बॅज मिळवण्यासाठी जप सुरू करा!';

  @override
  String get profile_mantrasEmpty =>
      'तुमची एकूण संख्या येथे पाहण्यासाठी जप सुरू करा!';

  @override
  String get profile_shareApp => 'नाम जाप शेअर करा';

  @override
  String get profile_rateApp => 'आमच्या अॅपला रेट करा';

  @override
  String get profile_supportTitle => 'नाम जापला सपोर्ट करा';

  @override
  String get profile_supportSubtitle => 'अॅप चालू ठेवण्यास मदत करा';

  @override
  String get profile_myBodhi => 'माझा बोधी वृक्ष';

  @override
  String get profile_myBodhiSubtitle => 'तुमच्या भक्तीचा एक दृश्य पुरावा.';

  @override
  String get profile_yourAchievement => 'तुमची उपलब्धी';

  @override
  String get profile_yourAchievements => 'तुमची उपलब्धी';

  @override
  String get profile_aMark => 'तुमच्या समर्पणाचे प्रतीक.';

  @override
  String get profile_changeName => 'तुमचे नाव बदला';

  @override
  String get profile_enterName => 'नवीन नाव प्रविष्ट करा';

  @override
  String get settings_title => 'सेटिंग्ज';

  @override
  String get settings_ambiance => 'मंदिराचे वातावरण';

  @override
  String get settings_ambianceDesc => 'मंद पार्श्वभूमी मंदिराचे आवाज वाजवा.';

  @override
  String get settings_reminders => 'दैनिक स्मरणपत्रे';

  @override
  String get settings_remindersDesc => 'आज तुम्ही जप केला नसेल तर सूचना मिळवा.';

  @override
  String get settings_language => 'अॅपची भाषा';

  @override
  String get settings_feedback => 'अभिप्राय आणि समर्थन';

  @override
  String get settings_feedbackDesc =>
      'बगची तक्रार करा किंवा वैशिष्ट्याची सूचना द्या.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'गोपनीयता धोरण';

  @override
  String get settings_terms => 'नियम आणि अटी';

  @override
  String get settings_deleteAccount => 'माझे खाते हटवा';

  @override
  String get settings_signOut => 'साइन आउट करा';

  @override
  String get dialog_deleteTitle => 'खाते हटवायचे?';

  @override
  String get dialog_deleteBody =>
      'ही क्रिया कायमस्वरूपी आहे आणि पूर्ववत केली जाऊ शकत नाही. तुमचा सर्व जप डेटा, उपलब्धी आणि वैयक्तिक माहिती कायमची पुसली जाईल.\n\nतुम्हाला खात्री आहे की तुम्ही पुढे जाऊ इच्छिता?';

  @override
  String get dialog_deleteConfirm => 'होय, माझे खाते हटवा';

  @override
  String get dialog_continue => 'पुढे जा';

  @override
  String get dialog_pressBack => 'बाहेर पडण्यासाठी पुन्हा मागे दाबा';

  @override
  String get dialog_update => 'अपडेट आवश्यक आहे';

  @override
  String get dialog_updateDesc =>
      'नाम जापची नवीन आवृत्ती महत्त्वपूर्ण अपडेट्ससह उपलब्ध आहे. कृपया सुरू ठेवण्यासाठी अॅप अपडेट करा.';

  @override
  String get dialog_updateNow => 'आता अपडेट करा';

  @override
  String get dialog_save => 'सेव्ह करा';

  @override
  String get dialog_something => 'काहीतरी चूक झाली.';

  @override
  String get dialog_cancel => 'रद्द करा';

  @override
  String get misc_japps => 'जप';

  @override
  String get misc_days => 'दिवस';

  @override
  String get misc_badge => 'बॅज';

  @override
  String get lang_chooseLang => 'पुढे जाण्यासाठी तुमची आवडती भाषा निवडा';

  @override
  String get lang_searchLang => 'भाषा शोधा';

  @override
  String get garden_totalMala => 'पूर्ण झालेल्या माळा';
}
