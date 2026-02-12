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
  String get login_termsAgreement => 'Я прочитал и согласен с ';

  @override
  String get login_termsAndConditions => 'Условиями и Положениями';

  @override
  String get login_and => ' и ';

  @override
  String get login_privacyPolicy => 'Политикой Конфиденциальности';

  @override
  String get login_signInWithGoogle => 'Войти через Google';

  @override
  String get nav_home => 'Главная';

  @override
  String get nav_leaderboard => 'Лидеры';

  @override
  String get nav_wisdom => 'Мудрость';

  @override
  String get nav_profile => 'Профиль';

  @override
  String get home_tapToChant => 'Нажмите, чтобы петь';

  @override
  String get home_dayStreak => 'Дневная серия';

  @override
  String get home_total => 'Всего:';

  @override
  String get home_mantraInfo => 'Инфо о Мантре';

  @override
  String get home_chooseMala => 'Выберите свою Малу';

  @override
  String get home_chooseMalaDesc =>
      'Выберите стиль, который резонирует с вашим духом.';

  @override
  String get home_customizeMala => 'Настроить Малу';

  @override
  String get tour_home_carousel_title => 'Выберите вашу Мантру';

  @override
  String get tour_home_carousel_desc =>
      'Свайпните, чтобы переключиться между мощными ведическими мантрами.';

  @override
  String get tour_home_mala_title => 'Нажмите, чтобы петь';

  @override
  String get tour_home_mala_desc =>
      'Нажмите в любом месте круга, чтобы двигать бусины. Завершите 108 для одной Малы.';

  @override
  String get tour_home_toolkit_title => 'Ваш Инструментарий';

  @override
  String get tour_home_toolkit_desc =>
      'Настройте стиль бусин, переключите аудио или посмотрите значения.';

  @override
  String get tour_leader_toggle_title => 'Неделя vs Все время';

  @override
  String get tour_leader_toggle_desc =>
      'Нажмите здесь, чтобы переключиться между лидерами недели и легендами всех времен.';

  @override
  String get tour_leader_podium_title => 'Топ 3';

  @override
  String get tour_leader_podium_desc =>
      'Здесь появляются самые преданные певцы. Продолжайте петь, чтобы присоединиться к ним!';

  @override
  String get tour_wisdom_card_title => 'Мудрость Дня и Поделиться';

  @override
  String get tour_wisdom_card_desc =>
      'Начните свой день с новой Шлоки. Нажмите иконку поделиться, чтобы создать картинку!';

  @override
  String get tour_profile_stats_title => 'Ваша Духовная Статистика';

  @override
  String get tour_profile_stats_desc =>
      'Отслеживайте свою серию, общий счет Джапы и глобальный ранг здесь.';

  @override
  String get tour_profile_offline_title => 'Физическое пение?';

  @override
  String get tour_profile_offline_desc =>
      'Если вы используете настоящую Малу, нажмите здесь, чтобы вручную добавить свои счеты.';

  @override
  String get tour_profile_bodhi_desc =>
      'Каждая Мала, которую вы поете, помогает вашему духовному саду расти. Открывайте новые деревья!';

  @override
  String get tour_profile_sankalpa_desc =>
      'Установите целевую дату и количество, чтобы взять на себя обязательство.';

  @override
  String get guest_mode_title => 'Гостевой режим';

  @override
  String get guest_mode_desc =>
      'Войдите, чтобы разблокировать свой духовный профиль.';

  @override
  String get guest_signin_btn => 'Войти';

  @override
  String get wisdom_title => 'Мудрость на Сегодня';

  @override
  String get wisdom_dismissed =>
      'Сегодняшняя мудрость была обдумана.\nНовое озарение придет завтра.';

  @override
  String get wisdom_loading => 'Загрузка мудрости...';

  @override
  String get wisdom_signin_to_share => 'Войдите, чтобы делиться карточками!';

  @override
  String get wisdom_creating_card => 'Создание вашей божественной карты...';

  @override
  String get leaderboard_allTime => 'Все время';

  @override
  String get leaderboard_thisWeek => 'Эта Неделя';

  @override
  String get leaderboard_yourProgress => 'Ваш Прогресс';

  @override
  String get leaderboard_yourRank => 'Ваш Ранг';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$count джап, чтобы обойти $playerName';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count мал, чтобы обойти $playerName';
  }

  @override
  String get leaderboard_empty => 'Путешествие начинается!';

  @override
  String get leaderboard_emptySubtitle =>
      'Станьте первым, кто украсит список лидеров!';

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
  String leaderboard_topMantra(String mantra) {
    return 'Топ Мантра: $mantra';
  }

  @override
  String get profile_yourProgress => 'Ваш Прогресс';

  @override
  String get profile_dailyStreak => 'Дневная Серия';

  @override
  String get profile_totalJapps => 'Всего Джап';

  @override
  String get profile_globalRank => 'Глобальный Ранг';

  @override
  String get profile_mantraTotals => 'Итоги по Мантрам';

  @override
  String get profile_achievements => 'Достижения';

  @override
  String get profile_shareProgress => 'Поделиться Прогрессом';

  @override
  String get profile_badgesEmpty =>
      'Начните петь, чтобы заработать свой первый значок!';

  @override
  String get profile_mantrasEmpty =>
      'Начните петь, чтобы увидеть свои итоги здесь!';

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
  String get profile_shareApp => 'Поделиться Naam Jaap';

  @override
  String get profile_yourCustomMantra => 'Мои пользовательские Мантры';

  @override
  String get profile_noCustoms =>
      'Вы еще не добавили ни одной пользовательской мантры.';

  @override
  String get profile_addNewMantra => 'Добавить новую Мантру';

  @override
  String profile_deleteMantra(Object mantraName) {
    return 'Удалить \"$mantraName\"?';
  }

  @override
  String get profile_deleteMantraSure =>
      'Вы уверены? Все счетчики джапы, связанные с этой мантрой, также будут навсегда удалены.';

  @override
  String get profile_yesDelete => 'Да, Удалить';

  @override
  String get profile_couldNotUserData =>
      'Не удалось загрузить данные пользователя.';

  @override
  String get profile_offline_card_title => 'Записать оффлайн Джапу';

  @override
  String get profile_offline_card_subtitle =>
      'Добавить счеты с вашей физической малы';

  @override
  String get profile_gamification_header => 'Геймификация';

  @override
  String get profile_commitments_header => 'Обязательства';

  @override
  String get profile_insights_header => 'Инсайты Мантры';

  @override
  String get profile_my_mantras_header => 'Мои Мантры';

  @override
  String get profile_quick_actions_header => 'Быстрые Действия';

  @override
  String get profile_sankalpaSet => 'Дайте Священный Обет';

  @override
  String get profile_sankalpaSubtitle => 'Установите личную цель песнопения.';

  @override
  String get profile_sankalpaTitle => 'Ваша Джапа Санкальпа';

  @override
  String get profile_sankalpaChanting => 'Пение';

  @override
  String get profile_abandon => 'Отказ от Обета';

  @override
  String get profile_progress => 'ПРОГРЕСС';

  @override
  String get profile_deadline => 'СРОК';

  @override
  String get profile_achieved => 'Достигнуто!';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' чтобы достичь $targetCount раз.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'К $date';
  }

  @override
  String get settings_title => 'Настройки';

  @override
  String get settings_ambiance => 'Атмосфера Храма';

  @override
  String get settings_ambianceDesc => 'Играть тонкие звуки храма.';

  @override
  String get settings_reminders => 'Ежедневные Напоминания';

  @override
  String get settings_remindersDesc =>
      'Получать уведомление, если вы сегодня не пели.';

  @override
  String get settings_language => 'Язык Приложения';

  @override
  String get settings_feedback => 'Отзывы и Поддержка';

  @override
  String get settings_feedbackDesc =>
      'Сообщить об ошибке или предложить функцию.';

  @override
  String get settings_deletingAccount => 'Удаление вашего аккаунта...';

  @override
  String get settings_privacy => 'Политика Конфиденциальности';

  @override
  String get settings_terms => 'Условия и Положения';

  @override
  String get settings_deleteAccount => 'Удалить Мой Аккаунт';

  @override
  String get settings_signOut => 'Выйти';

  @override
  String get settings_exit_guest => 'Выйти из гостевого режима';

  @override
  String get settings_support_header => 'Поддержка и Юридическая информация';

  @override
  String get settings_account_header => 'Аккаунт';

  @override
  String get support_title => 'Поддержите проект Naam Jaap';

  @override
  String get support_desc =>
      'Naam Jaap — это труд любви, созданный одним разработчиком. Ваш бескорыстный вклад (Сева) помогает поддерживать работу серверов, минимизировать рекламу и делать приложение бесплатным для всех преданных.';

  @override
  String get support_afterTitile =>
      'Спасибо за поддержку Naam Jaap — каждый вклад помогает.';

  @override
  String get support_openUPI => 'Открываем ваше приложение UPI...';

  @override
  String get support_cannotOpenUPI => 'Не удалось запустить приложение UPI.';

  @override
  String get support_upiError =>
      'Ошибка: Не удалось найти приложение UPI для открытия.';

  @override
  String get support_chooseOffering => 'ВЫБЕРИТЕ ПОДНОШЕНИЕ';

  @override
  String get support_enterAmt => 'Или введите свою сумму (INR)';

  @override
  String get support_validAmt =>
      'Пожалуйста, выберите или введите действительную сумму.';

  @override
  String get support_now => 'Поддержать сейчас';

  @override
  String get support_donate => 'Пожертвовать';

  @override
  String get support_paymentSucc => 'Платежи безопасно обрабатываются Razorpay';

  @override
  String get support_thank => '🙏 Спасибо';

  @override
  String get support_offer_seva => 'Предложить Севу';

  @override
  String get support_signin_required =>
      'Пожалуйста, войдите, чтобы сделать вклад.';

  @override
  String get support_payment_error =>
      'Не удалось начать платеж. Пожалуйста, попробуйте снова.';

  @override
  String get support_blessed => 'Да благословит вас Бог.';

  @override
  String get support_tier_flower => 'Подношение Цветов';

  @override
  String get support_tier_lamp => 'Зажжение Лампы';

  @override
  String get support_tier_garland => 'Сева Гирлянды';

  @override
  String get support_tier_temple => 'Поддержка Храма';

  @override
  String get support_tier_grand => 'Великое Подношение';

  @override
  String get custom_create => 'Создайте свою Мантру';

  @override
  String get custom_yourMantra => 'Название Мантры';

  @override
  String get custom_hint => 'например, Om Gurave Namah';

  @override
  String get custom_back => 'Выберите фон:';

  @override
  String get custom_addVoice => 'Добавьте свой голос (Необязательно):';

  @override
  String get custom_recording => 'Запись...';

  @override
  String get custom_tapToRecord => 'Нажмите на микрофон для записи';

  @override
  String get custom_saveMantra => 'Сохранить Мантру';

  @override
  String get custom_micAccess =>
      'Требуется разрешение на использование микрофона для записи аудио.';

  @override
  String get custom_preview => 'ПРЕДПРОСМОТР';

  @override
  String get custom_voice_saved => 'Голосовая заметка сохранена';

  @override
  String get custom_tap_record => 'Нажмите для Записи';

  @override
  String get custom_ready_use => 'Готово к использованию';

  @override
  String get custom_error_empty_name => 'Пожалуйста, введите название мантры';

  @override
  String get garden_title => 'Сад Бодхи';

  @override
  String get garden_subtitle => 'Вырастите свой духовный лес';

  @override
  String get garden_growth => 'Духовный Рост';

  @override
  String get garden_totalMala => 'Завершенные Малы';

  @override
  String get dialog_deleteTitle => 'Удалить Аккаунт?';

  @override
  String get dialog_deleteBody =>
      'Это действие необратимо. Все ваши данные о песнопениях, достижения и личная информация будут удалены навсегда.\n\nВы абсолютно уверены, что хотите продолжить?';

  @override
  String get dialog_deleteConfirm => 'Да, Удалить Мой Аккаунт';

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
  String get dialog_close => 'Закрыть';

  @override
  String get dialog_something => 'Что-то пошло не так.';

  @override
  String get dialog_cancel => 'Отмена';

  @override
  String get dialog_profilePictureUpdate => 'Изображение профиля обновлено!';

  @override
  String get dialog_failedToUpload => 'Не удалось загрузить изображение.';

  @override
  String get dialog_exceptionCard => 'Контекст карточки для обмена недоступен.';

  @override
  String get dialog_couldNotOpenPS => 'Не удалось открыть Play Store.';

  @override
  String get dialog_mic =>
      'Требуется разрешение на использование микрофона для записи аудио.';

  @override
  String get dialog_getStarted => 'Начать';

  @override
  String get dialog_next => 'Далее';

  @override
  String get dialog_skip => 'Пропустить';

  @override
  String get dialog_checkoutMyProgress =>
      'Посмотрите мой прогресс в приложении Naam Jaap!';

  @override
  String get dialog_sankalpaTitle => 'Установите свою Джапа Санкальпу';

  @override
  String get dialog_sankalpaSelectMantra => 'Выберите Мантру';

  @override
  String get dialog_sankalpaTargetCount => 'Целевое количество (напр., 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Целевая дата';

  @override
  String get dialog_sankalpaSelectDate => 'Выберите дату';

  @override
  String get dialog_sankalpaSetPledge => 'Установить мой Обет';

  @override
  String get dialog_sankalpaError =>
      'Пожалуйста, заполните все поля правильно.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'Целевое количество должно быть больше вашего текущего количества.';

  @override
  String get misc_japps => 'джап';

  @override
  String get misc_days => 'Дней';

  @override
  String get misc_badge => 'Значки';

  @override
  String get misc_malas => 'Малы';

  @override
  String get misc_anonymous => 'Анонимный';

  @override
  String get lang_chooseLang => 'Выберите предпочитаемый язык для продолжения';

  @override
  String get lang_searchLang => 'Поиск языков';

  @override
  String get malatype_regular => 'Обычный';

  @override
  String get malatype_crystal => 'Кристалл';

  @override
  String get malatype_royal => 'Королевское золото';
}
