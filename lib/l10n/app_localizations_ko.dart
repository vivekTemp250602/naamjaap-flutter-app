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
  String get login_subtitle => '당신의 개인 디지털 챈팅 동반자.';

  @override
  String get login_termsAgreement => '나는 읽고 동의합니다 ';

  @override
  String get login_termsAndConditions => '이용 약관';

  @override
  String get login_and => ' 및 ';

  @override
  String get login_privacyPolicy => '개인 정보 보호 정책';

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
  String get home_tapToChant => '탭하여 챈팅';

  @override
  String get home_dayStreak => '일 연속';

  @override
  String get home_total => '합계:';

  @override
  String get home_mantraInfo => '만트라 정보';

  @override
  String get home_chooseMala => '말라 선택하기';

  @override
  String get home_chooseMalaDesc => '당신의 영혼과 공명하는 스타일을 선택하세요.';

  @override
  String get home_customizeMala => '말라 사용자 지정';

  @override
  String get tour_home_carousel_title => '만트라 선택';

  @override
  String get tour_home_carousel_desc => '강력한 베다 만트라 사이를 전환하려면 스와이프하세요.';

  @override
  String get tour_home_mala_title => '탭하여 챈팅';

  @override
  String get tour_home_mala_desc =>
      '구슬을 이동하려면 원의 아무 곳이나 탭하세요. 108개를 완료하면 1말라입니다.';

  @override
  String get tour_home_toolkit_title => '당신의 툴킷';

  @override
  String get tour_home_toolkit_desc => '구슬 스타일 사용자 지정, 오디오 전환 또는 의미 보기.';

  @override
  String get tour_leader_toggle_title => '주간 vs 전체';

  @override
  String get tour_leader_toggle_desc => '이번 주 리더와 역대 전설 사이를 전환하려면 여기를 탭하세요.';

  @override
  String get tour_leader_podium_title => '탑 3';

  @override
  String get tour_leader_podium_desc =>
      '가장 헌신적인 챈터가 여기에 나타납니다. 그들과 함께하려면 계속 챈팅하세요!';

  @override
  String get tour_wisdom_card_title => '매일의 지혜 & 공유';

  @override
  String get tour_wisdom_card_desc =>
      '새로운 슐로카로 하루를 시작하세요. 공유 아이콘을 탭하여 이미지를 만드세요!';

  @override
  String get tour_profile_stats_title => '당신의 영적 통계';

  @override
  String get tour_profile_stats_desc => '여기서 연속 기록, 총 자파 수 및 글로벌 순위를 추적하세요.';

  @override
  String get tour_profile_offline_title => '물리적 챈팅?';

  @override
  String get tour_profile_offline_desc =>
      '실제 말라를 사용하는 경우 여기를 탭하여 수동으로 카운트를 추가하세요.';

  @override
  String get tour_profile_bodhi_desc =>
      '챈팅하는 모든 말라는 영적 정원을 가꾸는 데 도움이 됩니다. 진행함에 따라 새로운 나무를 잠금 해제하세요!';

  @override
  String get tour_profile_sankalpa_desc => '영적 목표에 전념하기 위해 목표 날짜와 횟수를 설정하세요.';

  @override
  String get guest_mode_title => '게스트 모드';

  @override
  String get guest_mode_desc => '영적 프로필을 잠금 해제하려면 로그인하세요.';

  @override
  String get guest_signin_btn => '로그인';

  @override
  String get wisdom_title => '오늘의 지혜';

  @override
  String get wisdom_dismissed => '오늘의 지혜는 숙고되었습니다.\n새로운 통찰력은 내일 도착합니다.';

  @override
  String get wisdom_loading => '지혜 로딩 중...';

  @override
  String get wisdom_signin_to_share => '카드를 공유하려면 로그인하세요!';

  @override
  String get wisdom_creating_card => '신성한 카드 생성 중...';

  @override
  String get leaderboard_allTime => '전체 기간';

  @override
  String get leaderboard_thisWeek => '이번 주';

  @override
  String get leaderboard_yourProgress => '나의 진행 상황';

  @override
  String get leaderboard_yourRank => '나의 순위';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName님을 추월하기까지 $count 자파';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName님을 추월하기까지 $count 말라';
  }

  @override
  String get leaderboard_empty => '여정이 시작됩니다!';

  @override
  String get leaderboard_emptySubtitle => '리더보드를 장식하는 첫 번째 사람이 되세요!';

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
  String leaderboard_topMantra(String mantra) {
    return '최고 만트라: $mantra';
  }

  @override
  String get profile_yourProgress => '나의 진행 상황';

  @override
  String get profile_dailyStreak => '일일 연속';

  @override
  String get profile_totalJapps => '총 자파';

  @override
  String get profile_globalRank => '글로벌 순위';

  @override
  String get profile_mantraTotals => '만트라 합계';

  @override
  String get profile_achievements => '성과';

  @override
  String get profile_shareProgress => '진행 상황 공유';

  @override
  String get profile_badgesEmpty => '첫 배지를 획득하려면 챈팅을 시작하세요!';

  @override
  String get profile_mantrasEmpty => '여기에서 합계를 보려면 챈팅을 시작하세요!';

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
  String get profile_shareApp => 'Naam Jaap 공유하기';

  @override
  String get profile_yourCustomMantra => '나의 맞춤 만트라';

  @override
  String get profile_noCustoms => '아직 추가한 맞춤 만트라가 없습니다.';

  @override
  String get profile_addNewMantra => '새 만트라 추가';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\"을(를) 삭제하시겠습니까?';
  }

  @override
  String get profile_deleteMantraSure =>
      '확실하신가요? 이 만트라와 관련된 모든 자파 횟수도 영구적으로 삭제됩니다.';

  @override
  String get profile_yesDelete => '예, 삭제합니다';

  @override
  String get profile_couldNotUserData => '사용자 데이터를 로드할 수 없습니다.';

  @override
  String get profile_offline_card_title => '오프라인 자파 기록';

  @override
  String get profile_offline_card_subtitle => '물리적 말라에서 카운트 추가';

  @override
  String get profile_gamification_header => '게이미피케이션';

  @override
  String get profile_commitments_header => '약속';

  @override
  String get profile_insights_header => '만트라 인사이트';

  @override
  String get profile_my_mantras_header => '내 만트라';

  @override
  String get profile_quick_actions_header => '빠른 작업';

  @override
  String get profile_sankalpaSet => '성스러운 서원 세우기';

  @override
  String get profile_sankalpaSubtitle => '개인 챈팅 목표 설정하기.';

  @override
  String get profile_sankalpaTitle => '나의 자파 산칼파';

  @override
  String get profile_sankalpaChanting => '챈팅 중';

  @override
  String get profile_abandon => '서원 포기';

  @override
  String get profile_progress => '진행 상황';

  @override
  String get profile_deadline => '마감일';

  @override
  String get profile_achieved => '달성!';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount회 달성까지.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date까지';
  }

  @override
  String get settings_title => '설정';

  @override
  String get settings_ambiance => '사원 분위기';

  @override
  String get settings_ambianceDesc => '미묘한 사원 소리 재생.';

  @override
  String get settings_reminders => '일일 알림';

  @override
  String get settings_remindersDesc => '오늘 챈팅하지 않은 경우 알림 받기.';

  @override
  String get settings_language => '앱 언어';

  @override
  String get settings_feedback => '피드백 및 지원';

  @override
  String get settings_feedbackDesc => '버그 신고 또는 기능 제안.';

  @override
  String get settings_deletingAccount => '계정을 삭제하는 중...';

  @override
  String get settings_privacy => '개인 정보 보호 정책';

  @override
  String get settings_terms => '이용 약관';

  @override
  String get settings_deleteAccount => '내 계정 삭제';

  @override
  String get settings_signOut => '로그아웃';

  @override
  String get settings_exit_guest => '게스트 모드 종료';

  @override
  String get settings_support_header => '지원 및 법적 정보';

  @override
  String get settings_account_header => '계정';

  @override
  String get support_title => 'Naam Jaap 프로젝트 후원';

  @override
  String get support_desc =>
      'Naam Jaap은 한 명의 개발자가 사랑으로 만든 앱입니다. 당신의 이타적인 기여(봉사)는 서버를 운영하고, 광고를 최소화하며, 모든 신자들이 앱을 무료로 사용할 수 있도록 돕습니다.';

  @override
  String get support_afterTitile =>
      'Naam Jaap을 후원해 주셔서 감사합니다 — 모든 기여가 큰 힘이 됩니다.';

  @override
  String get support_openUPI => 'UPI 앱을 여는 중...';

  @override
  String get support_cannotOpenUPI => 'UPI 앱을 실행할 수 없습니다.';

  @override
  String get support_upiError => '오류: 열 수 있는 UPI 앱을 찾을 수 없습니다.';

  @override
  String get support_chooseOffering => '공양 선택하기';

  @override
  String get support_enterAmt => '또는 사용자 지정 금액 입력 (INR)';

  @override
  String get support_validAmt => '유효한 금액을 선택하거나 입력해주세요.';

  @override
  String get support_now => '지금 지원하기';

  @override
  String get support_donate => '기부하기';

  @override
  String get support_paymentSucc => 'Razorpay에 의해 안전하게 처리된 결제';

  @override
  String get support_thank => '🙏 감사합니다';

  @override
  String get support_offer_seva => '봉사 제공';

  @override
  String get support_signin_required => '기부하려면 로그인하세요.';

  @override
  String get support_payment_error => '결제를 시작할 수 없습니다. 다시 시도해주세요.';

  @override
  String get support_blessed => '축복받으시길.';

  @override
  String get support_tier_flower => '꽃 공양';

  @override
  String get support_tier_lamp => '등불 밝히기';

  @override
  String get support_tier_garland => '화환 봉사';

  @override
  String get support_tier_temple => '사원 지원';

  @override
  String get support_tier_grand => '대공양';

  @override
  String get custom_create => '나만의 만트라 만들기';

  @override
  String get custom_yourMantra => '만트라 이름';

  @override
  String get custom_hint => '예: Om Gurave Namah';

  @override
  String get custom_back => '배경 선택:';

  @override
  String get custom_addVoice => '음성 추가 (선택 사항):';

  @override
  String get custom_recording => '녹음 중...';

  @override
  String get custom_tapToRecord => '녹음하려면 마이크를 탭하세요';

  @override
  String get custom_saveMantra => '만트라 저장';

  @override
  String get custom_micAccess => '오디오를 녹음하려면 마이크 권한이 필요합니다.';

  @override
  String get custom_preview => '미리보기';

  @override
  String get custom_voice_saved => '음성 메모 저장됨';

  @override
  String get custom_tap_record => '탭하여 녹음';

  @override
  String get custom_ready_use => '사용 준비 완료';

  @override
  String get custom_error_empty_name => '만트라 이름을 입력해주세요';

  @override
  String get garden_title => '보리수 정원';

  @override
  String get garden_subtitle => '영적 숲 가꾸기';

  @override
  String get garden_growth => '영적 성장';

  @override
  String get garden_totalMala => '완료된 말라';

  @override
  String get dialog_deleteTitle => '계정 삭제?';

  @override
  String get dialog_deleteBody =>
      '이 작업은 영구적이며 취소할 수 없습니다. 모든 챈팅 데이터, 성과 및 개인 정보가 영구적으로 삭제됩니다.\n\n정말로 진행하시겠습니까?';

  @override
  String get dialog_deleteConfirm => '예, 내 계정 삭제';

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
  String get dialog_close => '닫기';

  @override
  String get dialog_something => '문제가 발생했습니다.';

  @override
  String get dialog_cancel => '취소';

  @override
  String get dialog_profilePictureUpdate => '프로필 사진이 업데이트되었습니다!';

  @override
  String get dialog_failedToUpload => '이미지 업로드 실패.';

  @override
  String get dialog_exceptionCard => '공유 가능한 카드 컨텍스트를 사용할 수 없습니다.';

  @override
  String get dialog_couldNotOpenPS => 'Play 스토어를 열 수 없습니다.';

  @override
  String get dialog_mic => '오디오를 녹음하려면 마이크 권한이 필요합니다.';

  @override
  String get dialog_getStarted => '시작하기';

  @override
  String get dialog_next => '다음';

  @override
  String get dialog_skip => '건너뛰기';

  @override
  String get dialog_checkoutMyProgress => 'Naam Jaap 앱에서 제 진행 상황을 확인하세요!';

  @override
  String get dialog_sankalpaTitle => '자파 산칼파 설정하기';

  @override
  String get dialog_sankalpaSelectMantra => '만트라 선택';

  @override
  String get dialog_sankalpaTargetCount => '목표 횟수 (예: 11000)';

  @override
  String get dialog_sankalpaTargetDate => '목표 날짜';

  @override
  String get dialog_sankalpaSelectDate => '날짜 선택';

  @override
  String get dialog_sankalpaSetPledge => '나의 서원 설정하기';

  @override
  String get dialog_sankalpaError => '모든 필드를 올바르게 입력해주세요.';

  @override
  String get dialog_sankalpaErrorTarget => '목표 횟수는 현재 횟수보다 커야 합니다.';

  @override
  String get misc_japps => '자파';

  @override
  String get misc_days => '일';

  @override
  String get misc_badge => '배지';

  @override
  String get misc_malas => '말라';

  @override
  String get misc_anonymous => '익명';

  @override
  String get lang_chooseLang => '계속하려면 선호하는 언어를 선택하세요';

  @override
  String get lang_searchLang => '언어 검색';

  @override
  String get malatype_regular => '일반';

  @override
  String get malatype_crystal => '크리스탈';

  @override
  String get malatype_royal => '로열 골드';
}
