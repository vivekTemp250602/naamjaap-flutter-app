// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'নাম জপ-এ স্বাগতম';

  @override
  String get login_subtitle => 'আপনার ব্যক্তিগত ডিজিটাল জপ সঙ্গী।';

  @override
  String get login_termsAgreement => 'আমি ';

  @override
  String get login_termsAndConditions => 'শর্তাবলী';

  @override
  String get login_and => ' এবং ';

  @override
  String get login_privacyPolicy => 'গোপনীয়তা নীতিতে সম্মত।';

  @override
  String get login_signInWithGoogle => 'Google দিয়ে সাইন ইন করুন';

  @override
  String get nav_home => 'হোম';

  @override
  String get nav_leaderboard => 'লিডারবোর্ড';

  @override
  String get nav_wisdom => 'জ্ঞান';

  @override
  String get nav_profile => 'আমার প্রোফাইল';

  @override
  String get home_tapToChant => 'জপ করতে ট্যাপ করুন';

  @override
  String get home_dayStreak => 'দিনের স্ট্রিক';

  @override
  String get home_total => 'মোট:';

  @override
  String get home_mantraInfo => 'মন্ত্রের তথ্য';

  @override
  String get dialog_close => 'বন্ধ করুন';

  @override
  String get wisdom_title => 'আজকের জ্ঞান';

  @override
  String get wisdom_dismissed =>
      'আজকের জ্ঞানের উপর ভাবনা করা হয়েছে।\nএকটি নতুন অন্তর্দৃষ্টি কাল আসবে।';

  @override
  String get wisdom_loading => 'জ্ঞান লোড হচ্ছে...';

  @override
  String get leaderboard_allTime => 'সর্বকালের';

  @override
  String get leaderboard_thisWeek => 'এই সপ্তাহ';

  @override
  String get leaderboard_yourProgress => 'আপনার অগ্রগতি';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName-কে পার করতে $count জপ';
  }

  @override
  String get leaderboard_empty => 'যাত্রা শুরু হলো!';

  @override
  String get leaderboard_emptySubtitle =>
      'লিডারবোর্ডে প্রথম স্থান অর্জনকারী হোন!';

  @override
  String get leaderboard_isEmpty => 'লিডারবোর্ড খালি।';

  @override
  String get leaderboard_noBade => 'এখনও কোনো ব্যাজ নেই';

  @override
  String get leaderboard_notOnBoard => 'বোর্ডে স্থান পেতে জপ করতে থাকুন!';

  @override
  String get leaderboard_topOfBoard => 'আপনি শীর্ষে আছেন! ✨';

  @override
  String get leaderboard_noChants => 'এখনও কোনো জপ নেই';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'শীর্ষ মন্ত্র: $mantra';
  }

  @override
  String get profile_yourProgress => 'আপনার অগ্রগতি';

  @override
  String get profile_dailyStreak => 'দৈনিক স্ট্রিক';

  @override
  String get profile_totalJapps => 'মোট জপ';

  @override
  String get profile_globalRank => 'গ্লোবাল র‍্যাঙ্ক';

  @override
  String get profile_mantraTotals => 'মন্ত্রের মোট সংখ্যা';

  @override
  String get profile_achievements => 'কৃতিত্ব';

  @override
  String get profile_shareProgress => 'আপনার অগ্রগতি শেয়ার করুন';

  @override
  String get profile_badgesEmpty =>
      'আপনার প্রথম ব্যাজ অর্জন করতে জপ শুরু করুন!';

  @override
  String get profile_mantrasEmpty =>
      'আপনার মোট সংখ্যা এখানে দেখতে জপ শুরু করুন!';

  @override
  String get profile_shareApp => 'নাম জপ শেয়ার করুন';

  @override
  String get profile_rateApp => 'আমাদের অ্যাপ রেট করুন';

  @override
  String get profile_supportTitle => 'নাম জপ সমর্থন করুন';

  @override
  String get profile_supportSubtitle => 'অ্যাপটি চালু রাখতে সাহায্য করুন';

  @override
  String get profile_myBodhi => 'আমার বোধি গাছ';

  @override
  String get profile_myBodhiSubtitle => 'আপনার ভক্তির একটি চাক্ষুষ প্রমাণ।';

  @override
  String get profile_yourAchievement => 'আপনার অর্জনসমূহ';

  @override
  String get profile_yourAchievements => 'আপনার অর্জনসমূহ';

  @override
  String get profile_aMark => 'আপনার উৎসর্গের একটি চিহ্ন।';

  @override
  String get profile_changeName => 'আপনার নাম পরিবর্তন করুন';

  @override
  String get profile_enterName => 'নতুন নাম লিখুন';

  @override
  String get settings_title => 'সেটিংস';

  @override
  String get settings_ambiance => 'মন্দিরের পরিবেশ';

  @override
  String get settings_ambianceDesc => 'হালকা পটভূমিতে মন্দিরের শব্দ বাজান।';

  @override
  String get settings_reminders => 'দৈনিক অনুস্মারক';

  @override
  String get settings_remindersDesc =>
      'আপনি যদি আজ জপ না করে থাকেন তবে একটি বিজ্ঞপ্তি পান।';

  @override
  String get settings_language => 'অ্যাপের ভাষা';

  @override
  String get settings_feedback => 'মতামত ও সমর্থন';

  @override
  String get settings_feedbackDesc =>
      'একটি বাগ রিপোর্ট করুন বা একটি বৈশিষ্ট্যের পরামর্শ দিন।';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'গোপনীয়তা নীতি';

  @override
  String get settings_terms => 'শর্তাবলী';

  @override
  String get settings_deleteAccount => 'আমার অ্যাকাউন্ট মুছুন';

  @override
  String get settings_signOut => 'সাইন আউট';

  @override
  String get dialog_deleteTitle => 'অ্যাকাউন্ট মুছবেন?';

  @override
  String get dialog_deleteBody =>
      'এই পদক্ষেপটি স্থায়ী এবং এটি পূর্বাবস্থায় ফেরানো যাবে না। আপনার সমস্ত জপের ডেটা, কৃতিত্ব এবং ব্যক্তিগত তথ্য স্থায়ীভাবে মুছে ফেলা হবে।\n\nআপনি কি সত্যিই এগিয়ে যেতে চান?';

  @override
  String get dialog_deleteConfirm => 'হ্যাঁ, আমার অ্যাকাউন্ট মুছুন';

  @override
  String get dialog_continue => 'চালিয়ে যান';

  @override
  String get dialog_pressBack => 'বের হতে আবার পিছনে চাপুন';

  @override
  String get dialog_update => 'আপডেট প্রয়োজন';

  @override
  String get dialog_updateDesc =>
      'গুরুত্বপূর্ণ আপডেট সহ নাম জপের একটি নতুন সংস্করণ উপলব্ধ। চালিয়ে যেতে দয়া করে অ্যাপটি আপডেট করুন।';

  @override
  String get dialog_updateNow => 'এখন আপডেট করুন';

  @override
  String get dialog_save => 'সংরক্ষণ করুন';

  @override
  String get dialog_something => 'কিছু ভুল হয়েছে।';

  @override
  String get dialog_cancel => 'বাতিল করুন';

  @override
  String get misc_japps => 'জপ';

  @override
  String get misc_days => 'দিন';

  @override
  String get misc_badge => 'ব্যাজ';

  @override
  String get lang_chooseLang => 'চালিয়ে যেতে আপনার পছন্দের ভাষা নির্বাচন করুন';

  @override
  String get lang_searchLang => 'ভাষা অনুসন্ধান করুন';

  @override
  String get garden_totalMala => 'মালা সম্পন্ন হয়েছে';
}
