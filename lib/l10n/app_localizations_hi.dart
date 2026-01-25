// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

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
  String get profile_rateApp => 'हमारे ऐप को रेट करें';

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

  @override
  String get misc_malas => 'मालाएँ';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName को पार करने के लिए $count मालाएँ';
  }

  @override
  String get dialog_mic =>
      'ऑडियो रिकॉर्ड करने के लिए माइक्रोफ़ोन की अनुमति आवश्यक है।';

  @override
  String get custom_create => 'अपना मंत्र बनाएँ';

  @override
  String get custom_yourMantra => 'मंत्र का नाम';

  @override
  String get custom_hint => 'जैसे, ॐ गुरवे नमः';

  @override
  String get custom_back => 'पृष्ठभूमि चुनें:';

  @override
  String get custom_addVoice => 'अपनी आवाज़ जोड़ें (वैकल्पिक):';

  @override
  String get custom_recording => 'रिकॉर्डिंग हो रही है...';

  @override
  String get custom_tapToRecord => 'रिकॉर्ड करने के लिए माइक पर टैप करें';

  @override
  String get custom_saveMantra => 'मंत्र सहेजें';

  @override
  String get custom_micAccess =>
      'ऑडियो रिकॉर्ड करने के लिए माइक्रोफ़ोन की अनुमति आवश्यक है।';

  @override
  String get profile_yourCustomMantra => 'मेरे कस्टम मंत्र';

  @override
  String get profile_noCustoms => 'आपने अभी तक कोई कस्टम मंत्र नहीं जोड़ा है।';

  @override
  String get profile_addNewMantra => 'नया मंत्र जोड़ें';

  @override
  String get dialog_profilePictureUpdate => 'प्रोफ़ाइल चित्र अपडेट किया गया!';

  @override
  String get dialog_failedToUpload => 'छवि अपलोड करने में विफल।';

  @override
  String get dialog_exceptionCard =>
      'साझा करने योग्य कार्ड संदर्भ उपलब्ध नहीं है।';

  @override
  String get dialog_couldNotOpenPS => 'प्ले स्टोर नहीं खुल सका।';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" हटाएँ?';
  }

  @override
  String get profile_deleteMantraSure =>
      'क्या आप निश्चित हैं? इस मंत्र से जुड़े सभी जाप गणनाएँ भी स्थायी रूप से हटा दी जाएँगी।';

  @override
  String get profile_yesDelete => 'हाँ, हटाएँ';

  @override
  String get profile_couldNotUserData => 'उपयोगकर्ता डेटा लोड नहीं हो सका।';

  @override
  String get misc_anonymous => 'गुमनाम';

  @override
  String get profile_sankalpaSet => 'एक पवित्र संकल्प लें';

  @override
  String get profile_sankalpaSubtitle =>
      'एक व्यक्तिगत जाप लक्ष्य निर्धारित करें।';

  @override
  String get profile_sankalpaTitle => 'आपका जप संकल्प';

  @override
  String get profile_sankalpaChanting => 'जाप कर रहे हैं';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount बार पहुंचने के लिए।';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date तक';
  }

  @override
  String get dialog_sankalpaTitle => 'अपना जप संकल्प निर्धारित करें';

  @override
  String get dialog_sankalpaSelectMantra => 'मंत्र चुनें';

  @override
  String get dialog_sankalpaTargetCount => 'लक्ष्य गणना (जैसे, 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'लक्ष्य तिथि';

  @override
  String get dialog_sankalpaSelectDate => 'एक तिथि चुनें';

  @override
  String get dialog_sankalpaSetPledge => 'मेरा संकल्प निर्धारित करें';

  @override
  String get dialog_sankalpaError => 'कृपया सभी फ़ील्ड सही ढंग से भरें।';

  @override
  String get dialog_sankalpaErrorTarget =>
      'लक्ष्य गणना आपकी वर्तमान गणना से अधिक होनी चाहिए।';

  @override
  String get support_openUPI => 'आपकी UPI ऐप खुल रही है...';

  @override
  String get support_cannotOpenUPI => 'UPI ऐप लॉन्च नहीं हो सका।';

  @override
  String get support_upiError => 'त्रुटि: खोलने के लिए कोई UPI ऐप नहीं मिला।';

  @override
  String get support_chooseOffering => 'एक भेंट चुनें';

  @override
  String get support_enterAmt => 'या एक कस्टम राशि दर्ज करें (INR)';

  @override
  String get support_validAmt => 'कृपया एक मान्य राशि चुनें या दर्ज करें।';

  @override
  String get support_now => 'अभी समर्थन करें';

  @override
  String get home_chooseMala => 'अपनी माला चुनें';

  @override
  String get home_chooseMalaDesc => 'ऐसी शैली चुनें जो आपकी आत्मा को भाए।';

  @override
  String get tour_title1 => 'डिजिटल जप माला';

  @override
  String get tour_body1 =>
      'जाप करने के लिए टैप करें। हम आपके मनकों की गिनती करते हैं, मालाओं को ट्रैक करते हैं, और आपकी स्ट्रीक को स्वचालित रूप से बनाए रखते हैं।';

  @override
  String get tour_title2 => 'ग्लोबल लीडरबोर्ड';

  @override
  String get tour_body2 =>
      'हजारों के साथ जाप करें। आध्यात्मिक प्रगति और निरंतरता के माध्यम से ऊपर उठें।';

  @override
  String get tour_title3 => 'दैनिक ज्ञान';

  @override
  String get tour_body3 =>
      'प्राचीन ग्रंथों से चुने हुए श्लोक प्राप्त करें — कई भाषाओं में उपलब्ध।';

  @override
  String get tour_title4 => 'आपकी आध्यात्मिक यात्रा';

  @override
  String get tour_body4 =>
      'मील के पत्थर ट्रैक करें, संकल्प निर्धारित करें, और अपने विकास और उपलब्धियों पर विचार करें।';

  @override
  String get dialog_getStarted => 'शुरू करें';

  @override
  String get dialog_next => 'अगला';

  @override
  String get dialog_skip => 'छोड़ें';

  @override
  String get malatype_regular => 'साधारण';

  @override
  String get malatype_crystal => 'स्फटिक';

  @override
  String get malatype_royal => 'शाही सोना';

  @override
  String get profile_abandon => 'संकल्प त्यागें';

  @override
  String get profile_progress => 'प्रगति';

  @override
  String get profile_deadline => 'समय सीमा';

  @override
  String get profile_achieved => 'प्राप्त किया!';

  @override
  String get support_donate => 'दान करें';

  @override
  String get support_paymentSucc =>
      'Razorpay द्वारा सुरक्षित रूप से भुगतान संसाधित';

  @override
  String get support_thank => '🙏 धन्यवाद';

  @override
  String get home_customizeMala => 'माला कस्टमाइज़ करें';

  @override
  String get dialog_checkoutMyProgress => 'नाम जाप ऐप पर मेरी प्रगति देखें!';

  @override
  String get appTitle => 'नाम जाप';

  @override
  String get login_welcome => 'नाम जाप में आपका स्वागत है';

  @override
  String get profile_shareApp => 'नाम जाप साझा करें';

  @override
  String get profile_supportTitle => 'नाम जाप का समर्थन करें';

  @override
  String get dialog_updateDesc =>
      'नाम जाप का एक नया संस्करण महत्वपूर्ण अपडेट के साथ उपलब्ध है। जारी रखने के लिए कृपया ऐप को अपडेट करें।';

  @override
  String get support_desc =>
      'नाम जाप प्रेम का श्रम है, जिसे एक अकेले डेवलपर ने बनाया है। आपका निःस्वार्थ योगदान (सेवा) सर्वर को चालू रखने, विज्ञापनों को न्यूनतम रखने और सभी भक्तों के लिए ऐप को मुफ्त रखने में मदद करता है।';

  @override
  String get support_title => 'नाम जाप प्रोजेक्ट का समर्थन करें';

  @override
  String get support_afterTitile =>
      'नाम जाप का समर्थन करने के लिए धन्यवाद — हर योगदान मदद करता है।';
}
