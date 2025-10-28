// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Willkommen bei Naam Jaap';

  @override
  String get login_subtitle =>
      'Dein persönlicher digitaler Chanting-Begleiter.';

  @override
  String get login_termsAgreement => 'Ich habe die ';

  @override
  String get login_termsAndConditions => 'Allgemeinen Geschäftsbedingungen';

  @override
  String get login_and => ' und die ';

  @override
  String get login_privacyPolicy => 'Datenschutzrichtlinie gelesen';

  @override
  String get login_signInWithGoogle => 'Mit Google anmelden';

  @override
  String get nav_home => 'Start';

  @override
  String get nav_leaderboard => 'Bestenliste';

  @override
  String get nav_wisdom => 'Weisheit';

  @override
  String get nav_profile => 'Mein Profil';

  @override
  String get home_tapToChant => 'Zum Chanten tippen';

  @override
  String get home_dayStreak => 'Tage in Folge';

  @override
  String get home_total => 'Gesamt:';

  @override
  String get home_mantraInfo => 'Mantra-Info';

  @override
  String get dialog_close => 'Schließen';

  @override
  String get wisdom_title => 'Weisheit für Heute';

  @override
  String get wisdom_dismissed =>
      'Über die heutige Weisheit wurde nachgedacht.\nEine neue Einsicht wird morgen eintreffen.';

  @override
  String get wisdom_loading => 'Lade Weisheit...';

  @override
  String get leaderboard_allTime => 'Gesamt';

  @override
  String get leaderboard_thisWeek => 'Diese Woche';

  @override
  String get leaderboard_yourProgress => 'Dein Fortschritt';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count Japas, um $playerName zu überholen';
  }

  @override
  String get leaderboard_empty => 'Die Reise beginnt!';

  @override
  String get leaderboard_emptySubtitle => 'Sei der Erste auf der Bestenliste!';

  @override
  String get leaderboard_isEmpty => 'Bestenliste ist leer.';

  @override
  String get leaderboard_noBade => 'Noch keine Abzeichen';

  @override
  String get leaderboard_notOnBoard =>
      'Chante weiter, um auf die Bestenliste zu kommen!';

  @override
  String get leaderboard_topOfBoard => 'Du bist an der Spitze! ✨';

  @override
  String get leaderboard_noChants => 'Noch keine Chants';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'Top-Mantra: $mantra';
  }

  @override
  String get profile_yourProgress => 'Dein Fortschritt';

  @override
  String get profile_dailyStreak => 'Tägliche Serie';

  @override
  String get profile_totalJapps => 'Japas Gesamt';

  @override
  String get profile_globalRank => 'Globaler Rang';

  @override
  String get profile_mantraTotals => 'Mantra-Summen';

  @override
  String get profile_achievements => 'Erfolge';

  @override
  String get profile_shareProgress => 'Teile deinen Fortschritt';

  @override
  String get profile_badgesEmpty =>
      'Beginne zu chanten, um dein erstes Abzeichen zu verdienen!';

  @override
  String get profile_mantrasEmpty =>
      'Beginne zu chanten, um deine Summen hier zu sehen!';

  @override
  String get profile_shareApp => 'Naam Jaap teilen';

  @override
  String get profile_rateApp => 'Bewerte unsere App';

  @override
  String get profile_supportTitle => 'Unterstütze Naam Jaap';

  @override
  String get profile_supportSubtitle => 'Hilf, die App am Laufen zu halten';

  @override
  String get profile_myBodhi => 'Mein Bodhi-Baum';

  @override
  String get profile_myBodhiSubtitle => 'Ein visuelles Zeugnis deiner Hingabe.';

  @override
  String get profile_yourAchievement => 'Deine Erfolge';

  @override
  String get profile_yourAchievements => 'Deine Erfolge';

  @override
  String get profile_aMark => 'Ein Zeichen deiner Hingabe.';

  @override
  String get profile_changeName => 'Deinen Namen ändern';

  @override
  String get profile_enterName => 'Neuen Namen eingeben';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_ambiance => 'Tempel-Ambiente';

  @override
  String get settings_ambianceDesc =>
      'Spiele leise Tempel-Hintergrundgeräusche ab.';

  @override
  String get settings_reminders => 'Tägliche Erinnerungen';

  @override
  String get settings_remindersDesc =>
      'Erhalte eine Benachrichtigung, wenn du heute noch nicht gechantet hast.';

  @override
  String get settings_language => 'App-Sprache';

  @override
  String get settings_feedback => 'Feedback & Support';

  @override
  String get settings_feedbackDesc =>
      'Melde einen Fehler oder schlage eine Funktion vor.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'Datenschutzrichtlinie';

  @override
  String get settings_terms => 'Allgemeine Geschäftsbedingungen';

  @override
  String get settings_deleteAccount => 'Mein Konto löschen';

  @override
  String get settings_signOut => 'Abmelden';

  @override
  String get dialog_deleteTitle => 'Konto löschen?';

  @override
  String get dialog_deleteBody =>
      'Diese Aktion ist dauerhaft und kann nicht rückgängig gemacht werden. Alle deine Chanting-Daten, Erfolge und persönlichen Informationen werden dauerhaft gelöscht.\n\nBist du absolut sicher, dass du fortfahren möchtest?';

  @override
  String get dialog_deleteConfirm => 'Ja, mein Konto löschen';

  @override
  String get dialog_continue => 'Weiter';

  @override
  String get dialog_pressBack => 'Zum Beenden erneut Zurück drücken';

  @override
  String get dialog_update => 'Update erforderlich';

  @override
  String get dialog_updateDesc =>
      'Eine neue Version von Naam Jaap ist mit wichtigen Updates verfügbar. Bitte aktualisiere die App, um fortzufahren.';

  @override
  String get dialog_updateNow => 'Jetzt aktualisieren';

  @override
  String get dialog_save => 'Speichern';

  @override
  String get dialog_something => 'Etwas ist schief gelaufen.';

  @override
  String get dialog_cancel => 'Abbrechen';

  @override
  String get misc_japps => 'Japas';

  @override
  String get misc_days => 'Tage';

  @override
  String get misc_badge => 'Badges';

  @override
  String get lang_chooseLang =>
      'Wähle deine bevorzugte Sprache, um fortzufahren';

  @override
  String get lang_searchLang => 'Sprachen suchen';

  @override
  String get garden_totalMala => 'Malas Terminés';

  @override
  String get misc_malas => 'Malas';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count Malas, um $playerName zu überholen';
  }

  @override
  String get dialog_mic =>
      'Mikrofonberechtigung ist zum Aufnehmen von Audio erforderlich.';

  @override
  String get custom_create => 'Erstelle dein Mantra';

  @override
  String get custom_yourMantra => 'Mantra-Name';

  @override
  String get custom_hint => 'z.B. Om Gurave Namah';

  @override
  String get custom_back => 'Wähle einen Hintergrund:';

  @override
  String get custom_addVoice => 'Füge deine Stimme hinzu (Optional):';

  @override
  String get custom_recording => 'Aufnahme...';

  @override
  String get custom_tapToRecord => 'Zum Aufnehmen auf das Mikrofon tippen';

  @override
  String get custom_saveMantra => 'Mantra speichern';

  @override
  String get custom_micAccess =>
      'Mikrofonberechtigung ist zum Aufnehmen von Audio erforderlich.';

  @override
  String get profile_yourCustomMantra => 'Meine benutzerdefinierten Mantras';

  @override
  String get profile_noCustoms =>
      'Du hast noch keine benutzerdefinierten Mantras hinzugefügt.';

  @override
  String get profile_addNewMantra => 'Neues Mantra hinzufügen';

  @override
  String get dialog_profilePictureUpdate => 'Profilbild aktualisiert!';

  @override
  String get dialog_failedToUpload => 'Bild konnte nicht hochgeladen werden.';

  @override
  String get dialog_exceptionCard =>
      'Kontext der teilbaren Karte ist nicht verfügbar.';

  @override
  String get dialog_checkoutMyProgress =>
      'Schau dir meinen Fortschritt in der NaamJaap-App an!';

  @override
  String get dialog_couldNotOpenPS =>
      'Play Store konnte nicht geöffnet werden.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" löschen?';
  }

  @override
  String get profile_deleteMantraSure =>
      'Bist du sicher? Alle Japa-Zählungen, die mit diesem Mantra verbunden sind, werden ebenfalls dauerhaft gelöscht.';

  @override
  String get profile_yesDelete => 'Ja, Löschen';

  @override
  String get profile_couldNotUserData =>
      'Benutzerdaten konnten nicht geladen werden.';

  @override
  String get misc_anonymous => 'Anonym';

  @override
  String get profile_sankalpaSet => 'Lege ein heiliges Gelübde ab';

  @override
  String get profile_sankalpaSubtitle =>
      'Setze ein persönliches Chanting-Ziel.';

  @override
  String get profile_sankalpaTitle => 'Dein Japa Sankalpa';

  @override
  String get profile_sankalpaChanting => 'Chanten';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' um $targetCount Mal zu erreichen.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'Bis $date';
  }

  @override
  String get dialog_sankalpaTitle => 'Setze dein Japa Sankalpa';

  @override
  String get dialog_sankalpaSelectMantra => 'Mantra auswählen';

  @override
  String get dialog_sankalpaTargetCount => 'Zielanzahl (z.B. 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Zieldatum';

  @override
  String get dialog_sankalpaSelectDate => 'Datum auswählen';

  @override
  String get dialog_sankalpaSetPledge => 'Mein Gelübde festlegen';

  @override
  String get dialog_sankalpaError => 'Bitte fülle alle Felder korrekt aus.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'Die Zielanzahl muss größer sein als deine aktuelle Anzahl.';

  @override
  String get support_openUPI => 'Öffne deine UPI-App...';

  @override
  String get support_cannotOpenUPI => 'UPI-App konnte nicht gestartet werden.';

  @override
  String get support_upiError =>
      'Fehler: Konnte keine UPI-App zum Öffnen finden.';

  @override
  String get support_title => 'Dein Seva hilft unserer Gemeinschaft zu wachsen';

  @override
  String get support_desc =>
      'Naam Jaap ist eine Liebesarbeit, erstellt von einem einzelnen Entwickler. Dein selbstloser Beitrag (Seva) hilft, die Server am Laufen zu halten, die Werbung minimal zu halten und die App für alle Anhänger kostenlos zu halten.';

  @override
  String get support_chooseOffering => 'WÄHLE EIN OPFER';

  @override
  String get support_enterAmt =>
      'Oder gib einen benutzerdefinierten Betrag ein (INR)';

  @override
  String get support_validAmt =>
      'Bitte wähle oder gib einen gültigen Betrag ein.';

  @override
  String get support_now => 'Jetzt unterstützen';
}
