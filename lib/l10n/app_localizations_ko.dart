// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Naam Jaap에 오신 것을 환영합니다';

  @override
  String get login_subtitle => '당신만의 디지털 만트라 챈팅 동반자.';

  @override
  String get login_termsAgreement => '저는 ';

  @override
  String get login_termsAndConditions => '이용약관';

  @override
  String get login_and => ' 및 ';

  @override
  String get login_privacyPolicy => '개인정보 처리방침에 동의합니다';

  @override
  String get login_signInWithGoogle => 'Google로 로그인';

  @override
  String get nav_home => '홈';

  @override
  String get nav_leaderboard => '리더보드';

  @override
  String get nav_wisdom => '지혜';

  @override
  String get nav_profile => '내 프로필';

  @override
  String get home_tapToChant => '탭하여 챈팅하기';

  @override
  String get home_dayStreak => '연속 일수';

  @override
  String get home_total => '총계:';

  @override
  String get home_mantraInfo => '만트라 정보';

  @override
  String get dialog_close => '닫기';

  @override
  String get wisdom_title => '오늘의 지혜';

  @override
  String get wisdom_dismissed => '오늘의 지혜를 묵상했습니다.\n내일 새로운 통찰이 찾아올 것입니다.';

  @override
  String get wisdom_loading => '지혜를 불러오는 중...';

  @override
  String get leaderboard_allTime => '전체 기간';

  @override
  String get leaderboard_thisWeek => '이번 주';

  @override
  String get leaderboard_yourProgress => '나의 진행 상황';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName님을 추월하기까지 $count회';
  }

  @override
  String get leaderboard_empty => '여정이 시작됩니다!';

  @override
  String get leaderboard_emptySubtitle => '리더보드에 가장 먼저 이름을 올려보세요!';

  @override
  String get leaderboard_isEmpty => '리더보드가 비어 있습니다.';

  @override
  String get leaderboard_noBade => '아직 배지가 없습니다';

  @override
  String get leaderboard_notOnBoard => '순위표에 오르려면 계속 챈팅하세요!';

  @override
  String get leaderboard_topOfBoard => '최고 순위입니다! ✨';

  @override
  String get leaderboard_noChants => '아직 챈팅 기록이 없습니다';

  @override
  String leaderboard_topMantra(Object mantra) {
    return '최고의 만트라: $mantra';
  }

  @override
  String get profile_yourProgress => '나의 진행 상황';

  @override
  String get profile_dailyStreak => '일일 연속';

  @override
  String get profile_totalJapps => '총 챈팅 횟수';

  @override
  String get profile_globalRank => '글로벌 순위';

  @override
  String get profile_mantraTotals => '만트라별 총계';

  @override
  String get profile_achievements => '업적';

  @override
  String get profile_shareProgress => '진행 상황 공유하기';

  @override
  String get profile_badgesEmpty => '챈팅을 시작하여 첫 번째 배지를 획득하세요!';

  @override
  String get profile_mantrasEmpty => '챈팅을 시작하여 여기에서 총계를 확인하세요!';

  @override
  String get profile_shareApp => 'Naam Jaap 공유하기';

  @override
  String get profile_rateApp => '앱 평가하기';

  @override
  String get profile_supportTitle => 'Naam Jaap 지원하기';

  @override
  String get profile_supportSubtitle => '앱 운영을 도와주세요';

  @override
  String get profile_myBodhi => '나의 보리수';

  @override
  String get profile_myBodhiSubtitle => '당신의 헌신에 대한 시각적인 증거입니다.';

  @override
  String get profile_yourAchievement => '나의 성과';

  @override
  String get profile_yourAchievements => '나의 성과';

  @override
  String get profile_aMark => '당신의 헌신의 표시입니다.';

  @override
  String get profile_changeName => '이름 변경';

  @override
  String get profile_enterName => '새 이름 입력';

  @override
  String get settings_title => '설정';

  @override
  String get settings_ambiance => '사원 분위기';

  @override
  String get settings_ambianceDesc => '잔잔한 사원 배경 소리를 재생합니다.';

  @override
  String get settings_reminders => '일일 알림';

  @override
  String get settings_remindersDesc => '오늘 챈팅을 하지 않은 경우 알림을 받습니다.';

  @override
  String get settings_language => '앱 언어';

  @override
  String get settings_feedback => '피드백 및 지원';

  @override
  String get settings_feedbackDesc => '버그를 보고하거나 기능을 제안합니다.';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => '개인정보 처리방침';

  @override
  String get settings_terms => '이용약관';

  @override
  String get settings_deleteAccount => '내 계정 삭제';

  @override
  String get settings_signOut => '로그아웃';

  @override
  String get dialog_deleteTitle => '계정을 삭제하시겠습니까?';

  @override
  String get dialog_deleteBody =>
      '이 작업은 영구적이며 되돌릴 수 없습니다. 모든 챈팅 데이터, 업적 및 개인 정보가 영구적으로 삭제됩니다.\n\n정말로 진행하시겠습니까?';

  @override
  String get dialog_deleteConfirm => '예, 계정을 삭제합니다';

  @override
  String get dialog_continue => '계속하기';

  @override
  String get dialog_pressBack => '종료하려면 뒤로가기를 다시 누르세요';

  @override
  String get dialog_update => '업데이트 필요';

  @override
  String get dialog_updateDesc =>
      '중요한 업데이트가 포함된 Naam Jaap의 새 버전을 사용할 수 있습니다. 계속하려면 앱을 업데이트하세요.';

  @override
  String get dialog_updateNow => '지금 업데이트';

  @override
  String get dialog_save => '저장';

  @override
  String get dialog_something => '문제가 발생했습니다.';

  @override
  String get dialog_cancel => '취소';

  @override
  String get misc_japps => '회';

  @override
  String get misc_days => '일';

  @override
  String get misc_badge => '배지';

  @override
  String get lang_chooseLang => '계속하려면 선호하는 언어를 선택하세요';

  @override
  String get lang_searchLang => '언어 검색';

  @override
  String get garden_totalMala => '완료된 말라';
}
