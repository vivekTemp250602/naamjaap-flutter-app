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
  String get login_subtitle => 'Tu compañero digital de cánticos.';

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
  String get home_chooseMala => 'Elige tu Mala';

  @override
  String get home_chooseMalaDesc =>
      'Selecciona un estilo que resuene con tu espíritu.';

  @override
  String get home_customizeMala => 'Personalizar Mala';

  @override
  String get tour_home_carousel_title => 'Elige tu Mantra';

  @override
  String get tour_home_carousel_desc =>
      'Desliza para cambiar entre poderosos mantras védicos.';

  @override
  String get tour_home_mala_title => 'Toca para Cantar';

  @override
  String get tour_home_mala_desc =>
      'Toca en cualquier lugar del círculo para mover las cuentas. Completa 108 para un Mala.';

  @override
  String get tour_home_toolkit_title => 'Tu Kit de Herramientas';

  @override
  String get tour_home_toolkit_desc =>
      'Personaliza cuentas, alterna audio o ve significados de mantras.';

  @override
  String get tour_leader_toggle_title => 'Semanal vs Histórico';

  @override
  String get tour_leader_toggle_desc =>
      'Toca aquí para cambiar entre los líderes de esta semana y las leyendas de siempre.';

  @override
  String get tour_leader_podium_title => 'Los 3 Mejores';

  @override
  String get tour_leader_podium_desc =>
      'Los cantantes más dedicados aparecen aquí. ¡Sigue cantando para unirte a ellos!';

  @override
  String get tour_wisdom_card_title => 'Sabiduría Diaria y Compartir';

  @override
  String get tour_wisdom_card_desc =>
      'Comienza tu día con un nuevo Shloka. ¡Toca el icono de compartir para crear una imagen para tu estado!';

  @override
  String get tour_profile_stats_title => 'Tus Estadísticas Espirituales';

  @override
  String get tour_profile_stats_desc =>
      'Rastrea tu racha, conteo total de Japa y rango global aquí.';

  @override
  String get tour_profile_offline_title => '¿Canto Físico?';

  @override
  String get tour_profile_offline_desc =>
      'Si usas un Mala físico, toca aquí para agregar manualmente tus conteos.';

  @override
  String get tour_profile_bodhi_desc =>
      'Cada Mala que cantas ayuda a crecer tu jardín espiritual. ¡Desbloquea nuevos árboles mientras progresas!';

  @override
  String get tour_profile_sankalpa_desc =>
      'Establece una fecha y conteo objetivo para comprometerte con una meta espiritual. Te ayudaremos a rastrearlo.';

  @override
  String get guest_mode_title => 'Modo Invitado';

  @override
  String get guest_mode_desc =>
      'Inicia sesión para desbloquear tu perfil espiritual.';

  @override
  String get guest_signin_btn => 'Iniciar Sesión';

  @override
  String get wisdom_title => 'Sabiduría de Hoy';

  @override
  String get wisdom_dismissed =>
      'La sabiduría de hoy ha sido contemplada.\nUna nueva percepción llegará mañana.';

  @override
  String get wisdom_loading => 'Cargando sabiduría...';

  @override
  String get wisdom_signin_to_share =>
      '¡Inicia sesión para compartir tarjetas!';

  @override
  String get wisdom_creating_card => 'Creando tu tarjeta divina...';

  @override
  String get leaderboard_allTime => 'Histórico';

  @override
  String get leaderboard_thisWeek => 'Esta Semana';

  @override
  String get leaderboard_yourProgress => 'Tu Progreso';

  @override
  String get leaderboard_yourRank => 'Tu Rango';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count japps para superar a $playerName';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count malas para superar a $playerName';
  }

  @override
  String get leaderboard_empty => '¡El viaje comienza!';

  @override
  String get leaderboard_emptySubtitle =>
      '¡Sé el primero en honrar la clasificación!';

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
  String leaderboard_topMantra(String mantra) {
    return 'Mantra Top: $mantra';
  }

  @override
  String get profile_yourProgress => 'Tu Progreso';

  @override
  String get profile_dailyStreak => 'Racha Diaria';

  @override
  String get profile_totalJapps => 'Total Japps';

  @override
  String get profile_globalRank => 'Rango Global';

  @override
  String get profile_mantraTotals => 'Totales de Mantra';

  @override
  String get profile_achievements => 'Logros';

  @override
  String get profile_shareProgress => 'Compartir Progreso';

  @override
  String get profile_badgesEmpty =>
      '¡Empieza a cantar para ganar tu primera insignia!';

  @override
  String get profile_mantrasEmpty =>
      '¡Empieza a cantar para ver tus totales aquí!';

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
  String get profile_shareApp => 'Compartir Naam Jaap';

  @override
  String get profile_yourCustomMantra => 'Mis Mantras Personalizados';

  @override
  String get profile_noCustoms =>
      'Aún no has añadido ningún mantra personalizado.';

  @override
  String get profile_addNewMantra => 'Añadir Nuevo Mantra';

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
  String get profile_offline_card_title => 'Registrar Japa Offline';

  @override
  String get profile_offline_card_subtitle =>
      'Añadir conteos de tu mala físico';

  @override
  String get profile_gamification_header => 'Gamificación';

  @override
  String get profile_commitments_header => 'Compromisos';

  @override
  String get profile_insights_header => 'Perspectivas del Mantra';

  @override
  String get profile_my_mantras_header => 'Mis Mantras';

  @override
  String get profile_quick_actions_header => 'Acciones Rápidas';

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
  String get profile_abandon => 'Abandonar Voto';

  @override
  String get profile_progress => 'PROGRESO';

  @override
  String get profile_deadline => 'FECHA LÍMITE';

  @override
  String get profile_achieved => '¡Logrado!';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' para alcanzar $targetCount veces.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'Para el $date';
  }

  @override
  String get settings_title => 'Configuración';

  @override
  String get settings_ambiance => 'Ambiente de Templo';

  @override
  String get settings_ambianceDesc => 'Reproducir sonidos sutiles de templo.';

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
  String get settings_feedbackDesc =>
      'Reportar un error o sugerir una función.';

  @override
  String get settings_deletingAccount => 'Eliminando tu cuenta...';

  @override
  String get settings_privacy => 'Política de Privacidad';

  @override
  String get settings_terms => 'Términos y Condiciones';

  @override
  String get settings_deleteAccount => 'Eliminar Mi Cuenta';

  @override
  String get settings_signOut => 'Cerrar Sesión';

  @override
  String get settings_exit_guest => 'Salir del Modo Invitado';

  @override
  String get settings_support_header => 'Soporte y Legal';

  @override
  String get settings_account_header => 'Cuenta';

  @override
  String get support_title => 'Apoya el proyecto Naam Jaap';

  @override
  String get support_desc =>
      'Naam Jaap es un trabajo hecho con amor, creado por un solo desarrollador. Tu contribución desinteresada (Seva) ayuda a mantener los servidores en funcionamiento, los anuncios al mínimo y la aplicación gratuita para todos los devotos.';

  @override
  String get support_afterTitile =>
      'Gracias por apoyar a Naam Jaap — cada contribución ayuda.';

  @override
  String get support_openUPI => 'Abriendo tu aplicación UPI...';

  @override
  String get support_cannotOpenUPI => 'No se pudo iniciar la aplicación UPI.';

  @override
  String get support_upiError =>
      'Error: No se pudo encontrar una aplicación UPI para abrir.';

  @override
  String get support_chooseOffering => 'ELIGE UNA OFRENDA';

  @override
  String get support_enterAmt => 'O introduce una cantidad personalizada (INR)';

  @override
  String get support_validAmt =>
      'Por favor, selecciona o introduce una cantidad válida.';

  @override
  String get support_now => 'Apoyar ahora';

  @override
  String get support_donate => 'Donar';

  @override
  String get support_paymentSucc =>
      'Pagos procesados de forma segura por Razorpay';

  @override
  String get support_thank => '🙏 Gracias';

  @override
  String get support_offer_seva => 'Ofrecer Seva';

  @override
  String get support_signin_required =>
      'Por favor, inicia sesión para contribuir.';

  @override
  String get support_payment_error =>
      'No se pudo iniciar el pago. Inténtalo de nuevo.';

  @override
  String get support_blessed => 'Que seas bendecido.';

  @override
  String get support_tier_flower => 'Ofrenda de Flores';

  @override
  String get support_tier_lamp => 'Encendido de Lámpara';

  @override
  String get support_tier_garland => 'Seva de Guirnalda';

  @override
  String get support_tier_temple => 'Apoyo al Templo';

  @override
  String get support_tier_grand => 'Gran Ofrenda';

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
  String get custom_preview => 'VISTA PREVIA';

  @override
  String get custom_voice_saved => 'Nota de voz guardada';

  @override
  String get custom_tap_record => 'Toca para Grabar';

  @override
  String get custom_ready_use => 'Listo para usar';

  @override
  String get custom_error_empty_name =>
      'Por favor ingresa un nombre para el mantra';

  @override
  String get garden_title => 'Jardín Bodhi';

  @override
  String get garden_subtitle => 'Haz crecer tu bosque espiritual';

  @override
  String get garden_growth => 'Crecimiento Espiritual';

  @override
  String get garden_totalMala => 'Malas Completados';

  @override
  String get dialog_deleteTitle => '¿Eliminar Cuenta?';

  @override
  String get dialog_deleteBody =>
      'Esta acción es permanente y no se puede deshacer. Todos tus datos de canto, logros e información personal se borrarán permanentemente.\n\n¿Estás absolutamente seguro de que quieres proceder?';

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
  String get dialog_close => 'Cerrar';

  @override
  String get dialog_something => 'Algo salió mal.';

  @override
  String get dialog_cancel => 'Cancelar';

  @override
  String get dialog_profilePictureUpdate => '¡Foto de perfil actualizada!';

  @override
  String get dialog_failedToUpload => 'Error al subir la imagen.';

  @override
  String get dialog_exceptionCard =>
      'El contexto de la tarjeta compartible no está disponible.';

  @override
  String get dialog_couldNotOpenPS => 'No se pudo abrir Play Store.';

  @override
  String get dialog_mic =>
      'Se requiere permiso del micrófono para grabar audio.';

  @override
  String get dialog_getStarted => 'Comenzar';

  @override
  String get dialog_next => 'Siguiente';

  @override
  String get dialog_skip => 'Omitir';

  @override
  String get dialog_checkoutMyProgress =>
      '¡Mira mi progreso en la app Naam Jaap!';

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

  @override
  String get misc_japps => 'japps';

  @override
  String get misc_days => 'Días';

  @override
  String get misc_badge => 'Insignias';

  @override
  String get misc_malas => 'Malas';

  @override
  String get misc_anonymous => 'Anónimo';

  @override
  String get lang_chooseLang => 'Elige tu idioma preferido para continuar';

  @override
  String get lang_searchLang => 'Buscar idiomas';

  @override
  String get malatype_regular => 'Regular';

  @override
  String get malatype_crystal => 'Cristal';

  @override
  String get malatype_royal => 'Oro Real';
}
