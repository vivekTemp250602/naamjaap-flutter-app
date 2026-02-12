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
  String get login_privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get login_signInWithGoogle => 'Mit Google anmelden';

  @override
  String get nav_home => 'Startseite';

  @override
  String get nav_leaderboard => 'Bestenliste';

  @override
  String get nav_wisdom => 'Weisheit';

  @override
  String get nav_profile => 'Mein Profil';

  @override
  String get home_tapToChant => 'Tippen zum Chanten';

  @override
  String get home_dayStreak => 'Tages-Serie';

  @override
  String get home_total => 'Gesamt:';

  @override
  String get home_mantraInfo => 'Mantra-Info';

  @override
  String get home_chooseMala => 'Wähle deine Mala';

  @override
  String get home_chooseMalaDesc =>
      'Wähle einen Stil, der mit deinem Geist resoniert.';

  @override
  String get home_customizeMala => 'Mala anpassen';

  @override
  String get tour_home_carousel_title => 'Wähle dein Mantra';

  @override
  String get tour_home_carousel_desc =>
      'Wische, um zwischen mächtigen vedischen Mantras zu wechseln.';

  @override
  String get tour_home_mala_title => 'Tippen zum Chanten';

  @override
  String get tour_home_mala_desc =>
      'Tippe irgendwo auf den Kreis, um die Perlen zu bewegen. Vervollständige 108 für eine Mala.';

  @override
  String get tour_home_toolkit_title => 'Dein Toolkit';

  @override
  String get tour_home_toolkit_desc =>
      'Passe Perlenstile an, schalte Audio um oder sieh dir Bedeutungen an.';

  @override
  String get tour_leader_toggle_title => 'Wöchentlich vs. Gesamt';

  @override
  String get tour_leader_toggle_desc =>
      'Tippe hier, um zwischen den Wochenführern und den Legenden aller Zeiten zu wechseln.';

  @override
  String get tour_leader_podium_title => 'Die Top 3';

  @override
  String get tour_leader_podium_desc =>
      'Die engagiertesten Chanter erscheinen hier. Chante weiter, um dich ihnen anzuschließen!';

  @override
  String get tour_wisdom_card_title => 'Tägliche Weisheit & Teilen';

  @override
  String get tour_wisdom_card_desc =>
      'Starte deinen Tag mit einem neuen Shloka. Tippe auf das Teilen-Symbol, um ein Bild zu erstellen!';

  @override
  String get tour_profile_stats_title => 'Deine spirituellen Statistiken';

  @override
  String get tour_profile_stats_desc =>
      'Verfolge hier deine Serie, die gesamte Japa-Anzahl und deinen globalen Rang.';

  @override
  String get tour_profile_offline_title => 'Physisches Chanten?';

  @override
  String get tour_profile_offline_desc =>
      'Wenn du eine echte Mala verwendest, tippe hier, um deine Zählungen manuell hinzuzufügen.';

  @override
  String get tour_profile_bodhi_desc =>
      'Jede Mala, die du chantest, hilft deinem spirituellen Garten zu wachsen. Schalte neue Bäume frei!';

  @override
  String get tour_profile_sankalpa_desc =>
      'Setze ein Zieldatum und eine Anzahl, um dich einem spirituellen Ziel zu verpflichten.';

  @override
  String get guest_mode_title => 'Gastmodus';

  @override
  String get guest_mode_desc =>
      'Melde dich an, um dein spirituelles Profil freizuschalten.';

  @override
  String get guest_signin_btn => 'Anmelden';

  @override
  String get wisdom_title => 'Weisheit für Heute';

  @override
  String get wisdom_dismissed =>
      'Die heutige Weisheit wurde betrachtet.\nEine neue Einsicht wird morgen eintreffen.';

  @override
  String get wisdom_loading => 'Lade Weisheit...';

  @override
  String get wisdom_signin_to_share => 'Melde dich an, um Karten zu teilen!';

  @override
  String get wisdom_creating_card => 'Erstelle deine göttliche Karte...';

  @override
  String get leaderboard_allTime => 'Allzeit';

  @override
  String get leaderboard_thisWeek => 'Diese Woche';

  @override
  String get leaderboard_yourProgress => 'Dein Fortschritt';

  @override
  String get leaderboard_yourRank => 'Dein Rang';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count Japps, um $playerName zu überholen';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count Malas, um $playerName zu überholen';
  }

  @override
  String get leaderboard_empty => 'Die Reise beginnt!';

  @override
  String get leaderboard_emptySubtitle =>
      'Sei der Erste, der die Bestenliste ziert!';

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
  String leaderboard_topMantra(String mantra) {
    return 'Top-Mantra: $mantra';
  }

  @override
  String get profile_yourProgress => 'Dein Fortschritt';

  @override
  String get profile_dailyStreak => 'Tägliche Serie';

  @override
  String get profile_totalJapps => 'Gesamte Japps';

  @override
  String get profile_globalRank => 'Globaler Rang';

  @override
  String get profile_mantraTotals => 'Mantra-Gesamtsummen';

  @override
  String get profile_achievements => 'Erfolge';

  @override
  String get profile_shareProgress => 'Fortschritt teilen';

  @override
  String get profile_badgesEmpty =>
      'Fange an zu chanten, um dein erstes Abzeichen zu verdienen!';

  @override
  String get profile_mantrasEmpty =>
      'Fange an zu chanten, um deine Gesamtsummen hier zu sehen!';

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
  String get profile_shareApp => 'Naam Jaap teilen';

  @override
  String get profile_yourCustomMantra => 'Meine benutzerdefinierten Mantras';

  @override
  String get profile_noCustoms =>
      'Du hast noch keine benutzerdefinierten Mantras hinzugefügt.';

  @override
  String get profile_addNewMantra => 'Neues Mantra hinzufügen';

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
  String get profile_offline_card_title => 'Offline-Japa protokollieren';

  @override
  String get profile_offline_card_subtitle =>
      'Zählungen von deiner physischen Mala hinzufügen';

  @override
  String get profile_gamification_header => 'Gamifizierung';

  @override
  String get profile_commitments_header => 'Verpflichtungen';

  @override
  String get profile_insights_header => 'Mantra-Einblicke';

  @override
  String get profile_my_mantras_header => 'Meine Mantras';

  @override
  String get profile_quick_actions_header => 'Schnellaktionen';

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
  String get profile_abandon => 'Gelübde aufgeben';

  @override
  String get profile_progress => 'FORTSCHRITT';

  @override
  String get profile_deadline => 'FRIST';

  @override
  String get profile_achieved => 'Erreicht!';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' um $targetCount Mal zu erreichen.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'Bis $date';
  }

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_ambiance => 'Tempel-Ambiente';

  @override
  String get settings_ambianceDesc => 'Spiele subtile Tempelklänge ab.';

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
  String get settings_deletingAccount => 'Dein Konto wird gelöscht...';

  @override
  String get settings_privacy => 'Datenschutzrichtlinie';

  @override
  String get settings_terms => 'Allgemeine Geschäftsbedingungen';

  @override
  String get settings_deleteAccount => 'Mein Konto löschen';

  @override
  String get settings_signOut => 'Abmelden';

  @override
  String get settings_exit_guest => 'Gastmodus verlassen';

  @override
  String get settings_support_header => 'Support & Rechtliches';

  @override
  String get settings_account_header => 'Konto';

  @override
  String get support_title => 'Unterstütze das Naam Jaap Projekt';

  @override
  String get support_desc =>
      'Naam Jaap ist eine Liebesarbeit, erstellt von einem einzelnen Entwickler. Dein selbstloser Beitrag (Seva) hilft, die Server am Laufen zu halten, die Werbung minimal zu halten und die App für alle Anhänger kostenlos zu halten.';

  @override
  String get support_afterTitile =>
      'Danke, dass du Naam Jaap unterstützt — jeder Beitrag hilft.';

  @override
  String get support_openUPI => 'Öffne deine UPI-App...';

  @override
  String get support_cannotOpenUPI => 'UPI-App konnte nicht gestartet werden.';

  @override
  String get support_upiError =>
      'Fehler: Konnte keine UPI-App zum Öffnen finden.';

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

  @override
  String get support_donate => 'Spenden';

  @override
  String get support_paymentSucc =>
      'Zahlungen sicher verarbeitet durch Razorpay';

  @override
  String get support_thank => '🙏 Danke';

  @override
  String get support_offer_seva => 'Seva anbieten';

  @override
  String get support_signin_required =>
      'Bitte melde dich an, um einen Beitrag zu leisten.';

  @override
  String get support_payment_error =>
      'Zahlung konnte nicht gestartet werden. Bitte versuche es erneut.';

  @override
  String get support_blessed => 'Mögest du gesegnet sein.';

  @override
  String get support_tier_flower => 'Blumenopfer';

  @override
  String get support_tier_lamp => 'Lampenentzündung';

  @override
  String get support_tier_garland => 'Girlanden-Seva';

  @override
  String get support_tier_temple => 'Tempelunterstützung';

  @override
  String get support_tier_grand => 'Großes Opfer';

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
  String get custom_preview => 'VORSCHAU';

  @override
  String get custom_voice_saved => 'Sprachnotiz gespeichert';

  @override
  String get custom_tap_record => 'Tippen zur Aufnahme';

  @override
  String get custom_ready_use => 'Bereit zur Verwendung';

  @override
  String get custom_error_empty_name => 'Bitte gib einen Mantra-Namen ein';

  @override
  String get garden_title => 'Bodhi-Garten';

  @override
  String get garden_subtitle => 'Lasse deinen spirituellen Wald wachsen';

  @override
  String get garden_growth => 'Spirituelles Wachstum';

  @override
  String get garden_totalMala => 'Abgeschlossene Malas';

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
  String get dialog_close => 'Schließen';

  @override
  String get dialog_something => 'Etwas ist schief gelaufen.';

  @override
  String get dialog_cancel => 'Abbrechen';

  @override
  String get dialog_profilePictureUpdate => 'Profilbild aktualisiert!';

  @override
  String get dialog_failedToUpload => 'Bild konnte nicht hochgeladen werden.';

  @override
  String get dialog_exceptionCard =>
      'Kontext der teilbaren Karte ist nicht verfügbar.';

  @override
  String get dialog_couldNotOpenPS =>
      'Play Store konnte nicht geöffnet werden.';

  @override
  String get dialog_mic =>
      'Mikrofonberechtigung ist zum Aufnehmen von Audio erforderlich.';

  @override
  String get dialog_getStarted => 'Loslegen';

  @override
  String get dialog_next => 'Weiter';

  @override
  String get dialog_skip => 'Überspringen';

  @override
  String get dialog_checkoutMyProgress =>
      'Schau dir meinen Fortschritt in der Naam Jaap App an!';

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
  String get misc_japps => 'Japps';

  @override
  String get misc_days => 'Tage';

  @override
  String get misc_badge => 'Abzeichen';

  @override
  String get misc_malas => 'Malas';

  @override
  String get misc_anonymous => 'Anonym';

  @override
  String get lang_chooseLang =>
      'Wähle deine bevorzugte Sprache, um fortzufahren';

  @override
  String get lang_searchLang => 'Sprachen suchen';

  @override
  String get malatype_regular => 'Regulär';

  @override
  String get malatype_crystal => 'Kristall';

  @override
  String get malatype_royal => 'Königliches Gold';
}
