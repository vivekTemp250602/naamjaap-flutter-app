// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => 'Naam Jaap へようこそ';

  @override
  String get login_subtitle => 'あなたのパーソナル・デジタル詠唱コンパニオン。';

  @override
  String get login_termsAgreement => '私は';

  @override
  String get login_termsAndConditions => '利用規約';

  @override
  String get login_and => 'と';

  @override
  String get login_privacyPolicy => 'プライバシーポリシーに同意します';

  @override
  String get login_signInWithGoogle => 'Google でサインイン';

  @override
  String get nav_home => 'ホーム';

  @override
  String get nav_leaderboard => 'ランキング';

  @override
  String get nav_wisdom => '知恵';

  @override
  String get nav_profile => 'マイプロフィール';

  @override
  String get home_tapToChant => 'タップして詠唱';

  @override
  String get home_dayStreak => '連続日数';

  @override
  String get home_total => '合計:';

  @override
  String get home_mantraInfo => 'マントラ情報';

  @override
  String get dialog_close => '閉じる';

  @override
  String get wisdom_title => '今日の知恵';

  @override
  String get wisdom_dismissed => '今日の知恵は熟考されました。\n明日、新たな洞察が訪れるでしょう。';

  @override
  String get wisdom_loading => '知恵を読み込み中...';

  @override
  String get leaderboard_allTime => '全期間';

  @override
  String get leaderboard_thisWeek => '今週';

  @override
  String get leaderboard_yourProgress => 'あなたの進捗';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName を追い越すまであと $count 回';
  }

  @override
  String get leaderboard_empty => '旅が始まります！';

  @override
  String get leaderboard_emptySubtitle => 'ランキングの最初の１人になりましょう！';

  @override
  String get leaderboard_isEmpty => 'ランキングは空です。';

  @override
  String get leaderboard_noBade => 'まだバッジがありません';

  @override
  String get leaderboard_notOnBoard => 'ランキングに入るには詠唱を続けましょう！';

  @override
  String get leaderboard_topOfBoard => 'トップです！ ✨';

  @override
  String get leaderboard_noChants => 'まだ詠唱がありません';

  @override
  String leaderboard_topMantra(Object mantra) {
    return 'トップマントラ: $mantra';
  }

  @override
  String get profile_yourProgress => 'あなたの進捗';

  @override
  String get profile_dailyStreak => '毎日の連続記録';

  @override
  String get profile_totalJapps => '総詠唱回数';

  @override
  String get profile_globalRank => 'グローバルランク';

  @override
  String get profile_mantraTotals => 'マントラ別合計';

  @override
  String get profile_achievements => '実績';

  @override
  String get profile_shareProgress => '進捗を共有';

  @override
  String get profile_badgesEmpty => '詠唱を始めて最初のバッジを獲得しましょう！';

  @override
  String get profile_mantrasEmpty => '詠唱を始めて合計回数をここに表示しましょう！';

  @override
  String get profile_shareApp => 'Naam Jaap を共有';

  @override
  String get profile_rateApp => 'アプリを評価';

  @override
  String get profile_supportTitle => 'Naam Jaap をサポート';

  @override
  String get profile_supportSubtitle => 'アプリの運営を支援';

  @override
  String get profile_myBodhi => '私の菩提樹';

  @override
  String get profile_myBodhiSubtitle => 'あなたの献身の視覚的な証。';

  @override
  String get profile_yourAchievement => 'あなたの実績';

  @override
  String get profile_yourAchievements => 'あなたの実績';

  @override
  String get profile_aMark => 'あなたの献身の印。';

  @override
  String get profile_changeName => '名前を変更';

  @override
  String get profile_enterName => '新しい名前を入力';

  @override
  String get settings_title => '設定';

  @override
  String get settings_ambiance => '寺院の雰囲気';

  @override
  String get settings_ambianceDesc => '静かな寺院の背景音を再生します。';

  @override
  String get settings_reminders => '毎日のリマインダー';

  @override
  String get settings_remindersDesc => '今日まだ詠唱していない場合に通知を受け取ります。';

  @override
  String get settings_language => 'アプリの言語';

  @override
  String get settings_feedback => 'フィードバックとサポート';

  @override
  String get settings_feedbackDesc => 'バグを報告するか、機能を提案します。';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => 'プライバシーポリシー';

  @override
  String get settings_terms => '利用規約';

  @override
  String get settings_deleteAccount => 'マイアカウントを削除';

  @override
  String get settings_signOut => 'サインアウト';

  @override
  String get dialog_deleteTitle => 'アカウントを削除しますか？';

  @override
  String get dialog_deleteBody =>
      'この操作は永続的であり、元に戻すことはできません。すべての詠唱データ、実績、個人情報は永久に消去されます。\n\n続行してもよろしいですか？';

  @override
  String get dialog_deleteConfirm => 'はい、アカウントを削除します';

  @override
  String get dialog_continue => '続行';

  @override
  String get dialog_pressBack => '終了するにはもう一度戻るを押してください';

  @override
  String get dialog_update => 'アップデートが必要です';

  @override
  String get dialog_updateDesc =>
      '重要なアップデートを含む Naam Jaap の新しいバージョンが利用可能です。続行するにはアプリをアップデートしてください。';

  @override
  String get dialog_updateNow => '今すぐアップデート';

  @override
  String get dialog_save => '保存';

  @override
  String get dialog_something => '問題が発生しました。';

  @override
  String get dialog_cancel => 'キャンセル';

  @override
  String get misc_japps => '回';

  @override
  String get misc_days => '日';

  @override
  String get misc_badge => 'バッジ';

  @override
  String get lang_chooseLang => '続行するには、ご希望の言語を選択してください';

  @override
  String get lang_searchLang => '言語を検索';

  @override
  String get garden_totalMala => '完了したマーラー';
}
