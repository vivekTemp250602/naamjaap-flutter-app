// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Bienvenue sur Naam Jaap';

  @override
  String get login_subtitle => 'Votre compagnon personnel de chant numérique.';

  @override
  String get login_termsAgreement => 'J\'ai lu et j\'accepte les ';

  @override
  String get login_termsAndConditions => 'Termes & Conditions';

  @override
  String get login_and => ' et la ';

  @override
  String get login_privacyPolicy => 'Politique de Confidentialité';

  @override
  String get login_signInWithGoogle => 'Se connecter avec Google';

  @override
  String get nav_home => 'Accueil';

  @override
  String get nav_leaderboard => 'Classement';

  @override
  String get nav_wisdom => 'Sagesse';

  @override
  String get nav_profile => 'Mon Profil';

  @override
  String get home_tapToChant => 'Touchez pour Chanter';

  @override
  String get home_dayStreak => 'Série de Jours';

  @override
  String get home_total => 'Total :';

  @override
  String get home_mantraInfo => 'Info Mantra';

  @override
  String get dialog_close => 'Fermer';

  @override
  String get wisdom_title => 'Sagesse du Jour';

  @override
  String get wisdom_dismissed =>
      'La sagesse d\'aujourd\'hui a été contemplée.\nUne nouvelle perspective arrivera demain.';

  @override
  String get wisdom_loading => 'Chargement de la sagesse...';

  @override
  String get leaderboard_allTime => 'Général';

  @override
  String get leaderboard_thisWeek => 'Cette Semaine';

  @override
  String get leaderboard_yourProgress => 'Votre Progression';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count chants pour dépasser $playerName';
  }

  @override
  String get leaderboard_empty => 'Le voyage commence !';

  @override
  String get leaderboard_emptySubtitle =>
      'Soyez le premier à figurer au classement !';

  @override
  String get leaderboard_isEmpty => 'Le classement est vide.';

  @override
  String get leaderboard_noBade => 'Aucun badge pour le moment';

  @override
  String get leaderboard_notOnBoard =>
      'Continuez à chanter pour figurer au classement !';

  @override
  String get leaderboard_topOfBoard => 'Vous êtes au sommet ! ✨';

  @override
  String get leaderboard_noChants => 'Aucun chant pour le moment';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'Mantra Principal : $mantra';
  }

  @override
  String get profile_yourProgress => 'Votre Progression';

  @override
  String get profile_dailyStreak => 'Série Quotidienne';

  @override
  String get profile_totalJapps => 'Total Chants';

  @override
  String get profile_globalRank => 'Rang Mondial';

  @override
  String get profile_mantraTotals => 'Totaux des Mantras';

  @override
  String get profile_achievements => 'Succès';

  @override
  String get profile_shareProgress => 'Partagez Votre Progression';

  @override
  String get profile_badgesEmpty =>
      'Commencez à chanter pour gagner votre premier badge !';

  @override
  String get profile_mantrasEmpty =>
      'Commencez à chanter pour voir vos totaux ici !';

  @override
  String get profile_shareApp => 'Partager Naam Jaap';

  @override
  String get profile_rateApp => 'Évaluez notre application';

  @override
  String get profile_supportTitle => 'Soutenir Naam Jaap';

  @override
  String get profile_supportSubtitle =>
      'Aidez à maintenir l\'application en fonctionnement';

  @override
  String get profile_myBodhi => 'Mon Arbre Bodhi';

  @override
  String get profile_myBodhiSubtitle =>
      'Un témoignage visuel de votre dévotion.';

  @override
  String get profile_yourAchievement => 'Vos Réalisations';

  @override
  String get profile_yourAchievements => 'Vos Réalisations';

  @override
  String get profile_aMark => 'Une marque de votre dévouement.';

  @override
  String get profile_changeName => 'Changer votre nom';

  @override
  String get profile_enterName => 'Entrez un nouveau Nom';

  @override
  String get settings_title => 'Réglages';

  @override
  String get settings_ambiance => 'Ambiance de Temple';

  @override
  String get settings_ambianceDesc =>
      'Jouer des sons subtils de temple en fond.';

  @override
  String get settings_reminders => 'Rappels Quotidiens';

  @override
  String get settings_remindersDesc =>
      'Recevez une notification si vous n\'avez pas chanté aujourd\'hui.';

  @override
  String get settings_language => 'Langue de l\'App';

  @override
  String get settings_feedback => 'Avis & Support';

  @override
  String get settings_feedbackDesc =>
      'Signaler un bug ou suggérer une fonctionnalité.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'Politique de Confidentialité';

  @override
  String get settings_terms => 'Termes & Conditions';

  @override
  String get settings_deleteAccount => 'Supprimer Mon Compte';

  @override
  String get settings_signOut => 'Se Déconnecter';

  @override
  String get dialog_deleteTitle => 'Supprimer le Compte ?';

  @override
  String get dialog_deleteBody =>
      'Cette action est permanente et ne peut être annulée. Toutes vos données de chant, succès et informations personnelles seront effacés de façon permanente.\n\nÊtes-vous absolument sûr de vouloir continuer ?';

  @override
  String get dialog_deleteConfirm => 'Oui, Supprimer Mon Compte';

  @override
  String get dialog_continue => 'Continuer';

  @override
  String get dialog_pressBack => 'Appuyez à nouveau sur retour pour quitter';

  @override
  String get dialog_update => 'Mise à jour requise';

  @override
  String get dialog_updateDesc =>
      'Une nouvelle version de Naam Jaap est disponible avec des mises à jour importantes. Veuillez mettre à jour l\'application pour continuer.';

  @override
  String get dialog_updateNow => 'Mettre à jour maintenant';

  @override
  String get dialog_save => 'Enregistrer';

  @override
  String get dialog_something => 'Quelque chose s\'est mal passé.';

  @override
  String get dialog_cancel => 'Annuler';

  @override
  String get misc_japps => 'chants';

  @override
  String get misc_days => 'Jours';

  @override
  String get misc_badge => 'Badges';

  @override
  String get lang_chooseLang =>
      'Choisissez votre langue préférée pour continuer';

  @override
  String get lang_searchLang => 'Rechercher des langues';

  @override
  String get garden_totalMala => 'Malas Terminés';

  @override
  String get misc_malas => 'Malas';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count malas pour dépasser $playerName';
  }

  @override
  String get dialog_mic =>
      'L\'autorisation du microphone est requise pour enregistrer l\'audio.';

  @override
  String get custom_create => 'Créez votre Mantra';

  @override
  String get custom_yourMantra => 'Nom du Mantra';

  @override
  String get custom_hint => 'ex., Om Gurave Namah';

  @override
  String get custom_back => 'Choisissez un arrière-plan :';

  @override
  String get custom_addVoice => 'Ajoutez votre voix (Optionnel) :';

  @override
  String get custom_recording => 'Enregistrement...';

  @override
  String get custom_tapToRecord => 'Appuyez sur le micro pour enregistrer';

  @override
  String get custom_saveMantra => 'Enregistrer le Mantra';

  @override
  String get custom_micAccess =>
      'L\'autorisation du microphone est requise pour enregistrer l\'audio.';

  @override
  String get profile_yourCustomMantra => 'Mes Mantras Personnalisés';

  @override
  String get profile_noCustoms =>
      'Vous n\'avez pas encore ajouté de mantras personnalisés.';

  @override
  String get profile_addNewMantra => 'Ajouter un Nouveau Mantra';

  @override
  String get dialog_profilePictureUpdate => 'Photo de profil mise à jour !';

  @override
  String get dialog_failedToUpload => 'Échec du téléchargement de l\'image.';

  @override
  String get dialog_exceptionCard =>
      'Le contexte de la carte partageable n\'est pas disponible.';

  @override
  String get dialog_checkoutMyProgress =>
      'Découvrez ma progression sur l\'application NaamJaap !';

  @override
  String get dialog_couldNotOpenPS => 'Impossible d\'ouvrir le Play Store.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return 'Supprimer \"$mantraName\" ?';
  }

  @override
  String get profile_deleteMantraSure =>
      'Êtes-vous sûr ? Tous les comptes de japa associés à ce mantra seront également supprimés de façon permanente.';

  @override
  String get profile_yesDelete => 'Oui, Supprimer';

  @override
  String get profile_couldNotUserData =>
      'Impossible de charger les données utilisateur.';

  @override
  String get misc_anonymous => 'Anonyme';

  @override
  String get profile_sankalpaSet => 'Faites un Vœu Sacré';

  @override
  String get profile_sankalpaSubtitle =>
      'Fixez un objectif personnel de chant.';

  @override
  String get profile_sankalpaTitle => 'Votre Sankalpa Japa';

  @override
  String get profile_sankalpaChanting => 'Chantant';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' pour atteindre $targetCount fois.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'D\'ici le $date';
  }

  @override
  String get dialog_sankalpaTitle => 'Définissez votre Sankalpa Japa';

  @override
  String get dialog_sankalpaSelectMantra => 'Sélectionner le Mantra';

  @override
  String get dialog_sankalpaTargetCount => 'Nombre Cible (ex., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Date Cible';

  @override
  String get dialog_sankalpaSelectDate => 'Sélectionner une date';

  @override
  String get dialog_sankalpaSetPledge => 'Définir mon Vœu';

  @override
  String get dialog_sankalpaError =>
      'Veuillez remplir tous les champs correctement.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'Le nombre cible doit être supérieur à votre nombre actuel.';

  @override
  String get support_openUPI => 'Ouverture de votre application UPI...';

  @override
  String get support_cannotOpenUPI =>
      'Impossible de lancer l\'application UPI.';

  @override
  String get support_upiError =>
      'Erreur : Impossible de trouver une application UPI à ouvrir.';

  @override
  String get support_title => 'Votre Seva Aide Notre Communauté à Grandir';

  @override
  String get support_desc =>
      'Naam Jaap est un travail d\'amour, créé par un développeur solo. Votre contribution désintéressée (Seva) aide à maintenir les serveurs en fonctionnement, les publicités minimales et l\'application gratuite pour tous les dévots.';

  @override
  String get support_chooseOffering => 'CHOISISSEZ UNE OFFRANDE';

  @override
  String get support_enterAmt => 'Ou entrez un montant personnalisé (INR)';

  @override
  String get support_validAmt =>
      'Veuillez sélectionner ou entrer un montant valide.';

  @override
  String get support_now => 'Soutenir maintenant';
}
