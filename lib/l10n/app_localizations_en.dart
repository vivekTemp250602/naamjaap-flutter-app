// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Welcome to Naam Jaap';

  @override
  String get login_subtitle => 'Your personal digital chanting companion.';

  @override
  String get login_termsAgreement => 'I have read and agree to the ';

  @override
  String get login_termsAndConditions => 'Terms & Conditions';

  @override
  String get login_and => ' and ';

  @override
  String get login_privacyPolicy => 'Privacy Policy';

  @override
  String get login_signInWithGoogle => 'Sign in with Google';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_leaderboard => 'Leaderboard';

  @override
  String get nav_wisdom => 'Wisdom';

  @override
  String get nav_profile => 'My Profile';

  @override
  String get home_tapToChant => 'Tap to Chant';

  @override
  String get home_dayStreak => 'Day Streak';

  @override
  String get home_total => 'Total:';

  @override
  String get home_mantraInfo => 'Mantra Info';

  @override
  String get home_chooseMala => 'Choose Your Mala';

  @override
  String get home_chooseMalaDesc =>
      'Select a style that resonates with your spirit.';

  @override
  String get home_customizeMala => 'Customize Mala';

  @override
  String get tour_home_carousel_title => 'Choose Your Mantra';

  @override
  String get tour_home_carousel_desc =>
      'Swipe left or right to switch between powerful Vedic mantras.';

  @override
  String get tour_home_mala_title => 'Tap to Chant';

  @override
  String get tour_home_mala_desc =>
      'Tap anywhere on the circle to move the beads. Complete 108 for one Mala.';

  @override
  String get tour_home_toolkit_title => 'Your Toolkit';

  @override
  String get tour_home_toolkit_desc =>
      'Customize bead styles, toggle audio, or view mantra meanings.';

  @override
  String get tour_leader_toggle_title => 'Weekly vs All-Time';

  @override
  String get tour_leader_toggle_desc =>
      'Tap here to switch between this week\'s leaders and the legends of all time.';

  @override
  String get tour_leader_podium_title => 'The Top 3';

  @override
  String get tour_leader_podium_desc =>
      'The most dedicated chanters appear here. Keep chanting to join them!';

  @override
  String get tour_wisdom_card_title => 'Daily Wisdom & Sharing';

  @override
  String get tour_wisdom_card_desc =>
      'Start your day with a new Shloka. Tap the Share Icon to create a beautiful image for your Status!';

  @override
  String get tour_profile_stats_title => 'Your Spiritual Stats';

  @override
  String get tour_profile_stats_desc =>
      'Track your Streak, Total Japa count, and Global Rank here.';

  @override
  String get tour_profile_offline_title => 'Physical Chanting?';

  @override
  String get tour_profile_offline_desc =>
      'If you use a real Mala beads, tap here to manually add your counts to the app.';

  @override
  String get tour_profile_bodhi_desc =>
      'Every Mala you chant helps your spiritual garden grow. Unlock new trees as you progress!';

  @override
  String get tour_profile_sankalpa_desc =>
      'Set a target date and count to commit to a spiritual goal. We will help you track it.';

  @override
  String get guest_mode_title => 'Guest Mode';

  @override
  String get guest_mode_desc => 'Sign in to unlock your spiritual profile.';

  @override
  String get guest_signin_btn => 'Sign In';

  @override
  String get wisdom_title => 'Wisdom for Today';

  @override
  String get wisdom_dismissed =>
      'Today\'s wisdom has been contemplated.\nA new insight will arrive tomorrow.';

  @override
  String get wisdom_loading => 'Loading wisdom...';

  @override
  String get wisdom_signin_to_share => 'Sign in to share wisdom cards!';

  @override
  String get wisdom_creating_card => 'Creating your divine card...';

  @override
  String get leaderboard_allTime => 'All-Time';

  @override
  String get leaderboard_thisWeek => 'This Week';

  @override
  String get leaderboard_yourProgress => 'Your Progress';

  @override
  String get leaderboard_yourRank => 'Your Rank';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count japps to pass $playerName';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count malas to pass $playerName';
  }

  @override
  String get leaderboard_empty => 'The Journey begins!';

  @override
  String get leaderboard_emptySubtitle =>
      'Be the first to grace the leaderboard!';

  @override
  String get leaderboard_isEmpty => 'Leaderboard is empty.';

  @override
  String get leaderboard_noBade => 'No badges yet';

  @override
  String get leaderboard_notOnBoard => 'Keep chanting to get on the board!';

  @override
  String get leaderboard_topOfBoard => 'You\'re at the top! ✨';

  @override
  String get leaderboard_noChants => 'No chants yet';

  @override
  String leaderboard_topMantra(String mantra) {
    return 'Top Mantra: $mantra';
  }

  @override
  String get profile_yourProgress => 'Your Progress';

  @override
  String get profile_dailyStreak => 'Daily Streak';

  @override
  String get profile_totalJapps => 'Total Japps';

  @override
  String get profile_globalRank => 'Global Rank';

  @override
  String get profile_mantraTotals => 'Mantra Totals';

  @override
  String get profile_achievements => 'Achievements';

  @override
  String get profile_shareProgress => 'Share Your Progress';

  @override
  String get profile_badgesEmpty => 'Start chanting to earn your first badge!';

  @override
  String get profile_mantrasEmpty => 'Start chanting to see your totals here!';

  @override
  String get profile_rateApp => 'Rate Our App';

  @override
  String get profile_supportTitle => 'Support Naam Jaap';

  @override
  String get profile_supportSubtitle => 'Help keep the app running';

  @override
  String get profile_myBodhi => 'My Bodhi Tree';

  @override
  String get profile_myBodhiSubtitle => 'A visual testament to your devotion.';

  @override
  String get profile_yourAchievement => 'Your Achievements';

  @override
  String get profile_yourAchievements => 'Your Achievements';

  @override
  String get profile_aMark => 'A mark of your dedication.';

  @override
  String get profile_changeName => 'Change Your Name';

  @override
  String get profile_enterName => 'Enter new Name';

  @override
  String get profile_shareApp => 'Share Naam Jaap';

  @override
  String get profile_yourCustomMantra => 'My Custom Mantras';

  @override
  String get profile_noCustoms => 'You haven\'t added any custom mantras yet.';

  @override
  String get profile_addNewMantra => 'Add New Mantra';

  @override
  String profile_deleteMantra(Object mantraName) {
    return 'Delete \"$mantraName\"?';
  }

  @override
  String get profile_deleteMantraSure =>
      'Are you sure? All japa counts associated with this mantra will also be permanently deleted.';

  @override
  String get profile_yesDelete => 'Yes, Delete';

  @override
  String get profile_couldNotUserData => 'Could not load user data.';

  @override
  String get profile_offline_card_title => 'Log Offline Japa';

  @override
  String get profile_offline_card_subtitle =>
      'Add counts from your physical mala';

  @override
  String get profile_gamification_header => 'Gamification';

  @override
  String get profile_commitments_header => 'Commitments';

  @override
  String get profile_insights_header => 'Mantra Insights';

  @override
  String get profile_my_mantras_header => 'My Mantras';

  @override
  String get profile_quick_actions_header => 'Quick Actions';

  @override
  String get profile_sankalpaSet => 'Make a Sacred Vow';

  @override
  String get profile_sankalpaSubtitle => 'Set a personal chanting goal.';

  @override
  String get profile_sankalpaTitle => 'Your Japa Sankalpa';

  @override
  String get profile_sankalpaChanting => 'Chanting';

  @override
  String get profile_abandon => 'Abandon Vow';

  @override
  String get profile_progress => 'PROGRESS';

  @override
  String get profile_deadline => 'DEADLINE';

  @override
  String get profile_achieved => 'Achieved!';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' to reach $targetCount times.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'By $date';
  }

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_ambiance => 'Temple Ambiance';

  @override
  String get settings_ambianceDesc => 'Play subtle background temple sounds.';

  @override
  String get settings_reminders => 'Daily Reminders';

  @override
  String get settings_remindersDesc =>
      'Get a notification if you haven\'t chanted today.';

  @override
  String get settings_language => 'App Language';

  @override
  String get settings_feedback => 'Feedback & Support';

  @override
  String get settings_feedbackDesc => 'Report a bug or suggest a feature.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'Privacy Policy';

  @override
  String get settings_terms => 'Terms & Conditions';

  @override
  String get settings_deleteAccount => 'Delete My Account';

  @override
  String get settings_signOut => 'Sign Out';

  @override
  String get settings_exit_guest => 'Exit Guest Mode';

  @override
  String get settings_support_header => 'Support & Legal';

  @override
  String get settings_account_header => 'Account';

  @override
  String get support_title => 'Support the Naam Jaap project';

  @override
  String get support_desc =>
      'Naam Jaap is a labor of love, built by a solo developer. Your selfless contribution (Seva) helps keep the servers running, the ads minimal, and the app free for all devotees.';

  @override
  String get support_afterTitile =>
      'Thank you for supporting Naam Jaap — every contribution helps.';

  @override
  String get support_openUPI => 'Opening your UPI app...';

  @override
  String get support_cannotOpenUPI => 'Could not launch UPI app.';

  @override
  String get support_upiError => 'Error: Could not find a UPI app to open.';

  @override
  String get support_chooseOffering => 'CHOOSE AN OFFERING';

  @override
  String get support_enterAmt => 'Or enter a custom amount (INR)';

  @override
  String get support_validAmt => 'Please select or enter a valid amount.';

  @override
  String get support_now => 'Support Now';

  @override
  String get support_donate => 'Donate';

  @override
  String get support_paymentSucc => 'Payments processed securely by Razorpay';

  @override
  String get support_thank => '🙏 Thank you';

  @override
  String get support_offer_seva => 'Offer Seva';

  @override
  String get support_signin_required =>
      'Please sign in to make a contribution.';

  @override
  String get support_payment_error =>
      'Could not start payment. Please try again.';

  @override
  String get support_blessed => 'May you be blessed.';

  @override
  String get support_tier_flower => 'Flower Offering';

  @override
  String get support_tier_lamp => 'Lamp Lighting';

  @override
  String get support_tier_garland => 'Garland Seva';

  @override
  String get support_tier_temple => 'Temple Support';

  @override
  String get support_tier_grand => 'Grand Offering';

  @override
  String get custom_create => 'Create Your Mantra';

  @override
  String get custom_yourMantra => 'Mantra Name';

  @override
  String get custom_hint => 'e.g., Om Gurave Namah';

  @override
  String get custom_back => 'Choose a background:';

  @override
  String get custom_addVoice => 'Add your voice (Optional):';

  @override
  String get custom_recording => 'Recording...';

  @override
  String get custom_tapToRecord => 'Tap the mic to record';

  @override
  String get custom_saveMantra => 'Save Mantra';

  @override
  String get custom_micAccess =>
      'Microphone permission is required to record audio.';

  @override
  String get custom_preview => 'PREVIEW';

  @override
  String get custom_voice_saved => 'Voice Note Saved';

  @override
  String get custom_tap_record => 'Tap to Record';

  @override
  String get custom_ready_use => 'Ready to use';

  @override
  String get custom_error_empty_name => 'Please enter a mantra name';

  @override
  String get garden_title => 'Bodhi Garden';

  @override
  String get garden_subtitle => 'Grow your spiritual forest';

  @override
  String get garden_growth => 'Spiritual Growth';

  @override
  String get garden_totalMala => 'Malas Completed';

  @override
  String get dialog_deleteTitle => 'Delete Account?';

  @override
  String get dialog_deleteBody =>
      'This action is permanent and cannot be undone. All your chanting data, achievements, and personal information will be permanently erased.\n\nAre you absolutely sure you want to proceed?';

  @override
  String get dialog_deleteConfirm => 'Yes, Delete My Account';

  @override
  String get dialog_continue => 'Continue';

  @override
  String get dialog_pressBack => 'Press back again to exit';

  @override
  String get dialog_update => 'Update Required';

  @override
  String get dialog_updateDesc =>
      'A new version of Naam Jaap is available with important updates. Please update the app to continue.';

  @override
  String get dialog_updateNow => 'Update Now';

  @override
  String get dialog_save => 'Save';

  @override
  String get dialog_close => 'Close';

  @override
  String get dialog_something => 'Something went wrong.';

  @override
  String get dialog_cancel => 'Cancel';

  @override
  String get dialog_profilePictureUpdate => 'Profile picture updated!';

  @override
  String get dialog_failedToUpload => 'Failed to upload image.';

  @override
  String get dialog_exceptionCard => 'Shareable card context is not available.';

  @override
  String get dialog_couldNotOpenPS => 'Could not open Play Store.';

  @override
  String get dialog_mic => 'Microphone permission is required to record audio.';

  @override
  String get dialog_getStarted => 'Get Started';

  @override
  String get dialog_next => 'Next';

  @override
  String get dialog_skip => 'Skip';

  @override
  String get dialog_checkoutMyProgress =>
      'Check out my progress on the Naam Jaap app!';

  @override
  String get dialog_sankalpaTitle => 'Set Your Japa Sankalpa';

  @override
  String get dialog_sankalpaSelectMantra => 'Select Mantra';

  @override
  String get dialog_sankalpaTargetCount => 'Target Count (e.g., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Target Date';

  @override
  String get dialog_sankalpaSelectDate => 'Select a date';

  @override
  String get dialog_sankalpaSetPledge => 'Set My Vow';

  @override
  String get dialog_sankalpaError => 'Please fill all fields correctly.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'Target count must be greater than your current count.';

  @override
  String get misc_japps => 'japps';

  @override
  String get misc_days => 'Days';

  @override
  String get misc_badge => 'Badges';

  @override
  String get misc_malas => 'Malas';

  @override
  String get misc_anonymous => 'Anonymous';

  @override
  String get lang_chooseLang => 'Choose your preferred language to continue';

  @override
  String get lang_searchLang => 'Search Languages';

  @override
  String get malatype_regular => 'Regular';

  @override
  String get malatype_crystal => 'Crystal';

  @override
  String get malatype_royal => 'Royal Gold';
}
