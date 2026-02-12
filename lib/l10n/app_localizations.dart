import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bh.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bh'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('gu'),
    Locale('hi'),
    Locale('ja'),
    Locale('kn'),
    Locale('ko'),
    Locale('ml'),
    Locale('mr'),
    Locale('or'),
    Locale('pa'),
    Locale('ru'),
    Locale('ta'),
    Locale('te'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Naam Jaap'**
  String get appTitle;

  /// No description provided for @login_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Naam Jaap'**
  String get login_welcome;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your personal digital chanting companion.'**
  String get login_subtitle;

  /// No description provided for @login_termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the '**
  String get login_termsAgreement;

  /// No description provided for @login_termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get login_termsAndConditions;

  /// No description provided for @login_and.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get login_and;

  /// No description provided for @login_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get login_privacyPolicy;

  /// No description provided for @login_signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get login_signInWithGoogle;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get nav_leaderboard;

  /// No description provided for @nav_wisdom.
  ///
  /// In en, this message translates to:
  /// **'Wisdom'**
  String get nav_wisdom;

  /// No description provided for @nav_profile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get nav_profile;

  /// No description provided for @home_tapToChant.
  ///
  /// In en, this message translates to:
  /// **'Tap to Chant'**
  String get home_tapToChant;

  /// No description provided for @home_dayStreak.
  ///
  /// In en, this message translates to:
  /// **'Day Streak'**
  String get home_dayStreak;

  /// No description provided for @home_total.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get home_total;

  /// No description provided for @home_mantraInfo.
  ///
  /// In en, this message translates to:
  /// **'Mantra Info'**
  String get home_mantraInfo;

  /// No description provided for @home_chooseMala.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Mala'**
  String get home_chooseMala;

  /// No description provided for @home_chooseMalaDesc.
  ///
  /// In en, this message translates to:
  /// **'Select a style that resonates with your spirit.'**
  String get home_chooseMalaDesc;

  /// No description provided for @home_customizeMala.
  ///
  /// In en, this message translates to:
  /// **'Customize Mala'**
  String get home_customizeMala;

  /// No description provided for @tour_home_carousel_title.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Mantra'**
  String get tour_home_carousel_title;

  /// No description provided for @tour_home_carousel_desc.
  ///
  /// In en, this message translates to:
  /// **'Swipe left or right to switch between powerful Vedic mantras.'**
  String get tour_home_carousel_desc;

  /// No description provided for @tour_home_mala_title.
  ///
  /// In en, this message translates to:
  /// **'Tap to Chant'**
  String get tour_home_mala_title;

  /// No description provided for @tour_home_mala_desc.
  ///
  /// In en, this message translates to:
  /// **'Tap anywhere on the circle to move the beads. Complete 108 for one Mala.'**
  String get tour_home_mala_desc;

  /// No description provided for @tour_home_toolkit_title.
  ///
  /// In en, this message translates to:
  /// **'Your Toolkit'**
  String get tour_home_toolkit_title;

  /// No description provided for @tour_home_toolkit_desc.
  ///
  /// In en, this message translates to:
  /// **'Customize bead styles, toggle audio, or view mantra meanings.'**
  String get tour_home_toolkit_desc;

  /// No description provided for @tour_leader_toggle_title.
  ///
  /// In en, this message translates to:
  /// **'Weekly vs All-Time'**
  String get tour_leader_toggle_title;

  /// No description provided for @tour_leader_toggle_desc.
  ///
  /// In en, this message translates to:
  /// **'Tap here to switch between this week\'s leaders and the legends of all time.'**
  String get tour_leader_toggle_desc;

  /// No description provided for @tour_leader_podium_title.
  ///
  /// In en, this message translates to:
  /// **'The Top 3'**
  String get tour_leader_podium_title;

  /// No description provided for @tour_leader_podium_desc.
  ///
  /// In en, this message translates to:
  /// **'The most dedicated chanters appear here. Keep chanting to join them!'**
  String get tour_leader_podium_desc;

  /// No description provided for @tour_wisdom_card_title.
  ///
  /// In en, this message translates to:
  /// **'Daily Wisdom & Sharing'**
  String get tour_wisdom_card_title;

  /// No description provided for @tour_wisdom_card_desc.
  ///
  /// In en, this message translates to:
  /// **'Start your day with a new Shloka. Tap the Share Icon to create a beautiful image for your Status!'**
  String get tour_wisdom_card_desc;

  /// No description provided for @tour_profile_stats_title.
  ///
  /// In en, this message translates to:
  /// **'Your Spiritual Stats'**
  String get tour_profile_stats_title;

  /// No description provided for @tour_profile_stats_desc.
  ///
  /// In en, this message translates to:
  /// **'Track your Streak, Total Japa count, and Global Rank here.'**
  String get tour_profile_stats_desc;

  /// No description provided for @tour_profile_offline_title.
  ///
  /// In en, this message translates to:
  /// **'Physical Chanting?'**
  String get tour_profile_offline_title;

  /// No description provided for @tour_profile_offline_desc.
  ///
  /// In en, this message translates to:
  /// **'If you use a real Mala beads, tap here to manually add your counts to the app.'**
  String get tour_profile_offline_desc;

  /// No description provided for @tour_profile_bodhi_desc.
  ///
  /// In en, this message translates to:
  /// **'Every Mala you chant helps your spiritual garden grow. Unlock new trees as you progress!'**
  String get tour_profile_bodhi_desc;

  /// No description provided for @tour_profile_sankalpa_desc.
  ///
  /// In en, this message translates to:
  /// **'Set a target date and count to commit to a spiritual goal. We will help you track it.'**
  String get tour_profile_sankalpa_desc;

  /// No description provided for @guest_mode_title.
  ///
  /// In en, this message translates to:
  /// **'Guest Mode'**
  String get guest_mode_title;

  /// No description provided for @guest_mode_desc.
  ///
  /// In en, this message translates to:
  /// **'Sign in to unlock your spiritual profile.'**
  String get guest_mode_desc;

  /// No description provided for @guest_signin_btn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get guest_signin_btn;

  /// No description provided for @wisdom_title.
  ///
  /// In en, this message translates to:
  /// **'Wisdom for Today'**
  String get wisdom_title;

  /// No description provided for @wisdom_dismissed.
  ///
  /// In en, this message translates to:
  /// **'Today\'s wisdom has been contemplated.\nA new insight will arrive tomorrow.'**
  String get wisdom_dismissed;

  /// No description provided for @wisdom_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading wisdom...'**
  String get wisdom_loading;

  /// No description provided for @wisdom_signin_to_share.
  ///
  /// In en, this message translates to:
  /// **'Sign in to share wisdom cards!'**
  String get wisdom_signin_to_share;

  /// No description provided for @wisdom_creating_card.
  ///
  /// In en, this message translates to:
  /// **'Creating your divine card...'**
  String get wisdom_creating_card;

  /// No description provided for @leaderboard_allTime.
  ///
  /// In en, this message translates to:
  /// **'All-Time'**
  String get leaderboard_allTime;

  /// No description provided for @leaderboard_thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get leaderboard_thisWeek;

  /// No description provided for @leaderboard_yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get leaderboard_yourProgress;

  /// No description provided for @leaderboard_yourRank.
  ///
  /// In en, this message translates to:
  /// **'Your Rank'**
  String get leaderboard_yourRank;

  /// No description provided for @leaderboard_jappsToPass.
  ///
  /// In en, this message translates to:
  /// **'{count} japps to pass {playerName}'**
  String leaderboard_jappsToPass(Object count, Object playerName);

  /// No description provided for @leaderboard_malasToPass.
  ///
  /// In en, this message translates to:
  /// **'{count} malas to pass {playerName}'**
  String leaderboard_malasToPass(Object count, Object playerName);

  /// No description provided for @leaderboard_empty.
  ///
  /// In en, this message translates to:
  /// **'The Journey begins!'**
  String get leaderboard_empty;

  /// No description provided for @leaderboard_emptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Be the first to grace the leaderboard!'**
  String get leaderboard_emptySubtitle;

  /// No description provided for @leaderboard_isEmpty.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard is empty.'**
  String get leaderboard_isEmpty;

  /// No description provided for @leaderboard_noBade.
  ///
  /// In en, this message translates to:
  /// **'No badges yet'**
  String get leaderboard_noBade;

  /// No description provided for @leaderboard_notOnBoard.
  ///
  /// In en, this message translates to:
  /// **'Keep chanting to get on the board!'**
  String get leaderboard_notOnBoard;

  /// No description provided for @leaderboard_topOfBoard.
  ///
  /// In en, this message translates to:
  /// **'You\'re at the top! ✨'**
  String get leaderboard_topOfBoard;

  /// No description provided for @leaderboard_noChants.
  ///
  /// In en, this message translates to:
  /// **'No chants yet'**
  String get leaderboard_noChants;

  /// No description provided for @leaderboard_topMantra.
  ///
  /// In en, this message translates to:
  /// **'Top Mantra: {mantra}'**
  String leaderboard_topMantra(String mantra);

  /// No description provided for @profile_yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get profile_yourProgress;

  /// No description provided for @profile_dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak'**
  String get profile_dailyStreak;

  /// No description provided for @profile_totalJapps.
  ///
  /// In en, this message translates to:
  /// **'Total Japps'**
  String get profile_totalJapps;

  /// No description provided for @profile_globalRank.
  ///
  /// In en, this message translates to:
  /// **'Global Rank'**
  String get profile_globalRank;

  /// No description provided for @profile_mantraTotals.
  ///
  /// In en, this message translates to:
  /// **'Mantra Totals'**
  String get profile_mantraTotals;

  /// No description provided for @profile_achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get profile_achievements;

  /// No description provided for @profile_shareProgress.
  ///
  /// In en, this message translates to:
  /// **'Share Your Progress'**
  String get profile_shareProgress;

  /// No description provided for @profile_badgesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Start chanting to earn your first badge!'**
  String get profile_badgesEmpty;

  /// No description provided for @profile_mantrasEmpty.
  ///
  /// In en, this message translates to:
  /// **'Start chanting to see your totals here!'**
  String get profile_mantrasEmpty;

  /// No description provided for @profile_rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate Our App'**
  String get profile_rateApp;

  /// No description provided for @profile_supportTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Naam Jaap'**
  String get profile_supportTitle;

  /// No description provided for @profile_supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help keep the app running'**
  String get profile_supportSubtitle;

  /// No description provided for @profile_myBodhi.
  ///
  /// In en, this message translates to:
  /// **'My Bodhi Tree'**
  String get profile_myBodhi;

  /// No description provided for @profile_myBodhiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A visual testament to your devotion.'**
  String get profile_myBodhiSubtitle;

  /// No description provided for @profile_yourAchievement.
  ///
  /// In en, this message translates to:
  /// **'Your Achievements'**
  String get profile_yourAchievement;

  /// No description provided for @profile_yourAchievements.
  ///
  /// In en, this message translates to:
  /// **'Your Achievements'**
  String get profile_yourAchievements;

  /// No description provided for @profile_aMark.
  ///
  /// In en, this message translates to:
  /// **'A mark of your dedication.'**
  String get profile_aMark;

  /// No description provided for @profile_changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Your Name'**
  String get profile_changeName;

  /// No description provided for @profile_enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter new Name'**
  String get profile_enterName;

  /// No description provided for @profile_shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share Naam Jaap'**
  String get profile_shareApp;

  /// No description provided for @profile_yourCustomMantra.
  ///
  /// In en, this message translates to:
  /// **'My Custom Mantras'**
  String get profile_yourCustomMantra;

  /// No description provided for @profile_noCustoms.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any custom mantras yet.'**
  String get profile_noCustoms;

  /// No description provided for @profile_addNewMantra.
  ///
  /// In en, this message translates to:
  /// **'Add New Mantra'**
  String get profile_addNewMantra;

  /// No description provided for @profile_deleteMantra.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{mantraName}\"?'**
  String profile_deleteMantra(Object mantraName);

  /// No description provided for @profile_deleteMantraSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? All japa counts associated with this mantra will also be permanently deleted.'**
  String get profile_deleteMantraSure;

  /// No description provided for @profile_yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get profile_yesDelete;

  /// No description provided for @profile_couldNotUserData.
  ///
  /// In en, this message translates to:
  /// **'Could not load user data.'**
  String get profile_couldNotUserData;

  /// No description provided for @profile_offline_card_title.
  ///
  /// In en, this message translates to:
  /// **'Log Offline Japa'**
  String get profile_offline_card_title;

  /// No description provided for @profile_offline_card_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Add counts from your physical mala'**
  String get profile_offline_card_subtitle;

  /// No description provided for @profile_gamification_header.
  ///
  /// In en, this message translates to:
  /// **'Gamification'**
  String get profile_gamification_header;

  /// No description provided for @profile_commitments_header.
  ///
  /// In en, this message translates to:
  /// **'Commitments'**
  String get profile_commitments_header;

  /// No description provided for @profile_insights_header.
  ///
  /// In en, this message translates to:
  /// **'Mantra Insights'**
  String get profile_insights_header;

  /// No description provided for @profile_my_mantras_header.
  ///
  /// In en, this message translates to:
  /// **'My Mantras'**
  String get profile_my_mantras_header;

  /// No description provided for @profile_quick_actions_header.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get profile_quick_actions_header;

  /// No description provided for @profile_sankalpaSet.
  ///
  /// In en, this message translates to:
  /// **'Make a Sacred Vow'**
  String get profile_sankalpaSet;

  /// No description provided for @profile_sankalpaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set a personal chanting goal.'**
  String get profile_sankalpaSubtitle;

  /// No description provided for @profile_sankalpaTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Japa Sankalpa'**
  String get profile_sankalpaTitle;

  /// No description provided for @profile_sankalpaChanting.
  ///
  /// In en, this message translates to:
  /// **'Chanting'**
  String get profile_sankalpaChanting;

  /// No description provided for @profile_abandon.
  ///
  /// In en, this message translates to:
  /// **'Abandon Vow'**
  String get profile_abandon;

  /// No description provided for @profile_progress.
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get profile_progress;

  /// No description provided for @profile_deadline.
  ///
  /// In en, this message translates to:
  /// **'DEADLINE'**
  String get profile_deadline;

  /// No description provided for @profile_achieved.
  ///
  /// In en, this message translates to:
  /// **'Achieved!'**
  String get profile_achieved;

  /// No description provided for @profile_sankalpaToReach.
  ///
  /// In en, this message translates to:
  /// **' to reach {targetCount} times.'**
  String profile_sankalpaToReach(int targetCount);

  /// No description provided for @profile_sankalpaByDate.
  ///
  /// In en, this message translates to:
  /// **'By {date}'**
  String profile_sankalpaByDate(String date);

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_ambiance.
  ///
  /// In en, this message translates to:
  /// **'Temple Ambiance'**
  String get settings_ambiance;

  /// No description provided for @settings_ambianceDesc.
  ///
  /// In en, this message translates to:
  /// **'Play subtle background temple sounds.'**
  String get settings_ambianceDesc;

  /// No description provided for @settings_reminders.
  ///
  /// In en, this message translates to:
  /// **'Daily Reminders'**
  String get settings_reminders;

  /// No description provided for @settings_remindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Get a notification if you haven\'t chanted today.'**
  String get settings_remindersDesc;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get settings_language;

  /// No description provided for @settings_feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback & Support'**
  String get settings_feedback;

  /// No description provided for @settings_feedbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Report a bug or suggest a feature.'**
  String get settings_feedbackDesc;

  /// No description provided for @settings_deletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Deleting your account...'**
  String get settings_deletingAccount;

  /// No description provided for @settings_privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settings_privacy;

  /// No description provided for @settings_terms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settings_terms;

  /// No description provided for @settings_deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete My Account'**
  String get settings_deleteAccount;

  /// No description provided for @settings_signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settings_signOut;

  /// No description provided for @settings_exit_guest.
  ///
  /// In en, this message translates to:
  /// **'Exit Guest Mode'**
  String get settings_exit_guest;

  /// No description provided for @settings_support_header.
  ///
  /// In en, this message translates to:
  /// **'Support & Legal'**
  String get settings_support_header;

  /// No description provided for @settings_account_header.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_account_header;

  /// No description provided for @support_title.
  ///
  /// In en, this message translates to:
  /// **'Support the Naam Jaap project'**
  String get support_title;

  /// No description provided for @support_desc.
  ///
  /// In en, this message translates to:
  /// **'Naam Jaap is a labor of love, built by a solo developer. Your selfless contribution (Seva) helps keep the servers running, the ads minimal, and the app free for all devotees.'**
  String get support_desc;

  /// No description provided for @support_afterTitile.
  ///
  /// In en, this message translates to:
  /// **'Thank you for supporting Naam Jaap — every contribution helps.'**
  String get support_afterTitile;

  /// No description provided for @support_openUPI.
  ///
  /// In en, this message translates to:
  /// **'Opening your UPI app...'**
  String get support_openUPI;

  /// No description provided for @support_cannotOpenUPI.
  ///
  /// In en, this message translates to:
  /// **'Could not launch UPI app.'**
  String get support_cannotOpenUPI;

  /// No description provided for @support_upiError.
  ///
  /// In en, this message translates to:
  /// **'Error: Could not find a UPI app to open.'**
  String get support_upiError;

  /// No description provided for @support_chooseOffering.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE AN OFFERING'**
  String get support_chooseOffering;

  /// No description provided for @support_enterAmt.
  ///
  /// In en, this message translates to:
  /// **'Or enter a custom amount (INR)'**
  String get support_enterAmt;

  /// No description provided for @support_validAmt.
  ///
  /// In en, this message translates to:
  /// **'Please select or enter a valid amount.'**
  String get support_validAmt;

  /// No description provided for @support_now.
  ///
  /// In en, this message translates to:
  /// **'Support Now'**
  String get support_now;

  /// No description provided for @support_donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get support_donate;

  /// No description provided for @support_paymentSucc.
  ///
  /// In en, this message translates to:
  /// **'Payments processed securely by Razorpay'**
  String get support_paymentSucc;

  /// No description provided for @support_thank.
  ///
  /// In en, this message translates to:
  /// **'🙏 Thank you'**
  String get support_thank;

  /// No description provided for @support_offer_seva.
  ///
  /// In en, this message translates to:
  /// **'Offer Seva'**
  String get support_offer_seva;

  /// No description provided for @support_signin_required.
  ///
  /// In en, this message translates to:
  /// **'Please sign in to make a contribution.'**
  String get support_signin_required;

  /// No description provided for @support_payment_error.
  ///
  /// In en, this message translates to:
  /// **'Could not start payment. Please try again.'**
  String get support_payment_error;

  /// No description provided for @support_blessed.
  ///
  /// In en, this message translates to:
  /// **'May you be blessed.'**
  String get support_blessed;

  /// No description provided for @support_tier_flower.
  ///
  /// In en, this message translates to:
  /// **'Flower Offering'**
  String get support_tier_flower;

  /// No description provided for @support_tier_lamp.
  ///
  /// In en, this message translates to:
  /// **'Lamp Lighting'**
  String get support_tier_lamp;

  /// No description provided for @support_tier_garland.
  ///
  /// In en, this message translates to:
  /// **'Garland Seva'**
  String get support_tier_garland;

  /// No description provided for @support_tier_temple.
  ///
  /// In en, this message translates to:
  /// **'Temple Support'**
  String get support_tier_temple;

  /// No description provided for @support_tier_grand.
  ///
  /// In en, this message translates to:
  /// **'Grand Offering'**
  String get support_tier_grand;

  /// No description provided for @custom_create.
  ///
  /// In en, this message translates to:
  /// **'Create Your Mantra'**
  String get custom_create;

  /// No description provided for @custom_yourMantra.
  ///
  /// In en, this message translates to:
  /// **'Mantra Name'**
  String get custom_yourMantra;

  /// No description provided for @custom_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Om Gurave Namah'**
  String get custom_hint;

  /// No description provided for @custom_back.
  ///
  /// In en, this message translates to:
  /// **'Choose a background:'**
  String get custom_back;

  /// No description provided for @custom_addVoice.
  ///
  /// In en, this message translates to:
  /// **'Add your voice (Optional):'**
  String get custom_addVoice;

  /// No description provided for @custom_recording.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get custom_recording;

  /// No description provided for @custom_tapToRecord.
  ///
  /// In en, this message translates to:
  /// **'Tap the mic to record'**
  String get custom_tapToRecord;

  /// No description provided for @custom_saveMantra.
  ///
  /// In en, this message translates to:
  /// **'Save Mantra'**
  String get custom_saveMantra;

  /// No description provided for @custom_micAccess.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is required to record audio.'**
  String get custom_micAccess;

  /// No description provided for @custom_preview.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW'**
  String get custom_preview;

  /// No description provided for @custom_voice_saved.
  ///
  /// In en, this message translates to:
  /// **'Voice Note Saved'**
  String get custom_voice_saved;

  /// No description provided for @custom_tap_record.
  ///
  /// In en, this message translates to:
  /// **'Tap to Record'**
  String get custom_tap_record;

  /// No description provided for @custom_ready_use.
  ///
  /// In en, this message translates to:
  /// **'Ready to use'**
  String get custom_ready_use;

  /// No description provided for @custom_error_empty_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter a mantra name'**
  String get custom_error_empty_name;

  /// No description provided for @garden_title.
  ///
  /// In en, this message translates to:
  /// **'Bodhi Garden'**
  String get garden_title;

  /// No description provided for @garden_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Grow your spiritual forest'**
  String get garden_subtitle;

  /// No description provided for @garden_growth.
  ///
  /// In en, this message translates to:
  /// **'Spiritual Growth'**
  String get garden_growth;

  /// No description provided for @garden_totalMala.
  ///
  /// In en, this message translates to:
  /// **'Malas Completed'**
  String get garden_totalMala;

  /// No description provided for @dialog_deleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get dialog_deleteTitle;

  /// No description provided for @dialog_deleteBody.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be undone. All your chanting data, achievements, and personal information will be permanently erased.\n\nAre you absolutely sure you want to proceed?'**
  String get dialog_deleteBody;

  /// No description provided for @dialog_deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete My Account'**
  String get dialog_deleteConfirm;

  /// No description provided for @dialog_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get dialog_continue;

  /// No description provided for @dialog_pressBack.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get dialog_pressBack;

  /// No description provided for @dialog_update.
  ///
  /// In en, this message translates to:
  /// **'Update Required'**
  String get dialog_update;

  /// No description provided for @dialog_updateDesc.
  ///
  /// In en, this message translates to:
  /// **'A new version of Naam Jaap is available with important updates. Please update the app to continue.'**
  String get dialog_updateDesc;

  /// No description provided for @dialog_updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update Now'**
  String get dialog_updateNow;

  /// No description provided for @dialog_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get dialog_save;

  /// No description provided for @dialog_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialog_close;

  /// No description provided for @dialog_something.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get dialog_something;

  /// No description provided for @dialog_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get dialog_cancel;

  /// No description provided for @dialog_profilePictureUpdate.
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated!'**
  String get dialog_profilePictureUpdate;

  /// No description provided for @dialog_failedToUpload.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload image.'**
  String get dialog_failedToUpload;

  /// No description provided for @dialog_exceptionCard.
  ///
  /// In en, this message translates to:
  /// **'Shareable card context is not available.'**
  String get dialog_exceptionCard;

  /// No description provided for @dialog_couldNotOpenPS.
  ///
  /// In en, this message translates to:
  /// **'Could not open Play Store.'**
  String get dialog_couldNotOpenPS;

  /// No description provided for @dialog_mic.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is required to record audio.'**
  String get dialog_mic;

  /// No description provided for @dialog_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get dialog_getStarted;

  /// No description provided for @dialog_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get dialog_next;

  /// No description provided for @dialog_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get dialog_skip;

  /// No description provided for @dialog_checkoutMyProgress.
  ///
  /// In en, this message translates to:
  /// **'Check out my progress on the Naam Jaap app!'**
  String get dialog_checkoutMyProgress;

  /// No description provided for @dialog_sankalpaTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Your Japa Sankalpa'**
  String get dialog_sankalpaTitle;

  /// No description provided for @dialog_sankalpaSelectMantra.
  ///
  /// In en, this message translates to:
  /// **'Select Mantra'**
  String get dialog_sankalpaSelectMantra;

  /// No description provided for @dialog_sankalpaTargetCount.
  ///
  /// In en, this message translates to:
  /// **'Target Count (e.g., 11000)'**
  String get dialog_sankalpaTargetCount;

  /// No description provided for @dialog_sankalpaTargetDate.
  ///
  /// In en, this message translates to:
  /// **'Target Date'**
  String get dialog_sankalpaTargetDate;

  /// No description provided for @dialog_sankalpaSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get dialog_sankalpaSelectDate;

  /// No description provided for @dialog_sankalpaSetPledge.
  ///
  /// In en, this message translates to:
  /// **'Set My Vow'**
  String get dialog_sankalpaSetPledge;

  /// No description provided for @dialog_sankalpaError.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields correctly.'**
  String get dialog_sankalpaError;

  /// No description provided for @dialog_sankalpaErrorTarget.
  ///
  /// In en, this message translates to:
  /// **'Target count must be greater than your current count.'**
  String get dialog_sankalpaErrorTarget;

  /// No description provided for @misc_japps.
  ///
  /// In en, this message translates to:
  /// **'japps'**
  String get misc_japps;

  /// No description provided for @misc_days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get misc_days;

  /// No description provided for @misc_badge.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get misc_badge;

  /// No description provided for @misc_malas.
  ///
  /// In en, this message translates to:
  /// **'Malas'**
  String get misc_malas;

  /// No description provided for @misc_anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get misc_anonymous;

  /// No description provided for @lang_chooseLang.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language to continue'**
  String get lang_chooseLang;

  /// No description provided for @lang_searchLang.
  ///
  /// In en, this message translates to:
  /// **'Search Languages'**
  String get lang_searchLang;

  /// No description provided for @malatype_regular.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get malatype_regular;

  /// No description provided for @malatype_crystal.
  ///
  /// In en, this message translates to:
  /// **'Crystal'**
  String get malatype_crystal;

  /// No description provided for @malatype_royal.
  ///
  /// In en, this message translates to:
  /// **'Royal Gold'**
  String get malatype_royal;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'bh',
        'bn',
        'de',
        'en',
        'es',
        'fr',
        'gu',
        'hi',
        'ja',
        'kn',
        'ko',
        'ml',
        'mr',
        'or',
        'pa',
        'ru',
        'ta',
        'te',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bh':
      return AppLocalizationsBh();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'kn':
      return AppLocalizationsKn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
    case 'ru':
      return AppLocalizationsRu();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
