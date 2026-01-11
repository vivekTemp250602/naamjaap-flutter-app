// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get login_subtitle => 'તમારો વ્યક્તિગત ડિજિટલ જાપ સાથી.';

  @override
  String get login_termsAgreement => 'મેં ';

  @override
  String get login_termsAndConditions => 'નિયમો અને શરતો';

  @override
  String get login_and => ' અને ';

  @override
  String get login_privacyPolicy => 'ગોપનીયતા નીતિ સાથે સંમત છું';

  @override
  String get login_signInWithGoogle => 'Google વડે સાઇન ઇન કરો';

  @override
  String get nav_home => 'હોમ';

  @override
  String get nav_leaderboard => 'લીડરબોર્ડ';

  @override
  String get nav_wisdom => 'જ્ઞાન';

  @override
  String get nav_profile => 'મારી પ્રોફાઇલ';

  @override
  String get home_tapToChant => 'જાપ કરવા માટે ટેપ કરો';

  @override
  String get home_dayStreak => 'દિવસની સ્ટ્રીક';

  @override
  String get home_total => 'કુલ:';

  @override
  String get home_mantraInfo => 'મંત્રની માહિતી';

  @override
  String get dialog_close => 'બંધ કરો';

  @override
  String get wisdom_title => 'આજનું જ્ઞાન';

  @override
  String get wisdom_dismissed =>
      'આજના જ્ઞાન પર વિચાર કરવામાં આવ્યો છે.\nઆવતીકાલે એક નવી સૂઝ આવશે.';

  @override
  String get wisdom_loading => 'જ્ઞાન લોડ થઈ રહ્યું છે...';

  @override
  String get leaderboard_allTime => 'સર્વકાલીન';

  @override
  String get leaderboard_thisWeek => 'આ અઠવાડિયે';

  @override
  String get leaderboard_yourProgress => 'તમારી પ્રગતિ';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName ને પસાર કરવા માટે $count જાપ';
  }

  @override
  String get leaderboard_empty => 'યાત્રા શરૂ થાય છે!';

  @override
  String get leaderboard_emptySubtitle => 'લીડરબોર્ડ પર પ્રથમ સ્થાન મેળવો!';

  @override
  String get leaderboard_isEmpty => 'લીડરબોર્ડ ખાલી છે.';

  @override
  String get leaderboard_noBade => 'હજુ સુધી કોઈ બેજ નથી';

  @override
  String get leaderboard_notOnBoard => 'બોર્ડ પર આવવા માટે જાપ કરતા રહો!';

  @override
  String get leaderboard_topOfBoard => 'તમે ટોચ પર છો! ✨';

  @override
  String get leaderboard_noChants => 'હજુ સુધી કોઈ જાપ નથી';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'ટોચનો મંત્ર: $mantra';
  }

  @override
  String get profile_yourProgress => 'તમારી પ્રગતિ';

  @override
  String get profile_dailyStreak => 'દૈનિક સ્ટ્રીક';

  @override
  String get profile_totalJapps => 'કુલ જાપ';

  @override
  String get profile_globalRank => 'વૈશ્વિક રેન્ક';

  @override
  String get profile_mantraTotals => 'મંત્રનો કુલ સરવાળો';

  @override
  String get profile_achievements => 'સિદ્ધિઓ';

  @override
  String get profile_shareProgress => 'તમારી પ્રગતિ શેર કરો';

  @override
  String get profile_badgesEmpty => 'તમારો પહેલો બેજ મેળવવા માટે જાપ શરૂ કરો!';

  @override
  String get profile_mantrasEmpty =>
      'તમારો કુલ સરવાળો અહીં જોવા માટે જાપ શરૂ કરો!';

  @override
  String get profile_rateApp => 'અમારી એપ્લિકેશનને રેટ કરો';

  @override
  String get profile_supportSubtitle => 'એપ્લિકેશનને ચાલુ રાખવામાં મદદ કરો';

  @override
  String get profile_myBodhi => 'મારું બોધિ વૃક્ષ';

  @override
  String get profile_myBodhiSubtitle => 'તમારી ભક્તિનો દ્રશ્ય પ્રમાણપત્ર.';

  @override
  String get profile_yourAchievement => 'તમારી સિદ્ધિઓ';

  @override
  String get profile_yourAchievements => 'તમારી સિદ્ધિઓ';

  @override
  String get profile_aMark => 'તમારા સમર્પણની નિશાની.';

  @override
  String get profile_changeName => 'તમારું નામ બદલો';

  @override
  String get profile_enterName => 'નવું નામ દાખલ કરો';

  @override
  String get settings_title => 'સેટિંગ્સ';

  @override
  String get settings_ambiance => 'મંદિરનું વાતાવરણ';

  @override
  String get settings_ambianceDesc => 'મંદિરના હળવા પૃષ્ઠભૂમિ અવાજો વગાડો.';

  @override
  String get settings_reminders => 'દૈનિક રીમાઇન્ડર્સ';

  @override
  String get settings_remindersDesc =>
      'જો તમે આજે જાપ ન કર્યો હોય તો સૂચના મેળવો.';

  @override
  String get settings_language => 'એપની ભાષા';

  @override
  String get settings_feedback => 'પ્રતિભાવ અને સમર્થન';

  @override
  String get settings_feedbackDesc => 'બગની જાણ કરો અથવા સુવિધા સૂચવો.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'ગોપનીયતા નીતિ';

  @override
  String get settings_terms => 'નિયમો અને શરતો';

  @override
  String get settings_deleteAccount => 'મારું એકાઉન્ટ ડિલીટ કરો';

  @override
  String get settings_signOut => 'સાઇન આઉટ';

  @override
  String get dialog_deleteTitle => 'એકાઉન્ટ ડિલીટ કરવું છે?';

  @override
  String get dialog_deleteBody =>
      'આ ક્રિયા કાયમી છે અને તેને પૂર્વવત્ કરી શકાતી નથી. તમારો બધો જાપ ડેટા, સિદ્ધિઓ અને વ્યક્તિગત માહિતી કાયમ માટે ભૂંસી નાખવામાં આવશે।\n\nશું તમે ખરેખર આગળ વધવા માંગો છો?';

  @override
  String get dialog_deleteConfirm => 'હા, મારું એકાઉન્ટ ડિલીટ કરો';

  @override
  String get dialog_continue => 'ચાલુ રાખો';

  @override
  String get dialog_pressBack => 'બહાર નીકળવા માટે ફરીથી પાછા દબાવો';

  @override
  String get dialog_update => 'અપડેટ જરૂરી છે';

  @override
  String get dialog_updateNow => 'હવે અપડેટ કરો';

  @override
  String get dialog_save => 'સાચવો';

  @override
  String get dialog_something => 'કંઈક ખોટું થયું.';

  @override
  String get dialog_cancel => 'રદ કરો';

  @override
  String get misc_japps => 'જાપ';

  @override
  String get misc_days => 'દિવસો';

  @override
  String get misc_badge => 'બેજ';

  @override
  String get lang_chooseLang => 'ચાલુ રાખવા માટે તમારી પસંદગીની ભાષા પસંદ કરો';

  @override
  String get lang_searchLang => 'ભાષાઓ શોધો';

  @override
  String get garden_totalMala => 'પૂર્ણ થયેલી માળાઓ';

  @override
  String get misc_malas => 'માળાઓ';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName ને પસાર કરવા માટે $count માળાઓ';
  }

  @override
  String get dialog_mic =>
      'ઓડિયો રેકોર્ડ કરવા માટે માઇક્રોફોનની પરવાનગી જરૂરી છે.';

  @override
  String get custom_create => 'તમારો મંત્ર બનાવો';

  @override
  String get custom_yourMantra => 'મંત્રનું નામ';

  @override
  String get custom_hint => 'દા.ત., ઓમ ગુરવે નમઃ';

  @override
  String get custom_back => 'બેકગ્રાઉન્ડ પસંદ કરો:';

  @override
  String get custom_addVoice => 'તમારો અવાજ ઉમેરો (વૈકલ્પિક):';

  @override
  String get custom_recording => 'રેકોર્ડિંગ થઈ રહ્યું છે...';

  @override
  String get custom_tapToRecord => 'રેકોર્ડ કરવા માટે માઇક પર ટેપ કરો';

  @override
  String get custom_saveMantra => 'મંત્ર સાચવો';

  @override
  String get custom_micAccess =>
      'ઓડિયો રેકોર્ડ કરવા માટે માઇક્રોફોનની પરવાનગી જરૂરી છે.';

  @override
  String get profile_yourCustomMantra => 'મારા કસ્ટમ મંત્રો';

  @override
  String get profile_noCustoms => 'તમે હજી સુધી કોઈ કસ્ટમ મંત્રો ઉમેર્યા નથી.';

  @override
  String get profile_addNewMantra => 'નવો મંત્ર ઉમેરો';

  @override
  String get dialog_profilePictureUpdate => 'પ્રોફાઇલ ચિત્ર અપડેટ થયું!';

  @override
  String get dialog_failedToUpload => 'છબી અપલોડ કરવામાં નિષ્ફળ.';

  @override
  String get dialog_exceptionCard =>
      'શેર કરી શકાય તેવું કાર્ડ સંદર્ભ ઉપલબ્ધ નથી.';

  @override
  String get dialog_checkoutMyProgress =>
      'નામજાપ એપ્લિકેશન પર મારી પ્રગતિ તપાસો!';

  @override
  String get dialog_couldNotOpenPS => 'પ્લે સ્ટોર ખોલી શકાયું નથી.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" કાઢી નાખવું છે?';
  }

  @override
  String get profile_deleteMantraSure =>
      'શું તમે ચોક્કસ છો? આ મંત્ર સાથે સંકળાયેલ તમામ જાપ ગણતરીઓ પણ કાયમ માટે કાઢી નાખવામાં આવશે.';

  @override
  String get profile_yesDelete => 'હા, કાઢી નાખો';

  @override
  String get profile_couldNotUserData => 'વપરાશકર્તા ડેટા લોડ કરી શકાયો નથી.';

  @override
  String get misc_anonymous => 'અનામિક';

  @override
  String get profile_sankalpaSet => 'એક પવિત્ર સંકલ્પ કરો';

  @override
  String get profile_sankalpaSubtitle => 'વ્યક્તિગત જાપ લક્ષ્ય નક્કી કરો.';

  @override
  String get profile_sankalpaTitle => 'તમારો જાપ સંકલ્પ';

  @override
  String get profile_sankalpaChanting => 'જાપ કરી રહ્યા છીએ';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount વખત પહોંચવા માટે.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date સુધીમાં';
  }

  @override
  String get dialog_sankalpaTitle => 'તમારો જાપ સંકલ્પ નક્કી કરો';

  @override
  String get dialog_sankalpaSelectMantra => 'મંત્ર પસંદ કરો';

  @override
  String get dialog_sankalpaTargetCount => 'લક્ષ્ય ગણતરી (દા.ત., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'લક્ષ્ય તારીખ';

  @override
  String get dialog_sankalpaSelectDate => 'તારીખ પસંદ કરો';

  @override
  String get dialog_sankalpaSetPledge => 'મારો સંકલ્પ નક્કી કરો';

  @override
  String get dialog_sankalpaError => 'કૃપા કરીને બધી ફીલ્ડ્સ યોગ્ય રીતે ભરો.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'લક્ષ્ય ગણતરી તમારી વર્તમાન ગણતરી કરતાં વધુ હોવી જોઈએ.';

  @override
  String get support_openUPI => 'તમારી UPI એપ્લિકેશન ખુલી રહી છે...';

  @override
  String get support_cannotOpenUPI => 'UPI એપ્લિકેશન લૉન્ચ કરી શકાઈ નથી.';

  @override
  String get support_upiError => 'ભૂલ: ખોલવા માટે કોઈ UPI એપ્લિકેશન મળી નથી.';

  @override
  String get support_chooseOffering => 'એક અર્પણ પસંદ કરો';

  @override
  String get support_enterAmt => 'અથવા કસ્ટમ રકમ દાખલ કરો (INR)';

  @override
  String get support_validAmt => 'કૃપા કરીને માન્ય રકમ પસંદ કરો અથવા દાખલ કરો.';

  @override
  String get support_now => 'હવે સપોર્ટ કરો';

  @override
  String get home_chooseMala => 'તમારી માળા પસંદ કરો';

  @override
  String get home_chooseMalaDesc =>
      'એવી શૈલી પસંદ કરો જે તમારા આત્મા સાથે ગુંજે.';

  @override
  String get tour_title1 => 'ડિજિટલ જાપ માળા';

  @override
  String get tour_body1 =>
      'જાપ કરવા માટે ટેપ કરો. અમે તમારા મણકા ગણીએ છીએ, માળાઓ ટ્રેક કરીએ છીએ અને તમારી સ્ટ્રીક આપમેળે જાળવીએ છીએ.';

  @override
  String get tour_title2 => 'વૈશ્વિક લીડરબોર્ડ';

  @override
  String get tour_body2 =>
      'હજારો લોકો સાથે જાપ કરો. આધ્યાત્મિક પ્રગતિ અને સાતત્ય દ્વારા આગળ વધો.';

  @override
  String get tour_title3 => 'દૈનિક જ્ઞાન';

  @override
  String get tour_body3 =>
      'પ્રાચીન ગ્રંથોમાંથી પસંદ કરેલા શ્લોકો મેળવો — બહુવિધ ભાષાઓમાં ઉપલબ્ધ.';

  @override
  String get tour_title4 => 'તમારી આધ્યાત્મિક યાત્રા';

  @override
  String get tour_body4 =>
      'માઇલસ્ટોન્સ ટ્રેક કરો, સંકલ્પો નક્કી કરો અને તમારી વૃદ્ધિ અને સિદ્ધિઓ પર વિચાર કરો.';

  @override
  String get dialog_getStarted => 'શરૂ કરો';

  @override
  String get dialog_next => 'આગળ';

  @override
  String get dialog_skip => 'છોડો';

  @override
  String get malatype_regular => 'નિયમિત';

  @override
  String get malatype_crystal => 'સ્ફટિક';

  @override
  String get malatype_royal => 'રોયલ ગોલ્ડ';

  @override
  String get profile_abandon => 'સંકલ્પ છોડો';

  @override
  String get profile_progress => 'પ્રગતિ';

  @override
  String get profile_deadline => 'અંતિમ મુદત';

  @override
  String get profile_achieved => 'સિદ્ધ થયું!';

  @override
  String get support_donate => 'દાન કરો';

  @override
  String get support_paymentSucc =>
      'Razorpay દ્વારા ચૂકવણી સુરક્ષિત રીતે પ્રક્રિયા કરવામાં આવે છે';

  @override
  String get support_thank => '🙏 આભાર';

  @override
  String get home_customizeMala => 'માળા કસ્ટમાઇઝ કરો';

  @override
  String get appTitle => 'Moksha Mala Jaap';

  @override
  String get login_welcome => 'મોક્ષ માળા જાપમાં આપનું સ્વાગત છે';

  @override
  String get profile_shareApp => 'મોક્ષ માળા જાપ શેર કરો';

  @override
  String get profile_supportTitle => 'મોક્ષ માળા જાપને સપોર્ટ કરો';

  @override
  String get dialog_updateDesc =>
      'મોક્ષ માળા જાપનું નવું સંસ્કરણ મહત્વપૂર્ણ અપડેટ્સ સાથે ઉપલબ્ધ છે. ચાલુ રાખવા માટે કૃપા કરીને એપ્લિકેશન અપડેટ કરો.';

  @override
  String get support_desc =>
      'મોક્ષ માળા જાપ એ પ્રેમનો શ્રમ છે, જે એક સોલો ડેવલપર દ્વારા બનાવવામાં આવ્યો છે. તમારું નિઃસ્વાર્થ યોગદાન (સેવા) સર્વરને ચાલુ રાખવામાં, જાહેરાતોને ન્યૂનતમ રાખવામાં અને બધા ભક્તો માટે એપ્લિકેશનને મફત રાખવામાં મદદ કરે છે.';

  @override
  String get support_title => 'મોક્ષ માળા જાપ પ્રોજેક્ટને સપોર્ટ કરો';

  @override
  String get support_afterTitile =>
      'મોક્ષ માળા જાપને સપોર્ટ કરવા બદલ આભાર — દરેક યોગદાન મદદ કરે છે.';
}
