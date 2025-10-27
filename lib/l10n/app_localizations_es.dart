// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Bienvenido a Naam Jaap';

  @override
  String get login_subtitle => 'Tu compañero personal de canto digital.';

  @override
  String get login_termsAgreement => 'He leído y acepto los ';

  @override
  String get login_termsAndConditions => 'Términos y Condiciones';

  @override
  String get login_and => ' y la ';

  @override
  String get login_privacyPolicy => 'Política de Privacidad';

  @override
  String get login_signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_leaderboard => 'Clasificación';

  @override
  String get nav_wisdom => 'Sabiduría';

  @override
  String get nav_profile => 'Mi Perfil';

  @override
  String get home_tapToChant => 'Toca para Cantar';

  @override
  String get home_dayStreak => 'Racha de Días';

  @override
  String get home_total => 'Total:';

  @override
  String get home_mantraInfo => 'Info del Mantra';

  @override
  String get dialog_close => 'Cerrar';

  @override
  String get wisdom_title => 'Sabiduría para Hoy';

  @override
  String get wisdom_dismissed =>
      'La sabiduría de hoy ha sido contemplada.\nUna nueva perspectiva llegará mañana.';

  @override
  String get wisdom_loading => 'Cargando sabiduría...';

  @override
  String get leaderboard_allTime => 'Historial';

  @override
  String get leaderboard_thisWeek => 'Esta Semana';

  @override
  String get leaderboard_yourProgress => 'Tu Progreso';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count cantos para superar a $playerName';
  }

  @override
  String get leaderboard_empty => '¡El viaje comienza!';

  @override
  String get leaderboard_emptySubtitle =>
      '¡Sé el primero en aparecer en la clasificación!';

  @override
  String get leaderboard_isEmpty => 'La clasificación está vacía.';

  @override
  String get leaderboard_noBade => 'Aún no hay insignias';

  @override
  String get leaderboard_notOnBoard =>
      '¡Sigue cantando para entrar en la clasificación!';

  @override
  String get leaderboard_topOfBoard => '¡Estás en la cima! ✨';

  @override
  String get leaderboard_noChants => 'Aún no hay cantos';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'Mantra Principal: $mantra';
  }

  @override
  String get profile_yourProgress => 'Tu Progreso';

  @override
  String get profile_dailyStreak => 'Racha Diaria';

  @override
  String get profile_totalJapps => 'Cantos Totales';

  @override
  String get profile_globalRank => 'Rango Global';

  @override
  String get profile_mantraTotals => 'Totales de Mantras';

  @override
  String get profile_achievements => 'Logros';

  @override
  String get profile_shareProgress => 'Comparte Tu Progreso';

  @override
  String get profile_badgesEmpty =>
      '¡Empieza a cantar para ganar tu primera insignia!';

  @override
  String get profile_mantrasEmpty =>
      '¡Empieza a cantar para ver tus totales aquí!';

  @override
  String get profile_shareApp => 'Compartir Naam Jaap';

  @override
  String get profile_rateApp => 'Valora nuestra aplicación';

  @override
  String get profile_supportTitle => 'Apoya a Naam Jaap';

  @override
  String get profile_supportSubtitle =>
      'Ayuda a mantener la aplicación en funcionamiento';

  @override
  String get profile_myBodhi => 'Mi Árbol Bodhi';

  @override
  String get profile_myBodhiSubtitle => 'Un testamento visual de tu devoción.';

  @override
  String get profile_yourAchievement => 'Tus Logros';

  @override
  String get profile_yourAchievements => 'Tus Logros';

  @override
  String get profile_aMark => 'Una marca de tu dedicación.';

  @override
  String get profile_changeName => 'Cambiar tu nombre';

  @override
  String get profile_enterName => 'Introduce nuevo Nombre';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get settings_ambiance => 'Ambiente de Templo';

  @override
  String get settings_ambianceDesc =>
      'Reproducir sutiles sonidos de templo de fondo.';

  @override
  String get settings_reminders => 'Recordatorios Diarios';

  @override
  String get settings_remindersDesc =>
      'Recibe una notificación si no has cantado hoy.';

  @override
  String get settings_language => 'Idioma de la App';

  @override
  String get settings_feedback => 'Comentarios y Soporte';

  @override
  String get settings_feedbackDesc => 'Informa un error o sugiere una función.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'Política de Privacidad';

  @override
  String get settings_terms => 'Términos y Condiciones';

  @override
  String get settings_deleteAccount => 'Eliminar Mi Cuenta';

  @override
  String get settings_signOut => 'Cerrar Sesión';

  @override
  String get dialog_deleteTitle => '¿Eliminar Cuenta?';

  @override
  String get dialog_deleteBody =>
      'Esta acción es permanente y no se puede deshacer. Todos tus datos de cantos, logros e información personal serán borrados permanentemente.\n\n¿Estás absolutamente seguro de que quieres continuar?';

  @override
  String get dialog_deleteConfirm => 'Sí, Eliminar Mi Cuenta';

  @override
  String get dialog_continue => 'Continuar';

  @override
  String get dialog_pressBack => 'Presiona atrás de nuevo para salir';

  @override
  String get dialog_update => 'Actualización Requerida';

  @override
  String get dialog_updateDesc =>
      'Una nueva versión de Naam Jaap está disponible con actualizaciones importantes. Por favor, actualiza la aplicación para continuar.';

  @override
  String get dialog_updateNow => 'Actualizar ahora';

  @override
  String get dialog_save => 'Guardar';

  @override
  String get dialog_something => 'Algo salió mal.';

  @override
  String get dialog_cancel => 'Cancelar';

  @override
  String get misc_japps => 'cantos';

  @override
  String get misc_days => 'Días';

  @override
  String get misc_badge => 'Insignias';

  @override
  String get lang_chooseLang => 'Elige tu idioma preferido para continuar';

  @override
  String get lang_searchLang => 'Buscar idiomas';

  @override
  String get garden_totalMala => 'Malas Completados';

  @override
  String get misc_malas => 'Malas';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count malas para superar a $playerName';
  }

  @override
  String get dialog_mic =>
      'Se requiere permiso del micrófono para grabar audio.';

  @override
  String get custom_create => 'Crea tu Mantra';

  @override
  String get custom_yourMantra => 'Nombre del Mantra';

  @override
  String get custom_hint => 'ej., Om Gurave Namah';

  @override
  String get custom_back => 'Elige un fondo:';

  @override
  String get custom_addVoice => 'Añade tu voz (Opcional):';

  @override
  String get custom_recording => 'Grabando...';

  @override
  String get custom_tapToRecord => 'Toca el micrófono para grabar';

  @override
  String get custom_saveMantra => 'Guardar Mantra';

  @override
  String get custom_micAccess =>
      'Se requiere permiso del micrófono para grabar audio.';

  @override
  String get profile_yourCustomMantra => 'Mis Mantras Personalizados';

  @override
  String get profile_noCustoms =>
      'Aún no has añadido ningún mantra personalizado.';

  @override
  String get profile_addNewMantra => 'Añadir Nuevo Mantra';

  @override
  String get dialog_profilePictureUpdate => '¡Foto de perfil actualizada!';

  @override
  String get dialog_failedToUpload => 'Error al subir la imagen.';

  @override
  String get dialog_exceptionCard =>
      'El contexto de la tarjeta compartible no está disponible.';

  @override
  String get dialog_checkoutMyProgress =>
      '¡Mira mi progreso en la app NaamJaap!';

  @override
  String get dialog_couldNotOpenPS => 'No se pudo abrir Play Store.';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '¿Eliminar \"$mantraName\"?';
  }

  @override
  String get profile_deleteMantraSure =>
      '¿Estás seguro? Todos los recuentos de japa asociados con este mantra también se eliminarán permanentemente.';

  @override
  String get profile_yesDelete => 'Sí, Eliminar';

  @override
  String get profile_couldNotUserData =>
      'No se pudieron cargar los datos del usuario.';

  @override
  String get misc_anonymous => 'Anónimo';

  @override
  String get profile_sankalpaSet => 'Haz un Voto Sagrado';

  @override
  String get profile_sankalpaSubtitle =>
      'Establece una meta personal de canto.';

  @override
  String get profile_sankalpaTitle => 'Tu Sankalpa de Japa';

  @override
  String get profile_sankalpaChanting => 'Cantando';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' para alcanzar $targetCount veces.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'Para el $date';
  }

  @override
  String get dialog_sankalpaTitle => 'Establece tu Sankalpa de Japa';

  @override
  String get dialog_sankalpaSelectMantra => 'Seleccionar Mantra';

  @override
  String get dialog_sankalpaTargetCount => 'Conteo Objetivo (ej., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Fecha Objetivo';

  @override
  String get dialog_sankalpaSelectDate => 'Selecciona una fecha';

  @override
  String get dialog_sankalpaSetPledge => 'Establecer mi Voto';

  @override
  String get dialog_sankalpaError =>
      'Por favor, completa todos los campos correctamente.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'El conteo objetivo debe ser mayor que tu conteo actual.';
}
