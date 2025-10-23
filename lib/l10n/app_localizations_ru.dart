// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Добро пожаловать в Naam Jaap';

  @override
  String get login_subtitle => 'Ваш личный цифровой спутник для песнопений.';

  @override
  String get login_termsAgreement => 'Я прочитал(а) и согласен(на) с ';

  @override
  String get login_termsAndConditions => 'Условиями использования';

  @override
  String get login_and => ' и ';

  @override
  String get login_privacyPolicy => 'Политикой конфиденциальности';

  @override
  String get login_signInWithGoogle => 'Войти через Google';

  @override
  String get nav_home => 'Главная';

  @override
  String get nav_leaderboard => 'Список лидеров';

  @override
  String get nav_wisdom => 'Мудрость';

  @override
  String get nav_profile => 'Мой профиль';

  @override
  String get home_tapToChant => 'Нажмите, чтобы петь';

  @override
  String get home_dayStreak => 'Дней подряд';

  @override
  String get home_total => 'Всего:';

  @override
  String get home_mantraInfo => 'Инфо о мантре';

  @override
  String get dialog_close => 'Закрыть';

  @override
  String get wisdom_title => 'Мудрость дня';

  @override
  String get wisdom_dismissed =>
      'Сегодняшняя мудрость была обдумана.\nНовое озарение придет завтра.';

  @override
  String get wisdom_loading => 'Загрузка мудрости...';

  @override
  String get leaderboard_allTime => 'За все время';

  @override
  String get leaderboard_thisWeek => 'На этой неделе';

  @override
  String get leaderboard_yourProgress => 'Ваш прогресс';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count повторений, чтобы обойти $playerName';
  }

  @override
  String get leaderboard_empty => 'Путешествие начинается!';

  @override
  String get leaderboard_emptySubtitle => 'Станьте первым в списке лидеров!';

  @override
  String get leaderboard_isEmpty => 'Список лидеров пуст.';

  @override
  String get leaderboard_noBade => 'Пока нет значков';

  @override
  String get leaderboard_notOnBoard =>
      'Продолжайте петь, чтобы попасть в список!';

  @override
  String get leaderboard_topOfBoard => 'Вы на вершине! ✨';

  @override
  String get leaderboard_noChants => 'Пока нет песнопений';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'Топ мантра: $mantra';
  }

  @override
  String get profile_yourProgress => 'Ваш прогресс';

  @override
  String get profile_dailyStreak => 'Ежедневная серия';

  @override
  String get profile_totalJapps => 'Всего повторений';

  @override
  String get profile_globalRank => 'Мировой рейтинг';

  @override
  String get profile_mantraTotals => 'Итоги по мантрам';

  @override
  String get profile_achievements => 'Достижения';

  @override
  String get profile_shareProgress => 'Поделиться прогрессом';

  @override
  String get profile_badgesEmpty =>
      'Начните петь, чтобы заработать свой первый значок!';

  @override
  String get profile_mantrasEmpty =>
      'Начните петь, чтобы увидеть здесь свои итоги!';

  @override
  String get profile_shareApp => 'Поделиться Naam Jaap';

  @override
  String get profile_rateApp => 'Оцените наше приложение';

  @override
  String get profile_supportTitle => 'Поддержать Naam Jaap';

  @override
  String get profile_supportSubtitle =>
      'Помогите поддерживать работу приложения';

  @override
  String get profile_myBodhi => 'Мое Дерево Бодхи';

  @override
  String get profile_myBodhiSubtitle =>
      'Визуальное свидетельство вашей преданности.';

  @override
  String get profile_yourAchievement => 'Ваши достижения';

  @override
  String get profile_yourAchievements => 'Ваши достижения';

  @override
  String get profile_aMark => 'Знак вашей преданности.';

  @override
  String get profile_changeName => 'Изменить ваше имя';

  @override
  String get profile_enterName => 'Введите новое Имя';

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_ambiance => 'Атмосфера храма';

  @override
  String get settings_ambianceDesc => 'Включить тихие фоновые звуки храма.';

  @override
  String get settings_reminders => 'Ежедневные напоминания';

  @override
  String get settings_remindersDesc =>
      'Получать уведомление, если вы еще не пели сегодня.';

  @override
  String get settings_language => 'Язык приложения';

  @override
  String get settings_feedback => 'Обратная связь и поддержка';

  @override
  String get settings_feedbackDesc =>
      'Сообщить об ошибке или предложить функцию.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'Политика конфиденциальности';

  @override
  String get settings_terms => 'Условия использования';

  @override
  String get settings_deleteAccount => 'Удалить мой аккаунт';

  @override
  String get settings_signOut => 'Выйти';

  @override
  String get dialog_deleteTitle => 'Удалить аккаунт?';

  @override
  String get dialog_deleteBody =>
      'Это действие необратимо. Все ваши данные о песнопениях, достижения и личная информация будут удалены навсегда.\n\nВы абсолютно уверены, что хотите продолжить?';

  @override
  String get dialog_deleteConfirm => 'Да, удалить мой аккаунт';

  @override
  String get dialog_continue => 'Продолжить';

  @override
  String get dialog_pressBack => 'Нажмите назад еще раз для выхода';

  @override
  String get dialog_update => 'Требуется обновление';

  @override
  String get dialog_updateDesc =>
      'Доступна новая версия Naam Jaap с важными обновлениями. Пожалуйста, обновите приложение для продолжения.';

  @override
  String get dialog_updateNow => 'Обновить сейчас';

  @override
  String get dialog_save => 'Сохранить';

  @override
  String get dialog_something => 'Что-то пошло не так.';

  @override
  String get dialog_cancel => 'Отмена';

  @override
  String get misc_japps => 'повторений';

  @override
  String get misc_days => 'Дней';

  @override
  String get misc_badge => 'Значки';

  @override
  String get lang_chooseLang => 'Выберите предпочитаемый язык для продолжения';

  @override
  String get lang_searchLang => 'Поиск языков';

  @override
  String get garden_totalMala => 'Завершенные Малы';
}
