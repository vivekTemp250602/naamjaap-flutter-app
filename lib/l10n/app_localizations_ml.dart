// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get login_subtitle => 'നിങ്ങളുടെ വ്യക്തിഗത ഡിജിറ്റൽ ജപ സഹായി.';

  @override
  String get login_termsAgreement => 'ഞാൻ ';

  @override
  String get login_termsAndConditions => 'നിബന്ധനകളും വ്യവസ്ഥകളും';

  @override
  String get login_and => ' കൂടാതെ ';

  @override
  String get login_privacyPolicy => 'സ്വകാര്യതാ നയവും അംഗീകരിക്കുന്നു';

  @override
  String get login_signInWithGoogle => 'Google ഉപയോഗിച്ച് സൈൻ ഇൻ ചെയ്യുക';

  @override
  String get nav_home => 'ഹോം';

  @override
  String get nav_leaderboard => 'ലീഡർബോർഡ്';

  @override
  String get nav_wisdom => 'ജ്ഞാനം';

  @override
  String get nav_profile => 'എന്റെ പ്രൊഫൈൽ';

  @override
  String get home_tapToChant => 'ജപിക്കാൻ ടാപ്പ് ചെയ്യുക';

  @override
  String get home_dayStreak => 'ദിവസ സ്ട്രീക്ക്';

  @override
  String get home_total => 'ആകെ:';

  @override
  String get home_mantraInfo => 'മന്ത്ര വിവരം';

  @override
  String get dialog_close => 'അടയ്ക്കുക';

  @override
  String get wisdom_title => 'ഇന്നത്തെ ജ്ಞാനം';

  @override
  String get wisdom_dismissed =>
      'ഇന്നത്തെ ജ്ഞാനം ധ്യാനിച്ചു കഴിഞ്ഞു.\nനാളെ ഒരു പുതിയ ഉൾക്കാഴ്ച എത്തും.';

  @override
  String get wisdom_loading => 'ജ്ഞാനം ലോഡ് ചെയ്യുന്നു...';

  @override
  String get leaderboard_allTime => 'എക്കാലത്തെയും';

  @override
  String get leaderboard_thisWeek => 'ഈ ആഴ്ച';

  @override
  String get leaderboard_yourProgress => 'നിങ്ങളുടെ പുരോഗതി';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName-യെ മറികടക്കാൻ $count ജപങ്ങൾ';
  }

  @override
  String get leaderboard_empty => 'യാത്ര ആരംഭിക്കുന്നു!';

  @override
  String get leaderboard_emptySubtitle => 'ലീഡർബോർഡിൽ ഒന്നാമനാകൂ!';

  @override
  String get leaderboard_isEmpty => 'ലീഡർബോർഡ് ശൂന്യമാണ്.';

  @override
  String get leaderboard_noBade => 'ഇതുവരെ ബാഡ്ജുകളൊന്നുമില്ല';

  @override
  String get leaderboard_notOnBoard => 'ബോർഡിൽ കയറാൻ ജപിക്കുന്നത് തുടരുക!';

  @override
  String get leaderboard_topOfBoard => 'നിങ്ങൾ മുകളിലാണ്! ✨';

  @override
  String get leaderboard_noChants => 'ഇതുവരെ ജപങ്ങളൊന്നുമില്ല';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'മികച്ച മന്ത്രം: $mantra';
  }

  @override
  String get profile_yourProgress => 'നിങ്ങളുടെ പുരോഗതി';

  @override
  String get profile_dailyStreak => 'ദൈനംദിന സ്ട്രീക്ക്';

  @override
  String get profile_totalJapps => 'ആകെ ജപങ്ങൾ';

  @override
  String get profile_globalRank => 'ഗ്ലോബൽ റാങ്ക്';

  @override
  String get profile_mantraTotals => 'മന്ത്രങ്ങളുടെ ആകെ എണ്ണം';

  @override
  String get profile_achievements => 'നേട്ടങ്ങൾ';

  @override
  String get profile_shareProgress => 'നിങ്ങളുടെ പുരോഗതി പങ്കിടുക';

  @override
  String get profile_badgesEmpty =>
      'നിങ്ങളുടെ ആദ്യ ബാഡ്ജ് നേടാൻ ജപിക്കാൻ തുടങ്ങൂ!';

  @override
  String get profile_mantrasEmpty =>
      'നിങ്ങളുടെ ആകെ എണ്ണം ഇവിടെ കാണാൻ ജപിക്കാൻ തുടങ്ങൂ!';

  @override
  String get profile_rateApp => 'ഞങ്ങളുടെ അപ്ലിക്കേഷൻ റേറ്റ് ചെയ്യുക';

  @override
  String get profile_supportSubtitle =>
      'അപ്ലിക്കേഷൻ പ്രവർത്തിപ്പിക്കാൻ സഹായിക്കുക';

  @override
  String get profile_myBodhi => 'എൻ്റെ ബോധി വൃക്ഷം';

  @override
  String get profile_myBodhiSubtitle => 'നിങ്ങളുടെ ഭക്തിയുടെ ദൃശ്യസാക്ഷ്യം.';

  @override
  String get profile_yourAchievement => 'നിങ്ങളുടെ നേട്ടങ്ങൾ';

  @override
  String get profile_yourAchievements => 'നിങ്ങളുടെ നേട്ടങ്ങൾ';

  @override
  String get profile_aMark => 'നിങ്ങളുടെ സമർപ്പണത്തിന്റെ അടയാളം.';

  @override
  String get profile_changeName => 'നിങ്ങളുടെ പേര് മാറ്റുക';

  @override
  String get profile_enterName => 'പുതിയ പേര് നൽകുക';

  @override
  String get settings_title => 'സെറ്റിംഗ്സ്';

  @override
  String get settings_ambiance => 'ക്ഷേത്ര അന്തരീക്ഷം';

  @override
  String get settings_ambianceDesc =>
      'പശ്ചാത്തലത്തിൽ ക്ഷേത്ര ശബ്ദങ്ങൾ പ്ലേ ചെയ്യുക.';

  @override
  String get settings_reminders => 'ദിവസേനയുള്ള ഓർമ്മപ്പെടുത്തലുകൾ';

  @override
  String get settings_remindersDesc =>
      'നിങ്ങൾ ഇന്ന് ജപിച്ചില്ലെങ്കിൽ ഒരു അറിയിപ്പ് നേടുക.';

  @override
  String get settings_language => 'ആപ്പ് ഭാഷ';

  @override
  String get settings_feedback => 'അഭിപ്രായവും പിന്തുണയും';

  @override
  String get settings_feedbackDesc =>
      'ഒരു ബഗ് റിപ്പോർട്ട് ചെയ്യുക അല്ലെങ്കിൽ ഒരു ഫീച്ചർ നിർദ്ദേശിക്കുക.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'സ്വകാര്യതാ നയം';

  @override
  String get settings_terms => 'നിബന്ധനകളും വ്യവസ്ഥകളും';

  @override
  String get settings_deleteAccount => 'എന്റെ അക്കൗണ്ട് ഇല്ലാതാക്കുക';

  @override
  String get settings_signOut => 'സൈൻ ഔട്ട് ചെയ്യുക';

  @override
  String get dialog_deleteTitle => 'അക്കൗണ്ട് ഇല്ലാതാക്കണോ?';

  @override
  String get dialog_deleteBody =>
      'ഈ പ്രവർത്തനം സ്ഥിരമാണ്, ഇത് പഴയപടിയാക്കാൻ കഴിയില്ല. നിങ്ങളുടെ എല്ലാ ജപ ഡാറ്റയും നേട്ടങ്ങളും വ്യക്തിഗത വിവരങ്ങളും ശാശ്വതമായി മായ്ക്കപ്പെടും.\n\nനിങ്ങൾക്ക് തുടരണമെന്ന് ഉറപ്പാണോ?';

  @override
  String get dialog_deleteConfirm => 'അതെ, എന്റെ അക്കൗണ്ട് ഇല്ലാതാക്കുക';

  @override
  String get dialog_continue => 'തുടരുക';

  @override
  String get dialog_pressBack => 'പുറത്തുകടക്കാൻ വീണ്ടും പിന്നോട്ട് അമർത്തുക';

  @override
  String get dialog_update => 'അപ്ഡേറ്റ് ആവശ്യമാണ്';

  @override
  String get dialog_updateNow => 'ഇപ്പോൾ അപ്ഡേറ്റ് ചെയ്യുക';

  @override
  String get dialog_save => 'സേവ് ചെയ്യുക';

  @override
  String get dialog_something => 'എന്തോ കുഴപ്പം സംഭവിച്ചു.';

  @override
  String get dialog_cancel => 'റദ്ദാക്കുക';

  @override
  String get misc_japps => 'ജപങ്ങൾ';

  @override
  String get misc_days => 'ദിവസങ്ങൾ';

  @override
  String get misc_badge => 'ബാഡ്ജുകൾ';

  @override
  String get lang_chooseLang =>
      'തുടരാൻ നിങ്ങൾക്ക് ഇഷ്ടമുള്ള ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get lang_searchLang => 'ഭാഷകൾ തിരയുക';

  @override
  String get garden_totalMala => 'പൂർത്തിയാക്കിയ മാലകൾ';

  @override
  String get misc_malas => 'മാലകൾ';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName-യെ മറികടക്കാൻ $count മാലകൾ';
  }

  @override
  String get dialog_mic =>
      'ഓഡിയോ റെക്കോർഡ് ചെയ്യാൻ മൈക്രോഫോൺ അനുമതി ആവശ്യമാണ്.';

  @override
  String get custom_create => 'നിങ്ങളുടെ മന്ത്രം സൃഷ്ടിക്കുക';

  @override
  String get custom_yourMantra => 'മന്ത്രത്തിൻ്റെ പേര്';

  @override
  String get custom_hint => 'ഉദാ., ഓം ഗുരവേ നമഃ';

  @override
  String get custom_back => 'ഒരു പശ്ചാത്തലം തിരഞ്ഞെടുക്കുക:';

  @override
  String get custom_addVoice => 'നിങ്ങളുടെ ശബ്ദം ചേർക്കുക (ഓപ്ഷണൽ):';

  @override
  String get custom_recording => 'റെക്കോർഡ് ചെയ്യുന്നു...';

  @override
  String get custom_tapToRecord => 'റെക്കോർഡ് ചെയ്യാൻ മൈക്കിൽ ടാപ്പുചെയ്യുക';

  @override
  String get custom_saveMantra => 'മന്ത്രം സേവ് ചെയ്യുക';

  @override
  String get custom_micAccess =>
      'ഓഡിയോ റെക്കോർഡ് ചെയ്യാൻ മൈക്രോഫോൺ അനുമതി ആവശ്യമാണ്.';

  @override
  String get profile_yourCustomMantra => 'എൻ്റെ ഇഷ്ടാനുസൃത മന്ത്രങ്ങൾ';

  @override
  String get profile_noCustoms =>
      'നിങ്ങൾ ഇതുവരെ ഇഷ്ടാനുസൃത മന്ത്രങ്ങളൊന്നും ചേർത്തിട്ടില്ല.';

  @override
  String get profile_addNewMantra => 'പുതിയ മന്ത്രം ചേർക്കുക';

  @override
  String get dialog_profilePictureUpdate => 'പ്രൊഫൈൽ ചിത്രം അപ്ഡേറ്റ് ചെയ്തു!';

  @override
  String get dialog_failedToUpload =>
      'ചിത്രം അപ്‌ലോഡ് ചെയ്യുന്നതിൽ പരാജയപ്പെട്ടു.';

  @override
  String get dialog_exceptionCard => 'പങ്കിടാവുന്ന കാർഡ് സന്ദർഭം ലഭ്യമല്ല.';

  @override
  String get dialog_couldNotOpenPS => 'Play Store തുറക്കാൻ കഴിഞ്ഞില്ല.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" ഇല്ലാതാക്കണോ?';
  }

  @override
  String get profile_deleteMantraSure =>
      'നിങ്ങൾക്ക് ഉറപ്പാണോ? ഈ മന്ത്രവുമായി ബന്ധപ്പെട്ട എല്ലാ ജപ എണ്ണങ്ങളും ശാശ്വതമായി ഇല്ലാതാക്കപ്പെടും.';

  @override
  String get profile_yesDelete => 'അതെ, ഇല്ലാതാക്കുക';

  @override
  String get profile_couldNotUserData =>
      'ഉപയോക്തൃ ഡാറ്റ ലോഡ് ചെയ്യാൻ കഴിഞ്ഞില്ല.';

  @override
  String get misc_anonymous => 'അജ്ഞാതൻ';

  @override
  String get profile_sankalpaSet => 'ഒരു പുണ്യ പ്രതിജ്ഞ ചെയ്യുക';

  @override
  String get profile_sankalpaSubtitle =>
      'ഒരു വ്യക്തിഗത ജപ ലക്ഷ്യം സജ്ജമാക്കുക.';

  @override
  String get profile_sankalpaTitle => 'നിങ്ങളുടെ ജപ സങ്കൽപ്പം';

  @override
  String get profile_sankalpaChanting => 'ജപിക്കുന്നു';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount തവണ എത്താൻ.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date -നകം';
  }

  @override
  String get dialog_sankalpaTitle => 'നിങ്ങളുടെ ജപ സങ്കൽപ്പം സജ്ജമാക്കുക';

  @override
  String get dialog_sankalpaSelectMantra => 'മന്ത്രം തിരഞ്ഞെടുക്കുക';

  @override
  String get dialog_sankalpaTargetCount => 'ലക്ഷ്യ എണ്ണം (ഉദാ., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'ലക്ഷ്യ തീയതി';

  @override
  String get dialog_sankalpaSelectDate => 'ഒരു തീയതി തിരഞ്ഞെടുക്കുക';

  @override
  String get dialog_sankalpaSetPledge => 'എൻ്റെ പ്രതിജ്ഞ സജ്ജമാക്കുക';

  @override
  String get dialog_sankalpaError => 'എല്ലാ ഫീൽഡുകളും ശരിയായി പൂരിപ്പിക്കുക.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'ലക്ഷ്യ എണ്ണം നിങ്ങളുടെ നിലവിലെ എണ്ണത്തേക്കാൾ വലുതായിരിക്കണം.';

  @override
  String get support_openUPI => 'നിങ്ങളുടെ UPI ആപ്പ് തുറക്കുന്നു...';

  @override
  String get support_cannotOpenUPI => 'UPI ആപ്പ് ലോഞ്ച് ചെയ്യാൻ കഴിഞ്ഞില്ല.';

  @override
  String get support_upiError =>
      'പിശക്: തുറക്കാൻ ഒരു UPI ആപ്പ് കണ്ടെത്താൻ കഴിഞ്ഞില്ല.';

  @override
  String get support_chooseOffering => 'ഒരു വഴിപാട് തിരഞ്ഞെടുക്കുക';

  @override
  String get support_enterAmt => 'അല്ലെങ്കിൽ ഒരു ഇഷ്ടാനുസൃത തുക നൽകുക (INR)';

  @override
  String get support_validAmt =>
      'ദയവായി സാധുവായ ഒരു തുക തിരഞ്ഞെടുക്കുക അല്ലെങ്കിൽ നൽകുക.';

  @override
  String get support_now => 'ഇപ്പോൾ പിന്തുണയ്ക്കുക';

  @override
  String get home_chooseMala => 'നിങ്ങളുടെ മാല തിരഞ്ഞെടുക്കുക';

  @override
  String get home_chooseMalaDesc =>
      'നിങ്ങളുടെ ആത്മാവിനോട് ഇണങ്ങുന്ന ഒരു ശൈലി തിരഞ്ഞെടുക്കുക.';

  @override
  String get tour_title1 => 'ഡിജിറ്റൽ ജപ മാല';

  @override
  String get tour_body1 =>
      'ജപിക്കാൻ ടാപ്പ് ചെയ്യുക. ഞങ്ങൾ നിങ്ങളുടെ മുത്തുകൾ എണ്ണുന്നു, മാലകൾ ട്രാക്ക് ചെയ്യുന്നു, നിങ്ങളുടെ സ്ട്രീക്ക് സ്വയമേവ നിലനിർത്തുന്നു.';

  @override
  String get tour_title2 => 'ഗ്ലോബൽ ലീഡർബോർഡ്';

  @override
  String get tour_body2 =>
      'ആയിരക്കണക്കിന് ആളുകൾക്കൊപ്പം ജപിക്കുക. ആത്മീയ പുരോഗതിയിലൂടെയും സ്ഥിരതയിലൂടെയും ഉയരുക.';

  @override
  String get tour_title3 => 'ദിവസേനയുള്ള ജ്ഞാനം';

  @override
  String get tour_body3 =>
      'പുരാതന ഗ്രന്ഥങ്ങളിൽ നിന്ന് തിരഞ്ഞെടുത്ത ശ്ലോകങ്ങൾ സ്വീകരിക്കുക — ഒന്നിലധികം ഭാഷകളിൽ ലഭ്യമാണ്.';

  @override
  String get tour_title4 => 'നിങ്ങളുടെ ആത്മീയ യാത്ര';

  @override
  String get tour_body4 =>
      'നാഴികക്കല്ലുകൾ ട്രാക്കുചെയ്യുക, സങ്കൽപ്പങ്ങൾ സജ്ജമാക്കുക, നിങ്ങളുടെ വളർച്ചയും നേട്ടങ്ങളും ചിന്തിക്കുക.';

  @override
  String get dialog_getStarted => 'ആരംഭിക്കുക';

  @override
  String get dialog_next => 'അടുത്തത്';

  @override
  String get dialog_skip => 'ഒഴിവാക്കുക';

  @override
  String get malatype_regular => 'സാധാരണ';

  @override
  String get malatype_crystal => 'സ്ഫടികം';

  @override
  String get malatype_royal => 'റോയൽ ഗോൾഡ്';

  @override
  String get profile_abandon => 'പ്രതിജ്ഞ ഉപേക്ഷിക്കുക';

  @override
  String get profile_progress => 'പുരോഗതി';

  @override
  String get profile_deadline => 'സമയപരിധി';

  @override
  String get profile_achieved => 'നേടി!';

  @override
  String get support_donate => 'സംഭാവന ചെയ്യുക';

  @override
  String get support_paymentSucc =>
      'Razorpay വഴി പേയ്‌മെൻ്റുകൾ സുരക്ഷിതമായി പ്രോസസ്സ് ചെയ്യുന്നു';

  @override
  String get support_thank => '🙏 നന്ദി';

  @override
  String get home_customizeMala => 'മാല ഇഷ്‌ടാനുസൃതമാക്കുക';

  @override
  String get dialog_checkoutMyProgress =>
      'നാം ജാപ് ആപ്പിലെ എൻ്റെ പുരോഗതി പരിശോധിക്കുക!';

  @override
  String get appTitle => 'നാം ജാപ്';

  @override
  String get login_welcome => 'നാം ജാപിലേക്ക് സ്വാഗതം';

  @override
  String get profile_shareApp => 'നാം ജാപ് പങ്കിടുക';

  @override
  String get profile_supportTitle => 'നാം ജാപിനെ പിന്തുണയ്ക്കുക';

  @override
  String get dialog_updateDesc =>
      'പ്രധാനപ്പെട്ട അപ്‌ഡേറ്റുകളോടെ നാം ജാപിന്റെ പുതിയ പതിപ്പ് ലഭ്യമാണ്. തുടരാൻ ദയവായി അപ്ലിക്കേഷൻ അപ്‌ഡേറ്റ് ചെയ്യുക.';

  @override
  String get support_desc =>
      'നാം ജാപ് സ്നേഹത്തിൻ്റെ പ്രയത്നമാണ്, ഒരു സോളോ ഡെവലപ്പർ നിർമ്മിച്ചത്. നിങ്ങളുടെ നിസ്വാർത്ഥ സംഭാവന (സേവനം) സെർവറുകൾ പ്രവർത്തിപ്പിക്കാനും പരസ്യങ്ങൾ കുറയ്ക്കാനും എല്ലാ ഭക്തർക്കും ആപ്പ് സൗജന്യമായി നിലനിർത്താനും സഹായിക്കുന്നു.';

  @override
  String get support_title => 'നാം ജാപ് പദ്ധതിയെ പിന്തുണയ്ക്കുക';

  @override
  String get support_afterTitile =>
      'നാം ജാപിനെ പിന്തുണച്ചതിന് നന്ദി — ഓരോ സംഭാവനയും സഹായിക്കുന്നു.';
}
