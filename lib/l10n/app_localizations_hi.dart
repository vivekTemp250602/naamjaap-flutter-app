// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'नाम जाप में आपका स्वागत है';

  @override
  String get login_subtitle => 'आपका व्यक्तिगत डिजिटल जाप साथी।';

  @override
  String get login_termsAgreement => 'मैंने ';

  @override
  String get login_termsAndConditions => 'नियम और शर्तें';

  @override
  String get login_and => ' और ';

  @override
  String get login_privacyPolicy => 'गोपनीयता नीति से सहमत हूँ';

  @override
  String get login_signInWithGoogle => 'Google से साइन इन करें';

  @override
  String get nav_home => 'होम';

  @override
  String get nav_leaderboard => 'लीडरबोर्ड';

  @override
  String get nav_wisdom => 'ज्ञान';

  @override
  String get nav_profile => 'मेरी प्रोफ़ाइल';

  @override
  String get home_tapToChant => 'जाप करने के लिए टैप करें';

  @override
  String get home_dayStreak => 'दिन की स्ट्रीक';

  @override
  String get home_total => 'कुल:';

  @override
  String get home_mantraInfo => 'मंत्र की जानकारी';

  @override
  String get dialog_close => 'बंद करें';

  @override
  String get wisdom_title => 'आज का ज्ञान';

  @override
  String get wisdom_dismissed =>
      'आज के ज्ञान पर विचार कर लिया गया है।\nएक नई अंतर्दृष्टि कल आएगी।';

  @override
  String get wisdom_loading => 'ज्ञान लोड हो रहा है...';

  @override
  String get leaderboard_allTime => 'सभी समय';

  @override
  String get leaderboard_thisWeek => 'इस सप्ताह';

  @override
  String get leaderboard_yourProgress => 'आपकी प्रगति';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName को पार करने के लिए $count जाप';
  }

  @override
  String get leaderboard_empty => 'यात्रा शुरू होती है!';

  @override
  String get leaderboard_emptySubtitle =>
      'लीडरबोर्ड पर आने वाले पहले व्यक्ति बनें!';

  @override
  String get leaderboard_isEmpty => 'लीडरबोर्ड खाली है।';

  @override
  String get leaderboard_noBade => 'अभी तक कोई बैज नहीं';

  @override
  String get leaderboard_notOnBoard => 'बोर्ड पर आने के लिए जाप करते रहें!';

  @override
  String get leaderboard_topOfBoard => 'आप शीर्ष पर हैं! ✨';

  @override
  String get leaderboard_noChants => 'अभी तक कोई जाप नहीं';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'शीर्ष मंत्र: $mantra';
  }

  @override
  String get profile_yourProgress => 'आपकी प्रगति';

  @override
  String get profile_dailyStreak => 'दैनिक स्ट्रीक';

  @override
  String get profile_totalJapps => 'कुल जाप';

  @override
  String get profile_globalRank => 'वैश्विक रैंक';

  @override
  String get profile_mantraTotals => 'मंत्र कुल';

  @override
  String get profile_achievements => 'उपलब्धियां';

  @override
  String get profile_shareProgress => 'अपनी प्रगति साझा करें';

  @override
  String get profile_badgesEmpty =>
      'अपना पहला बैज अर्जित करने के लिए जाप शुरू करें!';

  @override
  String get profile_mantrasEmpty =>
      'अपना कुल योग यहां देखने के लिए जाप शुरू करें!';

  @override
  String get profile_shareApp => 'नाम जाप साझा करें';

  @override
  String get profile_rateApp => 'हमारे ऐप को रेट करें';

  @override
  String get profile_supportTitle => 'नाम जाप का समर्थन करें';

  @override
  String get profile_supportSubtitle => 'ऐप को चालू रखने में मदद करें';

  @override
  String get profile_myBodhi => 'मेरा बोधि वृक्ष';

  @override
  String get profile_myBodhiSubtitle => 'आपकी भक्ति का एक दृश्य प्रमाण।';

  @override
  String get profile_yourAchievement => 'आपकी उपलब्धियाँ';

  @override
  String get profile_yourAchievements => 'आपकी उपलब्धियाँ';

  @override
  String get profile_aMark => 'आपकी निष्ठा का एक निशान।';

  @override
  String get profile_changeName => 'अपना नाम बदलें';

  @override
  String get profile_enterName => 'नया नाम दर्ज करें';

  @override
  String get settings_title => 'सेटिंग्स';

  @override
  String get settings_ambiance => 'मंदिर का माहौल';

  @override
  String get settings_ambianceDesc =>
      'मंदिर की हल्की पृष्ठभूमि वाली ध्वनियाँ बजाएँ।';

  @override
  String get settings_reminders => 'दैनिक अनुस्मारक';

  @override
  String get settings_remindersDesc =>
      'यदि आपने आज जाप नहीं किया है तो एक सूचना प्राप्त करें।';

  @override
  String get settings_language => 'ऐप की भाषा';

  @override
  String get settings_feedback => 'प्रतिक्रिया और समर्थन';

  @override
  String get settings_feedbackDesc =>
      'किसी बग की रिपोर्ट करें या किसी सुविधा का सुझाव दें।';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'गोपनीयता नीति';

  @override
  String get settings_terms => 'नियम और शर्तें';

  @override
  String get settings_deleteAccount => 'मेरा खाता हटाएं';

  @override
  String get settings_signOut => 'साइन आउट करें';

  @override
  String get dialog_deleteTitle => 'खाता हटाएं?';

  @override
  String get dialog_deleteBody =>
      'यह कार्रवाई स्थायी है और इसे पूर्ववत् नहीं किया जा सकता। आपका सारा जाप डेटा, उपलब्धियां और व्यक्तिगत जानकारी स्थायी रूप से मिटा दी जाएगी।\n\nक्या आप वाकई आगे बढ़ना चाहते हैं?';

  @override
  String get dialog_deleteConfirm => 'हाँ, मेरा खाता हटाएँ';

  @override
  String get dialog_continue => 'जारी रखें';

  @override
  String get dialog_pressBack => 'बाहर निकलने के लिए फिर से वापस दबाएँ';

  @override
  String get dialog_update => 'अपडेट आवश्यक है';

  @override
  String get dialog_updateDesc =>
      'नाम जाप का एक नया संस्करण महत्वपूर्ण अपडेट के साथ उपलब्ध है। जारी रखने के लिए कृपया ऐप को अपडेट करें।';

  @override
  String get dialog_updateNow => 'अभी अपडेट करें';

  @override
  String get dialog_save => 'सहेजें';

  @override
  String get dialog_something => 'कुछ गलत हो गया।';

  @override
  String get dialog_cancel => 'रद्द करें';

  @override
  String get misc_japps => 'जाप';

  @override
  String get misc_days => 'दिन';

  @override
  String get misc_badge => 'बैज';

  @override
  String get lang_chooseLang => 'जारी रखने के लिए अपनी पसंदीदा भाषा चुनें';

  @override
  String get lang_searchLang => 'भाषाएँ खोजें';

  @override
  String get garden_totalMala => 'मालाएँ पूरी हुईं';
}
