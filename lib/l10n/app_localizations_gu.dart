// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'નામ જાપમાં આપનું સ્વાગત છે';

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
  String get profile_shareApp => 'નામ જાપ શેર કરો';

  @override
  String get profile_rateApp => 'અમારી એપ્લિકેશનને રેટ કરો';

  @override
  String get profile_supportTitle => 'નામ જાપને સપોર્ટ કરો';

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
  String get dialog_updateDesc =>
      'નામ જાપનું નવું સંસ્કરણ મહત્વપૂર્ણ અપડેટ્સ સાથે ઉપલબ્ધ છે. ચાલુ રાખવા માટે કૃપા કરીને એપ્લિકેશન અપડેટ કરો.';

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
}
