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
  String get login_subtitle => 'あなたの個人的なデジタル詠唱コンパニオン。';

  @override
  String get login_termsAgreement => '私は読み、同意しました ';

  @override
  String get login_termsAndConditions => '利用規約';

  @override
  String get login_and => ' と ';

  @override
  String get login_privacyPolicy => 'プライバシーポリシー';

  @override
  String get login_signInWithGoogle => 'Google でログイン';

  @override
  String get nav_home => 'ホーム';

  @override
  String get nav_leaderboard => 'ランキング';

  @override
  String get nav_wisdom => '知恵';

  @override
  String get nav_profile => 'プロフィール';

  @override
  String get home_tapToChant => 'タップして詠唱';

  @override
  String get home_dayStreak => '日連続';

  @override
  String get home_total => '合計:';

  @override
  String get home_mantraInfo => 'マントラ情報';

  @override
  String get home_chooseMala => 'マーラーを選択';

  @override
  String get home_chooseMalaDesc => 'あなたの精神に共鳴するスタイルを選択してください。';

  @override
  String get home_customizeMala => 'マーラーをカスタマイズ';

  @override
  String get tour_home_carousel_title => 'マントラを選択';

  @override
  String get tour_home_carousel_desc => 'スワイプして強力なヴェーダマントラを切り替えます。';

  @override
  String get tour_home_mala_title => 'タップして詠唱';

  @override
  String get tour_home_mala_desc => '円のどこかをタップして数珠を動かします。108回で1マーラーです。';

  @override
  String get tour_home_toolkit_title => 'あなたのツールキット';

  @override
  String get tour_home_toolkit_desc => '数珠のスタイルをカスタマイズ、音声を切り替え、または意味を表示します。';

  @override
  String get tour_leader_toggle_title => '週間 vs 通算';

  @override
  String get tour_leader_toggle_desc => 'ここをタップして、今週のリーダーと歴代のレジェンドを切り替えます。';

  @override
  String get tour_leader_podium_title => 'トップ3';

  @override
  String get tour_leader_podium_desc =>
      '最も献身的なチャンターがここに表示されます。参加するために詠唱を続けましょう！';

  @override
  String get tour_wisdom_card_title => '今日の知恵 & 共有';

  @override
  String get tour_wisdom_card_desc => '新しいシュローカで一日を始めましょう。共有アイコンをタップして画像を作成！';

  @override
  String get tour_profile_stats_title => 'あなたの精神的統計';

  @override
  String get tour_profile_stats_desc => 'ここでストリーク、総ジャパ数、グローバルランクを追跡します。';

  @override
  String get tour_profile_offline_title => '物理的な詠唱？';

  @override
  String get tour_profile_offline_desc =>
      '本物のマーラーを使用している場合は、ここをタップして手動で数を追加します。';

  @override
  String get tour_profile_bodhi_desc => '詠唱するたびに精神的な庭が成長します。進歩に合わせて新しい木をアンロック！';

  @override
  String get tour_profile_sankalpa_desc => '目標日と回数を設定して精神的な目標に取り組みます。';

  @override
  String get guest_mode_title => 'ゲストモード';

  @override
  String get guest_mode_desc => 'ログインして精神的プロフィールをアンロック。';

  @override
  String get guest_signin_btn => 'ログイン';

  @override
  String get wisdom_title => '今日の知恵';

  @override
  String get wisdom_dismissed => '今日の知恵は熟考されました。\n新しい洞察は明日届きます。';

  @override
  String get wisdom_loading => '知恵を読み込み中...';

  @override
  String get wisdom_signin_to_share => 'ログインしてカードを共有！';

  @override
  String get wisdom_creating_card => '神聖なカードを作成中...';

  @override
  String get leaderboard_allTime => '全期間';

  @override
  String get leaderboard_thisWeek => '今週';

  @override
  String get leaderboard_yourProgress => 'あなたの進捗';

  @override
  String get leaderboard_yourRank => 'あなたのランク';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '$playerName を追い越すまであと $count ジャパ';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '$playerName を追い越すまであと $count マーラー';
  }

  @override
  String get leaderboard_empty => '旅が始まります！';

  @override
  String get leaderboard_emptySubtitle => 'ランキングを飾る最初の人になりましょう！';

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
  String leaderboard_topMantra(String mantra) {
    return 'トップマントラ: $mantra';
  }

  @override
  String get profile_yourProgress => 'あなたの進捗';

  @override
  String get profile_dailyStreak => '毎日のストリーク';

  @override
  String get profile_totalJapps => '総ジャパ数';

  @override
  String get profile_globalRank => 'グローバルランク';

  @override
  String get profile_mantraTotals => 'マントラ合計';

  @override
  String get profile_achievements => '実績';

  @override
  String get profile_shareProgress => '進捗を共有';

  @override
  String get profile_badgesEmpty => '最初のバッジを獲得するために詠唱を始めましょう！';

  @override
  String get profile_mantrasEmpty => 'ここに合計を表示するために詠唱を始めましょう！';

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
  String get profile_shareApp => 'Naam Jaap を共有';

  @override
  String get profile_yourCustomMantra => 'マイカスタムマントラ';

  @override
  String get profile_noCustoms => 'まだカスタムマントラを追加していません。';

  @override
  String get profile_addNewMantra => '新しいマントラを追加';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '\"$mantraName\" を削除しますか？';
  }

  @override
  String get profile_deleteMantraSure =>
      'よろしいですか？ このマントラに関連するすべてのジャパカウントも完全に削除されます。';

  @override
  String get profile_yesDelete => 'はい、削除します';

  @override
  String get profile_couldNotUserData => 'ユーザーデータを読み込めませんでした。';

  @override
  String get profile_offline_card_title => 'オフラインジャパを記録';

  @override
  String get profile_offline_card_subtitle => '物理的なマーラーからのカウントを追加';

  @override
  String get profile_gamification_header => 'ゲーミフィケーション';

  @override
  String get profile_commitments_header => 'コミットメント';

  @override
  String get profile_insights_header => 'マントラインサイト';

  @override
  String get profile_my_mantras_header => 'マイマントラ';

  @override
  String get profile_quick_actions_header => 'クイックアクション';

  @override
  String get profile_sankalpaSet => '聖なる誓いを立てる';

  @override
  String get profile_sankalpaSubtitle => '個人的な詠唱目標を設定します。';

  @override
  String get profile_sankalpaTitle => 'あなたのジャパ・サンカルパ';

  @override
  String get profile_sankalpaChanting => '詠唱中';

  @override
  String get profile_abandon => '誓いを放棄';

  @override
  String get profile_progress => '進捗';

  @override
  String get profile_deadline => '期限';

  @override
  String get profile_achieved => '達成！';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' $targetCount 回に到達するため。';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '$date までに';
  }

  @override
  String get settings_title => '設定';

  @override
  String get settings_ambiance => '寺院の雰囲気';

  @override
  String get settings_ambianceDesc => '寺院の音を再生します。';

  @override
  String get settings_reminders => '毎日のリマインダー';

  @override
  String get settings_remindersDesc => '今日詠唱していない場合に通知を受け取ります。';

  @override
  String get settings_language => 'アプリの言語';

  @override
  String get settings_feedback => 'フィードバック & サポート';

  @override
  String get settings_feedbackDesc => 'バグを報告するか、機能を提案します。';

  @override
  String get settings_deletingAccount => 'アカウントを削除しています...';

  @override
  String get settings_privacy => 'プライバシーポリシー';

  @override
  String get settings_terms => '利用規約';

  @override
  String get settings_deleteAccount => 'アカウントを削除';

  @override
  String get settings_signOut => 'サインアウト';

  @override
  String get settings_exit_guest => 'ゲストモードを終了';

  @override
  String get settings_support_header => 'サポート & 法的情報';

  @override
  String get settings_account_header => 'アカウント';

  @override
  String get support_title => 'Naam Jaap プロジェクトを支援';

  @override
  String get support_desc =>
      'Naam Jaap は、一人の開発者によって愛情を込めて作られました。あなたの無私の貢献 (セヴァ) は、サーバーの稼働、広告の最小化、そしてすべての信者のためのアプリの無料提供に役立ちます。';

  @override
  String get support_afterTitile =>
      'Naam Jaap をご支援いただきありがとうございます — すべての貢献が役立ちます。';

  @override
  String get support_openUPI => 'UPIアプリを開いています...';

  @override
  String get support_cannotOpenUPI => 'UPIアプリを起動できませんでした。';

  @override
  String get support_upiError => 'エラー: 開くUPIアプリが見つかりませんでした。';

  @override
  String get support_chooseOffering => '捧げ物を選ぶ';

  @override
  String get support_enterAmt => 'またはカスタム金額を入力 (INR)';

  @override
  String get support_validAmt => '有効な金額を選択または入力してください。';

  @override
  String get support_now => '今すぐサポート';

  @override
  String get support_donate => '寄付';

  @override
  String get support_paymentSucc => 'Razorpay によって安全に処理された支払い';

  @override
  String get support_thank => '🙏 ありがとうございます';

  @override
  String get support_offer_seva => 'セヴァを提供する';

  @override
  String get support_signin_required => '寄付するにはログインしてください。';

  @override
  String get support_payment_error => '支払いを開始できませんでした。再試行してください。';

  @override
  String get support_blessed => '祝福がありますように。';

  @override
  String get support_tier_flower => '花の奉納';

  @override
  String get support_tier_lamp => 'ランプ点灯';

  @override
  String get support_tier_garland => '花輪のセヴァ';

  @override
  String get support_tier_temple => '寺院支援';

  @override
  String get support_tier_grand => '大奉納';

  @override
  String get custom_create => 'あなたのマントラを作成';

  @override
  String get custom_yourMantra => 'マントラの名前';

  @override
  String get custom_hint => '例：Om Gurave Namah';

  @override
  String get custom_back => '背景を選択：';

  @override
  String get custom_addVoice => 'あなたの声を追加（任意）：';

  @override
  String get custom_recording => '録音中...';

  @override
  String get custom_tapToRecord => 'マイクをタップして録音';

  @override
  String get custom_saveMantra => 'マントラを保存';

  @override
  String get custom_micAccess => '音声を録音するにはマイクの権限が必要です。';

  @override
  String get custom_preview => 'プレビュー';

  @override
  String get custom_voice_saved => 'ボイスメモが保存されました';

  @override
  String get custom_tap_record => 'タップして録音';

  @override
  String get custom_ready_use => '使用準備完了';

  @override
  String get custom_error_empty_name => 'マントラ名を入力してください';

  @override
  String get garden_title => '菩提樹の庭';

  @override
  String get garden_subtitle => '精神的な森を育てる';

  @override
  String get garden_growth => '精神的な成長';

  @override
  String get garden_totalMala => '完了したマーラー';

  @override
  String get dialog_deleteTitle => 'アカウントを削除？';

  @override
  String get dialog_deleteBody =>
      'この操作は元に戻せません。すべての詠唱データ、実績、個人情報は完全に削除されます。\n\n本当に続行してもよろしいですか？';

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
  String get dialog_close => '閉じる';

  @override
  String get dialog_something => '問題が発生しました。';

  @override
  String get dialog_cancel => 'キャンセル';

  @override
  String get dialog_profilePictureUpdate => 'プロフィール写真が更新されました！';

  @override
  String get dialog_failedToUpload => '画像のアップロードに失敗しました。';

  @override
  String get dialog_exceptionCard => '共有可能なカードコンテキストは利用できません。';

  @override
  String get dialog_couldNotOpenPS => 'Play ストアを開けませんでした。';

  @override
  String get dialog_mic => '音声を録音するにはマイクの権限が必要です。';

  @override
  String get dialog_getStarted => '始める';

  @override
  String get dialog_next => '次へ';

  @override
  String get dialog_skip => 'スキップ';

  @override
  String get dialog_checkoutMyProgress => 'Naam Jaap アプリでの私の進捗を見てください！';

  @override
  String get dialog_sankalpaTitle => 'ジャパ・サンカルパを設定';

  @override
  String get dialog_sankalpaSelectMantra => 'マントラを選択';

  @override
  String get dialog_sankalpaTargetCount => '目標回数（例：11000）';

  @override
  String get dialog_sankalpaTargetDate => '目標日';

  @override
  String get dialog_sankalpaSelectDate => '日付を選択';

  @override
  String get dialog_sankalpaSetPledge => '私の誓いを設定';

  @override
  String get dialog_sankalpaError => 'すべてのフィールドを正しく入力してください。';

  @override
  String get dialog_sankalpaErrorTarget => '目標回数は現在の回数より多くなければなりません。';

  @override
  String get misc_japps => 'ジャパ';

  @override
  String get misc_days => '日';

  @override
  String get misc_badge => 'バッジ';

  @override
  String get misc_malas => 'マーラー';

  @override
  String get misc_anonymous => '匿名';

  @override
  String get lang_chooseLang => '続行するには、ご希望の言語を選択してください';

  @override
  String get lang_searchLang => '言語を検索';

  @override
  String get malatype_regular => 'レギュラー';

  @override
  String get malatype_crystal => 'クリスタル';

  @override
  String get malatype_royal => 'ロイヤルゴールド';
}
