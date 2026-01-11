// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get login_subtitle => 'ଆପଣଙ୍କର ବ୍ୟକ୍ତିଗତ ଡିଜିଟାଲ୍ ଜପ ସାଥୀ।';

  @override
  String get login_termsAgreement => 'ମୁଁ ';

  @override
  String get login_termsAndConditions => 'ନିୟମ ଏବଂ ସର୍ତ୍ତାବଳୀ';

  @override
  String get login_and => ' ଏବଂ ';

  @override
  String get login_privacyPolicy => 'ଗୋପନୀୟତା ନୀତି ସହ ରାଜି ଅଛି';

  @override
  String get login_signInWithGoogle => 'Google ସହିତ ସାଇନ୍ ଇନ୍ କରନ୍ତୁ';

  @override
  String get nav_home => 'ହୋମ୍';

  @override
  String get nav_leaderboard => 'ଲିଡରବୋର୍ଡ';

  @override
  String get nav_wisdom => 'ଜ୍ଞାନ';

  @override
  String get nav_profile => 'ମୋର ପ୍ରୋଫାଇଲ୍';

  @override
  String get home_tapToChant => 'ଜପ କରିବା ପାଇଁ ଟ୍ୟାପ୍ କରନ୍ତୁ';

  @override
  String get home_dayStreak => 'ଦିନ ଧାରା';

  @override
  String get home_total => 'ମୋଟ:';

  @override
  String get home_mantraInfo => 'ମନ୍ତ୍ର ସୂଚନା';

  @override
  String get dialog_close => 'ବନ୍ଦ କରନ୍ତୁ';

  @override
  String get wisdom_title => 'ଆଜିର ଜ୍ଞାନ';

  @override
  String get wisdom_dismissed =>
      'ଆଜିର ଜ୍ଞାନ ଉପରେ ଚିନ୍ତନ କରାଯାଇଛି।\nଆସନ୍ତାକାଲି ଏକ ନୂତନ ଅନ୍ତର୍ਦୃଷ୍ଟି ଆସିବ।';

  @override
  String get wisdom_loading => 'ଜ୍ଞାନ ଲୋଡ୍ ହେଉଛି...';

  @override
  String get leaderboard_allTime => 'ସବୁ ସମୟ';

  @override
  String get leaderboard_thisWeek => 'ଏହି ସପ୍ତାହ';

  @override
  String get leaderboard_yourProgress => 'ଆପଣଙ୍କର ଅଗ୍ରଗତି';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerNameଙ୍କୁ ଅତିକ୍ରମ କରିବା ପାଇଁ $count ଜପ';
  }

  @override
  String get leaderboard_empty => 'ଯାତ୍ରਾ ଆରମ୍ଭ ହେଉଛି!';

  @override
  String get leaderboard_emptySubtitle => 'ଲିଡରବୋର୍ଡରେ ପ୍ରଥମ ହୁଅନ୍ତୁ!';

  @override
  String get leaderboard_isEmpty => 'ଲିଡରବୋର୍ଡ ଖାଲି ଅଛି।';

  @override
  String get leaderboard_noBade => 'ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି ବ୍ୟାଜ୍ ନାହିଁ';

  @override
  String get leaderboard_notOnBoard => 'ବୋର୍ଡରେ ଆସିବା ପାଇଁ ଜପ ଜାରି ରଖନ୍ତୁ!';

  @override
  String get leaderboard_topOfBoard => 'ଆପଣ ଶୀର୍ଷରେ ଅଛନ୍ତି! ✨';

  @override
  String get leaderboard_noChants => 'ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି ଜପ ନାହିଁ';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'ଶୀର୍ଷ ମନ୍ତ୍ର: $mantra';
  }

  @override
  String get profile_yourProgress => 'ଆପଣଙ୍କର ଅଗ୍ରଗତି';

  @override
  String get profile_dailyStreak => 'ଦୈନିକ ଧାରା';

  @override
  String get profile_totalJapps => 'ମୋଟ ଜପ';

  @override
  String get profile_globalRank => 'ଗ୍ଲୋବାଲ୍ ରାଙ୍କ୍';

  @override
  String get profile_mantraTotals => 'ମନ୍ତ୍ର ମୋଟ';

  @override
  String get profile_achievements => 'ଉପଲବ୍ଧି';

  @override
  String get profile_shareProgress => 'ଆପଣଙ୍କର ଅଗ୍ରଗତି ସେୟାର କରନ୍ତୁ';

  @override
  String get profile_badgesEmpty =>
      'ଆପଣଙ୍କର ପ୍ରଥମ ବ୍ୟାଜ୍ ଅର୍ଜନ କରିବା ପାଇଁ ଜପ ଆରମ୍ଭ କରନ୍ତୁ!';

  @override
  String get profile_mantrasEmpty => 'ଆପଣଙ୍କର ମୋଟ ଦେଖିବା ପାଇଁ ଜପ ଆରମ୍ଭ କରନ୍ତୁ!';

  @override
  String get profile_rateApp => 'ଆମ ଆପକୁ ରେଟ୍ କରନ୍ତୁ';

  @override
  String get profile_supportSubtitle => 'ଆପକୁ ଚାଲୁ ରଖିବାରେ ସାହାଯ୍ୟ କରନ୍ତୁ';

  @override
  String get profile_myBodhi => 'ମୋ ବୋଧି ବୃକ୍ଷ';

  @override
  String get profile_myBodhiSubtitle => 'ଆପଣଙ୍କ ଭକ୍ତିର ଏକ ଦୃଶ୍ୟମାନ ପ୍ରମାଣ ।';

  @override
  String get profile_yourAchievement => 'ଆପଣଙ୍କ ଉପଲବ୍ଧି';

  @override
  String get profile_yourAchievements => 'ଆପଣଙ୍କ ଉପଲବ୍ଧି';

  @override
  String get profile_aMark => 'ଆପଣଙ୍କ ସମର୍ପଣର ଚିହ୍ନ।';

  @override
  String get profile_changeName => 'ଆପଣଙ୍କ ନାମ ପରିବର୍ତ୍ତନ କରନ୍ତୁ';

  @override
  String get profile_enterName => 'ନୂଆ ନାମ ପ୍ରବେଶ କରନ୍ତୁ';

  @override
  String get settings_title => 'ସେଟିଂସମୂହ';

  @override
  String get settings_ambiance => 'ମନ୍ଦିର ପରିବେଶ';

  @override
  String get settings_ambianceDesc => 'ସୂକ୍ଷ୍ମ ପୃଷ୍ଠଭୂମି ମନ୍ଦିର ଧ୍ୱନି ବଜାନ୍ତୁ।';

  @override
  String get settings_reminders => 'ଦୈନିକ ସ୍ମାରକ';

  @override
  String get settings_remindersDesc =>
      'ଯଦି ଆପଣ ଆଜି ଜପ କରିନାହାଁନ୍ତି ତେବେ ଏକ ବିଜ୍ଞପ୍ତି ਪ੍ਰਾਪਤ କରନ୍ତୁ।';

  @override
  String get settings_language => 'ଆପ୍ ଭାଷା';

  @override
  String get settings_feedback => 'ମତାମତ ଏବଂ ସମର୍ଥନ';

  @override
  String get settings_feedbackDesc =>
      'ଏକ ବଗ୍ ରିପୋର୍ଟ କରନ୍ତୁ କିମ୍ବା ଏକ ବୈଶିଷ୍ଟ୍ୟ ପରାମର୍ଶ ଦିଅନ୍ତୁ।';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'ଗୋପନୀୟତା ନୀତି';

  @override
  String get settings_terms => 'ନିୟମ ଏବଂ ସର୍ତ୍ତାବଳୀ';

  @override
  String get settings_deleteAccount => 'ମୋର ଖାତା ବିଲୋପ କରନ୍ତୁ';

  @override
  String get settings_signOut => 'ସାଇନ୍ ଆଉଟ୍';

  @override
  String get dialog_deleteTitle => 'ଖାତା ବିଲୋପ କରିବେ କି?';

  @override
  String get dialog_deleteBody =>
      'ଏହି କାର୍ଯ୍ୟ ସ୍ଥାୟୀ ଅଟେ ଏବଂ ଏହାକୁ ପୂର୍ବବତ୍ କରାଯାଇପାରିବ ନାହିଁ। ଆପଣଙ୍କର ସମସ୍ତ ଜପ ଡାଟା, ଉପଲବ୍ଧି, ଏବଂ ବ୍ୟକ୍ତିଗତ ସୂଚନା ସ୍ଥାୟୀ ଭାବରେ ଲିଭାଇ ଦିଆଯିବ।\n\nଆପଣ ନିଶ୍ଚିତ କି ଆପଣ ଆଗକୁ ବଢ଼ିବାକୁ ଚାହୁଁଛନ୍ତି?';

  @override
  String get dialog_deleteConfirm => 'ହଁ, ମୋର ଖାତା ବିଲୋପ କରନ୍ତୁ';

  @override
  String get dialog_continue => 'ଜାରି ରଖନ୍ତୁ';

  @override
  String get dialog_pressBack => 'ବାହାରିବା ପାଇଁ ପୁଣିଥରେ ବ୍ୟାକ୍ ଦବାନ୍ତୁ';

  @override
  String get dialog_update => 'ଅଦ୍ୟତନ ଆବଶ୍ୟକ';

  @override
  String get dialog_updateNow => 'ଏବେ ଅଦ୍ୟତନ କରନ୍ତୁ';

  @override
  String get dialog_save => 'ସଂରକ୍ଷଣ କରନ୍ତୁ';

  @override
  String get dialog_something => 'କିଛି ଭୁଲ୍ ହୋଇଗଲା।';

  @override
  String get dialog_cancel => 'ବାତିଲ କରନ୍ତୁ';

  @override
  String get misc_japps => 'ଜପ';

  @override
  String get misc_days => 'ଦିନ';

  @override
  String get misc_badge => 'ବ୍ୟାଜ୍';

  @override
  String get lang_chooseLang => 'ଜାରି ରଖିବା ପାଇଁ ଆପଣଙ୍କ ପସନ୍ଦର ଭାଷା ବାଛନ୍ତୁ';

  @override
  String get lang_searchLang => 'ଭାଷା ଖୋଜନ୍ତୁ';

  @override
  String get garden_totalMala => 'ସମ୍ପୂର୍ଣ୍ଣ ହୋଇଥିବା ମାଳା';

  @override
  String get misc_malas => 'ମାଳା';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerNameଙ୍କୁ ଅତିକ୍ରମ କରିବା ପାଇଁ $count ମାଳା';
  }

  @override
  String get dialog_mic => 'ଅଡିଓ ରେକର୍ଡ କରିବା ପାଇଁ ମାଇକ୍ରୋଫୋନ୍ ଅନୁମତି ଆବଶ୍ୟକ।';

  @override
  String get custom_create => 'ଆପଣଙ୍କ ମନ୍ତ୍ର ସୃଷ୍ଟି କରନ୍ତୁ';

  @override
  String get custom_yourMantra => 'ମନ୍ତ୍ର ନାମ';

  @override
  String get custom_hint => 'ଯଥା, ଓଁ ଗୁରବେ ନମଃ';

  @override
  String get custom_back => 'ଏକ ପୃଷ୍ଠଭୂମି ବାଛନ୍ତୁ:';

  @override
  String get custom_addVoice => 'ଆପଣଙ୍କ ସ୍ୱର ଯୋଗ କରନ୍ତୁ (ବୈକଳ୍ପିକ):';

  @override
  String get custom_recording => 'ରେକର୍ଡିଂ ଚାଲିଛି...';

  @override
  String get custom_tapToRecord => 'ରେକର୍ଡ କରିବାକୁ ମାଇକ୍ ଟ୍ୟାପ୍ କରନ୍ତୁ';

  @override
  String get custom_saveMantra => 'ମନ୍ତ୍ର ସଂରକ୍ଷଣ କରନ୍ତୁ';

  @override
  String get custom_micAccess =>
      'ଅଡିଓ ରେକର୍ଡ କରିବା ପାଇଁ ମାଇକ୍ରୋଫୋନ୍ ଅନୁମତି ଆବଶ୍ୟକ।';

  @override
  String get profile_yourCustomMantra => 'ମୋ କଷ୍ଟମ୍ ମନ୍ତ୍ର';

  @override
  String get profile_noCustoms =>
      'ଆପଣ ଏପର୍ଯ୍ୟନ୍ତ କୌଣସି କଷ୍ଟମ୍ ମନ୍ତ୍ର ଯୋଗ କରିନାହାଁନ୍ତି।';

  @override
  String get profile_addNewMantra => 'ନୂଆ ମନ୍ତ୍ର ଯୋଗ କରନ୍ତୁ';

  @override
  String get dialog_profilePictureUpdate => 'ପ୍ରୋଫାଇଲ୍ ଚିତ୍ର ଅଦ୍ୟତନ କରାଯାଇଛି!';

  @override
  String get dialog_failedToUpload => 'ପ୍ରତିଛବି ଅପଲୋଡ୍ କରିବାରେ ବିଫଳ।';

  @override
  String get dialog_exceptionCard => 'ସେୟାରଯୋଗ୍ୟ କାର୍ଡ ପ୍ରସଙ୍ଗ ଉପଲବ୍ଧ ନାହିଁ।';

  @override
  String get dialog_checkoutMyProgress =>
      'ନାମଜପ୍ ଆପ୍‌ରେ ମୋର ଅଗ୍ରଗତି ଯାଞ୍ଚ କରନ୍ତୁ!';

  @override
  String get dialog_couldNotOpenPS => 'ପ୍ଲେ ଷ୍ଟୋର୍ ଖୋଲିପାରିଲା ନାହିଁ।';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" ବିଲୋପ କରିବେ କି?';
  }

  @override
  String get profile_deleteMantraSure =>
      'ଆପଣ ନିଶ୍ଚିତ କି? ଏହି ମନ୍ତ୍ର ସହିତ ଜଡିତ ସମସ୍ତ ଜପ ଗଣନା ମଧ୍ୟ ସ୍ଥାୟୀ ଭାବରେ ବିଲୋପ କରାଯିବ।';

  @override
  String get profile_yesDelete => 'ହଁ, ବିଲୋପ କରନ୍ତୁ';

  @override
  String get profile_couldNotUserData =>
      'ଉପଯୋଗକର୍ତ୍ତା ଡାଟା ଲୋଡ୍ ହୋଇପାରିଲା ନାହିଁ।';

  @override
  String get misc_anonymous => 'ଅଜ୍ଞାତ';

  @override
  String get profile_sankalpaSet => 'ଏକ ପବିତ୍ର ସଂକଳ୍ପ କରନ୍ତୁ';

  @override
  String get profile_sankalpaSubtitle => 'ଏକ ବ୍ୟକ୍ତିଗତ ଜପ ଲକ୍ଷ୍ୟ ସ୍ଥିର କରନ୍ତୁ।';

  @override
  String get profile_sankalpaTitle => 'ଆପଣଙ୍କ ଜପ ସଂକଳ୍ପ';

  @override
  String get profile_sankalpaChanting => 'ଜପ କରୁଛନ୍ତି';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount ଥର ପହଞ୍ଚିବା ପାଇଁ।';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date ସୁଦ୍ଧା';
  }

  @override
  String get dialog_sankalpaTitle => 'ଆପଣଙ୍କ ଜପ ସଂକଳ୍ପ ସ୍ଥିର କରନ୍ତୁ';

  @override
  String get dialog_sankalpaSelectMantra => 'ମନ୍ତ୍ର ଚୟନ କରନ୍ତୁ';

  @override
  String get dialog_sankalpaTargetCount => 'ଲକ୍ଷ୍ୟ ଗଣନା (ଯଥା, 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'ଲକ୍ଷ୍ୟ ତାରିଖ';

  @override
  String get dialog_sankalpaSelectDate => 'ଏକ ତାରିଖ ଚୟନ କରନ୍ତୁ';

  @override
  String get dialog_sankalpaSetPledge => 'ମୋ ସଂକଳ୍ପ ସ୍ଥିର କରନ୍ତୁ';

  @override
  String get dialog_sankalpaError =>
      'ଦୟାକରି ସମସ୍ତ କ୍ଷେତ୍ର ସଠିକ୍ ଭାବରେ ପୂରଣ କରନ୍ତୁ।';

  @override
  String get dialog_sankalpaErrorTarget =>
      'ଲକ୍ଷ୍ୟ ଗଣନା ଆପଣଙ୍କ ବର୍ତ୍ତମାନର ଗଣନାଠାରୁ ଅଧିକ ହେବା ଆବଶ୍ୟକ।';

  @override
  String get support_openUPI => 'ଆପଣଙ୍କ UPI ଆପ୍ ଖୋଲୁଛି...';

  @override
  String get support_cannotOpenUPI => 'UPI ଆପ୍ ଲଞ୍ଚ ହୋଇପାରିଲା ନାହିଁ।';

  @override
  String get support_upiError =>
      'ତ୍ରୁଟି: ଖୋଲିବା ପାଇଁ କୌଣସି UPI ଆପ୍ ମିଳିଲା ନାହିଁ।';

  @override
  String get support_chooseOffering => 'ଏକ ପ୍ରସାଦ ବାଛନ୍ତୁ';

  @override
  String get support_enterAmt => 'କିମ୍ବା ଏକ କଷ୍ଟମ୍ ପରିମାଣ ଏଣ୍ଟର୍ କରନ୍ତୁ (INR)';

  @override
  String get support_validAmt =>
      'ଦୟାକରି ଏକ ବୈଧ ପରିମାଣ ଚୟନ କରନ୍ତୁ କିମ୍ବା ଏଣ୍ଟର୍ କରନ୍ତୁ।';

  @override
  String get support_now => 'ଏବେ ସମର୍ଥନ କରନ୍ତୁ';

  @override
  String get home_chooseMala => 'ଆପଣଙ୍କ ମାଳା ବାଛନ୍ତୁ';

  @override
  String get home_chooseMalaDesc =>
      'ଏକ ଶୈଳୀ ବାଛନ୍ତୁ ଯାହା ଆପଣଙ୍କ ଆତ୍ମା ସହିତ ପ୍ରତିଧ୍ୱନିତ ହୁଏ ।';

  @override
  String get tour_title1 => 'ଡିଜିଟାଲ୍ ଜପ ମାଳା';

  @override
  String get tour_body1 =>
      'ଜପ କରିବାକୁ ଟ୍ୟାପ୍ କରନ୍ତୁ। ଆମେ ଆପଣଙ୍କ ମାଳି ଗଣନା କରୁ, ମାଳା ଟ୍ରାକ୍ କରୁ ଏବଂ ଆପଣଙ୍କ ଧାରାକୁ ସ୍ୱୟଂଚାଳିତ ଭାବରେ ବଜାୟ ରଖୁ।';

  @override
  String get tour_title2 => 'ଗ୍ଲୋବାଲ୍ ଲିଡରବୋର୍ଡ';

  @override
  String get tour_body2 =>
      'ହଜାର ହଜାର ସହିତ ଜପ କରନ୍ତୁ। ଆଧ୍ୟାତ୍ମିକ ପ୍ରଗତି ଏବଂ ନିରନ୍ତରତା ମାଧ୍ୟମରେ ଉପରକୁ ଉଠନ୍ତୁ।';

  @override
  String get tour_title3 => 'ଦୈନିକ ଜ୍ଞାନ';

  @override
  String get tour_body3 =>
      'ପ୍ରାଚୀନ ଗ୍ରନ୍ଥରୁ ବଛା ଯାଇଥିବା ଶ୍ଲୋକ ପ୍ରାପ୍ତ କରନ୍ତୁ — ଏକାଧିକ ଭାଷାରେ ଉପଲବ୍ଧ।';

  @override
  String get tour_title4 => 'ଆପଣଙ୍କ ଆଧ୍ୟାତ୍ମିକ ଯାତ୍ରା';

  @override
  String get tour_body4 =>
      'ମାଇଲଖୁଣ୍ଟ ଟ୍ରାକ୍ କରନ୍ତୁ, ସଂକଳ୍ପ ସ୍ଥିର କରନ୍ତୁ ଏବଂ ଆପଣଙ୍କ ଅଭିବୃଦ୍ଧି ଏବଂ ଉପଲବ୍ଧି ଉପରେ ଚିନ୍ତନ କରନ୍ତୁ।';

  @override
  String get dialog_getStarted => 'ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String get dialog_next => 'ପରବର୍ତ୍ତୀ';

  @override
  String get dialog_skip => 'ଏଡାଇ ଦିଅନ୍ତୁ';

  @override
  String get malatype_regular => 'ସାଧାରଣ';

  @override
  String get malatype_crystal => 'ସ୍ଫଟିକ';

  @override
  String get malatype_royal => 'ରୟାଲ୍ ଗୋଲ୍ଡ';

  @override
  String get profile_abandon => 'ସଂକଳ୍ପ ତ୍ୟାଗ କରନ୍ତୁ';

  @override
  String get profile_progress => 'ପ୍ରଗତି';

  @override
  String get profile_deadline => 'ଶେଷ ତାରିଖ';

  @override
  String get profile_achieved => 'ହାସଲ ହେଲା!';

  @override
  String get support_donate => 'ଦାନ କରନ୍ତୁ';

  @override
  String get support_paymentSucc =>
      'Razorpay ଦ୍ୱାରା ସୁରକ୍ଷିତ ଭାବରେ ପେମେଣ୍ଟ ପ୍ରକ୍ରିୟାକରଣ କରାଯାଏ';

  @override
  String get support_thank => '🙏 ଧନ୍ୟବାଦ';

  @override
  String get home_customizeMala => 'ମାଳା କଷ୍ଟମାଇଜ୍ କରନ୍ତୁ';

  @override
  String get appTitle => 'Moksha Mala Jaap';

  @override
  String get login_welcome => 'ମୋକ୍ଷ ମାଳା ଜପକୁ ସ୍ୱାଗତ';

  @override
  String get profile_shareApp => 'ମୋକ୍ଷ ମାଳା ଜପ ସେୟାର କରନ୍ତୁ';

  @override
  String get profile_supportTitle => 'ମୋକ୍ଷ ମାଳା ଜପକୁ ସମର୍ଥନ କରନ୍ତୁ';

  @override
  String get dialog_updateDesc =>
      'ମହତ୍ତ୍ୱପୂର୍ଣ୍ଣ ଅଦ୍ୟତନ ସହିତ ମୋକ୍ଷ ମାଳା ଜପର ଏକ ନୂଆ ସଂସ୍କରଣ ଉପଲବ୍ଧ। ଜାରି ରଖିବା ପାଇଁ ଦୟାକରି ଆପ୍ ଅଦ୍ୟତନ କରନ୍ତୁ।';

  @override
  String get support_desc =>
      'ମୋକ୍ଷ ମାଳା ଜପ ହେଉଛି ପ୍ରେମର ପରିଶ୍ରମ, ଯାହା ଜଣେ ଏକକ ବିକାଶକାରୀଙ୍କ ଦ୍ୱାରା ନିର୍ମିତ। ଆପଣଙ୍କ ନିଃସ୍ୱାର୍ଥପର ଅବଦାନ (ସେବା) ସର୍ଭରଗୁଡ଼ିକୁ ଚାଲୁ ରଖିବାରେ, ବିଜ୍ଞାପନକୁ ସର୍ବନିମ୍ନ ରଖିବାରେ ଏବଂ ସମସ୍ତ ଭକ୍ତଙ୍କ ପାଇଁ ଆପକୁ ମାଗଣାରେ ରଖିବାରେ ସାହାଯ୍ୟ କରେ।';

  @override
  String get support_title => 'ମୋକ୍ଷ ମାଳା ଜପ ପ୍ରକଳ୍ପକୁ ସମର୍ଥନ କରନ୍ତୁ';

  @override
  String get support_afterTitile =>
      'ମୋକ୍ଷ ମାଳା ଜପକୁ ସମର୍ଥନ କରିଥିବାରୁ ଧନ୍ୟବାଦ — ପ୍ରତ୍ୟେକ ଅବଦାନ ସାହାଯ୍ୟ କରେ।';
}
