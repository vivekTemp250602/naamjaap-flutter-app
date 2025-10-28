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

  /// No description provided for @dialog_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get dialog_close;

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

  /// No description provided for @leaderboard_jappsToPass.
  ///
  /// In en, this message translates to:
  /// **'{count} japps to pass {playerName}'**
  String leaderboard_jappsToPass(Object count, Object playerName);

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
  String leaderboard_topMantra(Object mantra);

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

  /// No description provided for @profile_shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share Naam Jaap'**
  String get profile_shareApp;

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

  /// No description provided for @garden_totalMala.
  ///
  /// In en, this message translates to:
  /// **'Malas Completed'**
  String get garden_totalMala;

  /// No description provided for @misc_malas.
  ///
  /// In en, this message translates to:
  /// **'Malas'**
  String get misc_malas;

  /// No description provided for @leaderboard_malasToPass.
  ///
  /// In en, this message translates to:
  /// **'{count} malas to pass {playerName}'**
  String leaderboard_malasToPass(Object count, Object playerName);

  /// No description provided for @dialog_mic.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is required to record audio.'**
  String get dialog_mic;

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

  /// No description provided for @dialog_checkoutMyProgress.
  ///
  /// In en, this message translates to:
  /// **'Check out my progress on the NaamJaap app!'**
  String get dialog_checkoutMyProgress;

  /// No description provided for @dialog_couldNotOpenPS.
  ///
  /// In en, this message translates to:
  /// **'Could not open Play Store.'**
  String get dialog_couldNotOpenPS;

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

  /// No description provided for @misc_anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get misc_anonymous;

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

  /// No description provided for @support_title.
  ///
  /// In en, this message translates to:
  /// **'Your Seva Helps Our Community Grow'**
  String get support_title;

  /// No description provided for @support_desc.
  ///
  /// In en, this message translates to:
  /// **'Naam Jaap is a labor of love, built by a solo developer. Your selfless contribution (Seva) helps keep the servers running, the ads minimal, and the app free for all devotees.'**
  String get support_desc;

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
