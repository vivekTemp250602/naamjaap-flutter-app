// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
  String get profile_rateApp => 'Оцените наше приложение';

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

  @override
  String get misc_malas => 'Малы';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$count мал, чтобы обойти $playerName';
  }

  @override
  String get dialog_mic =>
      'Требуется разрешение на использование микрофона для записи аудио.';

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
  String get profile_yourCustomMantra => 'Мои пользовательские Мантры';

  @override
  String get profile_noCustoms =>
      'Вы еще не добавили ни одной пользовательской мантры.';

  @override
  String get profile_addNewMantra => 'Добавить новую Мантру';

  @override
  String get dialog_profilePictureUpdate => 'Изображение профиля обновлено!';

  @override
  String get dialog_failedToUpload => 'Не удалось загрузить изображение.';

  @override
  String get dialog_exceptionCard => 'Контекст карточки для обмена недоступен.';

  @override
  String get dialog_checkoutMyProgress =>
      'Посмотрите мой прогресс в приложении NaamJaap!';

  @override
  String get dialog_couldNotOpenPS => 'Не удалось открыть Play Store.';

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
  String get misc_anonymous => 'Анонимный';

  @override
  String get profile_sankalpaSet => 'Дайте Священный Обет';

  @override
  String get profile_sankalpaSubtitle => 'Установите личную цель песнопения.';

  @override
  String get profile_sankalpaTitle => 'Ваша Джапа Санкальпа';

  @override
  String get profile_sankalpaChanting => 'Пение';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' чтобы достичь $targetCount раз.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'К $date';
  }

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
  String get home_chooseMala => '말라 선택하기';

  @override
  String get home_chooseMalaDesc => '당신의 영혼과 공명하는 스타일을 선택하세요.';

  @override
  String get tour_title1 => '디지털 자파 말라';

  @override
  String get tour_body1 => '탭하여 챈팅하세요. 구슬 수를 세고, 말라를 추적하며, 연속 기록을 자동으로 유지합니다.';

  @override
  String get tour_title2 => '글로벌 리더보드';

  @override
  String get tour_body2 => '수천 명과 함께 챈팅하세요. 영적인 발전과 꾸준함을 통해 성장하세요.';

  @override
  String get tour_title3 => '오늘의 지혜';

  @override
  String get tour_body3 => '고대 문헌에서 엄선된 구절을 받아보세요 — 다국어로 제공됩니다.';

  @override
  String get tour_title4 => '당신의 영적 여정';

  @override
  String get tour_body4 => '이정표를 추적하고, 산칼파를 설정하며, 당신의 성장과 성취를 되돌아보세요.';

  @override
  String get dialog_getStarted => '시작하기';

  @override
  String get dialog_next => '다음';

  @override
  String get dialog_skip => '건너뛰기';

  @override
  String get malatype_regular => '일반';

  @override
  String get malatype_crystal => '크리스탈';

  @override
  String get malatype_royal => '로열 골드';

  @override
  String get profile_abandon => '서원 포기';

  @override
  String get profile_progress => '진행 상황';

  @override
  String get profile_deadline => '마감일';

  @override
  String get profile_achieved => '달성!';

  @override
  String get support_donate => '기부하기';

  @override
  String get support_paymentSucc => 'Razorpay에 의해 안전하게 처리된 결제';

  @override
  String get support_thank => '🙏 감사합니다';

  @override
  String get home_customizeMala => 'Настроить Малу';

  @override
  String get appTitle => 'Moksha Mala Jaap';

  @override
  String get login_welcome => 'Добро пожаловать в Moksha Mala Jaap';

  @override
  String get profile_shareApp => 'Поделиться Moksha Mala Jaap';

  @override
  String get profile_supportTitle => 'Поддержать Moksha Mala Jaap';

  @override
  String get dialog_updateDesc =>
      'Доступна новая версия Moksha Mala Jaap с важными обновлениями. Пожалуйста, обновите приложение для продолжения.';

  @override
  String get support_desc =>
      'Moksha Mala Jaap — это труд любви, созданный одним разработчиком. Ваш бескорыстный вклад (Сева) помогает поддерживать работу серверов, минимизировать рекламу и делать приложение бесплатным для всех преданных.';

  @override
  String get support_title => 'Поддержите проект Moksha Mala Jaap';

  @override
  String get support_afterTitile =>
      'Спасибо за поддержку Moksha Mala Jaap — каждый вклад помогает.';
}
