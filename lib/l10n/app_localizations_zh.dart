// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get login_subtitle => '您的个人数字诵经伴侣。';

  @override
  String get login_termsAgreement => '我已阅读并同意';

  @override
  String get login_termsAndConditions => '条款与条件';

  @override
  String get login_and => '和';

  @override
  String get login_privacyPolicy => '隐私政策';

  @override
  String get login_signInWithGoogle => '使用 Google 登录';

  @override
  String get nav_home => '首页';

  @override
  String get nav_leaderboard => '排行榜';

  @override
  String get nav_wisdom => '智慧';

  @override
  String get nav_profile => '我的资料';

  @override
  String get home_tapToChant => '点击诵经';

  @override
  String get home_dayStreak => '连续天数';

  @override
  String get home_total => '总计:';

  @override
  String get home_mantraInfo => '真言信息';

  @override
  String get dialog_close => '关闭';

  @override
  String get wisdom_title => '今日智慧';

  @override
  String get wisdom_dismissed => '今日的智慧已被领悟。\n新的启示将于明天到来。';

  @override
  String get wisdom_loading => '正在加载智慧...';

  @override
  String get leaderboard_allTime => '所有时间';

  @override
  String get leaderboard_thisWeek => '本周';

  @override
  String get leaderboard_yourProgress => '您的进度';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '还需 $count 次诵经才能超过 $playerName';
  }

  @override
  String get leaderboard_empty => '旅程开始了！';

  @override
  String get leaderboard_emptySubtitle => '成为第一个登上排行榜的人！';

  @override
  String get leaderboard_isEmpty => '排行榜为空。';

  @override
  String get leaderboard_noBade => '尚无徽章';

  @override
  String get leaderboard_notOnBoard => '继续诵经以登上排行榜！';

  @override
  String get leaderboard_topOfBoard => '您已登顶！ ✨';

  @override
  String get leaderboard_noChants => '尚无诵经';

  @override
  String leaderboard_topMantra(Object mantra) {
    return '热门真言: $mantra';
  }

  @override
  String get profile_yourProgress => '您的进度';

  @override
  String get profile_dailyStreak => '每日连续';

  @override
  String get profile_totalJapps => '总诵经次数';

  @override
  String get profile_globalRank => '全球排名';

  @override
  String get profile_mantraTotals => '真言总计';

  @override
  String get profile_achievements => '成就';

  @override
  String get profile_shareProgress => '分享您的进度';

  @override
  String get profile_badgesEmpty => '开始诵经以获得您的第一个徽章！';

  @override
  String get profile_mantrasEmpty => '开始诵经以在此处查看您的总数！';

  @override
  String get profile_rateApp => '评价我们的应用';

  @override
  String get profile_supportSubtitle => '帮助维持应用运行';

  @override
  String get profile_myBodhi => '我的菩提树';

  @override
  String get profile_myBodhiSubtitle => '您虔诚的视觉证明。';

  @override
  String get profile_yourAchievement => '您的成就';

  @override
  String get profile_yourAchievements => '您的成就';

  @override
  String get profile_aMark => '您奉献精神的标志。';

  @override
  String get profile_changeName => '更改您的姓名';

  @override
  String get profile_enterName => '输入新名称';

  @override
  String get settings_title => '设置';

  @override
  String get settings_ambiance => '寺庙氛围';

  @override
  String get settings_ambianceDesc => '播放微妙的寺庙背景音。';

  @override
  String get settings_reminders => '每日提醒';

  @override
  String get settings_remindersDesc => '如果您今天还未诵经，将收到通知。';

  @override
  String get settings_language => '应用语言';

  @override
  String get settings_feedback => '反馈与支持';

  @override
  String get settings_feedbackDesc => '报告错误或建议功能。';

  @override
  String get settings_deletingAccount => 'Deleting your account...';

  @override
  String get settings_privacy => '隐私政策';

  @override
  String get settings_terms => '条款与条件';

  @override
  String get settings_deleteAccount => '删除我的帐户';

  @override
  String get settings_signOut => '登出';

  @override
  String get dialog_deleteTitle => '删除帐户？';

  @override
  String get dialog_deleteBody =>
      '此操作是永久性的，无法撤销。您所有的诵经数据、成就和个人信息将被永久删除。\n\n您确定要继续吗？';

  @override
  String get dialog_deleteConfirm => '是的，删除我的帐户';

  @override
  String get dialog_continue => '继续';

  @override
  String get dialog_pressBack => '再按一次返回键退出';

  @override
  String get dialog_update => '需要更新';

  @override
  String get dialog_updateNow => '立即更新';

  @override
  String get dialog_save => '保存';

  @override
  String get dialog_something => '出错了。';

  @override
  String get dialog_cancel => '取消';

  @override
  String get misc_japps => '次诵经';

  @override
  String get misc_days => '天';

  @override
  String get misc_badge => '徽章';

  @override
  String get lang_chooseLang => '选择您偏好的语言以继续';

  @override
  String get lang_searchLang => '搜索语言';

  @override
  String get garden_totalMala => '完成的念珠';

  @override
  String get misc_malas => '念珠';

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '还需 $count 串念珠才能超过 $playerName';
  }

  @override
  String get dialog_mic => '录制音频需要麦克风权限。';

  @override
  String get custom_create => '创建您的真言';

  @override
  String get custom_yourMantra => '真言名称';

  @override
  String get custom_hint => '例如：Om Gurave Namah';

  @override
  String get custom_back => '选择背景：';

  @override
  String get custom_addVoice => '添加您的声音（可选）：';

  @override
  String get custom_recording => '录音中...';

  @override
  String get custom_tapToRecord => '点击麦克风录音';

  @override
  String get custom_saveMantra => '保存真言';

  @override
  String get custom_micAccess => '录制音频需要麦克风权限。';

  @override
  String get profile_yourCustomMantra => '我的自定义真言';

  @override
  String get profile_noCustoms => '您尚未添加任何自定义真言。';

  @override
  String get profile_addNewMantra => '添加新真言';

  @override
  String get dialog_profilePictureUpdate => '个人资料图片已更新！';

  @override
  String get dialog_failedToUpload => '上传图片失败。';

  @override
  String get dialog_exceptionCard => '可共享卡片上下文不可用。';

  @override
  String get dialog_checkoutMyProgress => '在 NaamJaap 应用上查看我的进度！';

  @override
  String get dialog_couldNotOpenPS => '无法打开 Play 商店。';

  @override
  String profile_deleteMantra(Object mantraName) {
    return '删除 \"$mantraName\"？';
  }

  @override
  String get profile_deleteMantraSure => '您确定吗？与此真言相关的所有念诵计数也将被永久删除。';

  @override
  String get profile_yesDelete => '是的，删除';

  @override
  String get profile_couldNotUserData => '无法加载用户数据。';

  @override
  String get misc_anonymous => '匿名';

  @override
  String get profile_sankalpaSet => 'Lege ein heiliges Gelübde ab';

  @override
  String get profile_sankalpaSubtitle =>
      'Setze ein persönliches Chanting-Ziel.';

  @override
  String get profile_sankalpaTitle => 'Dein Japa Sankalpa';

  @override
  String get profile_sankalpaChanting => 'Chanten';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' um $targetCount Mal zu erreichen.';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return 'Bis $date';
  }

  @override
  String get dialog_sankalpaTitle => 'Setze dein Japa Sankalpa';

  @override
  String get dialog_sankalpaSelectMantra => 'Mantra auswählen';

  @override
  String get dialog_sankalpaTargetCount => 'Zielanzahl (z.B. 11000)';

  @override
  String get dialog_sankalpaTargetDate => 'Zieldatum';

  @override
  String get dialog_sankalpaSelectDate => 'Datum auswählen';

  @override
  String get dialog_sankalpaSetPledge => 'Mein Gelübde festlegen';

  @override
  String get dialog_sankalpaError => 'Bitte fülle alle Felder korrekt aus.';

  @override
  String get dialog_sankalpaErrorTarget =>
      'Die Zielanzahl muss größer sein als deine aktuelle Anzahl.';

  @override
  String get support_openUPI => '正在打开您的 UPI 应用...';

  @override
  String get support_cannotOpenUPI => '无法启动 UPI 应用。';

  @override
  String get support_upiError => '错误：找不到可打开的 UPI 应用。';

  @override
  String get support_chooseOffering => '选择一份供养';

  @override
  String get support_enterAmt => '或输入自定义金额 (INR)';

  @override
  String get support_validAmt => '请输入或选择有效金额。';

  @override
  String get support_now => '立即支持';

  @override
  String get home_chooseMala => '选择您的念珠';

  @override
  String get home_chooseMalaDesc => '选择一种与您的精神产生共鸣的风格。';

  @override
  String get tour_title1 => '数字持咒念珠';

  @override
  String get tour_body1 => '点击诵经。我们会自动计算您的念珠数，跟踪念珠串数并保持您的连续记录。';

  @override
  String get tour_title2 => '全球排行榜';

  @override
  String get tour_body2 => '与成千上万的人一起诵经。通过精神进步和坚持不懈来提升。';

  @override
  String get tour_title3 => '每日智慧';

  @override
  String get tour_body3 => '接收来自古代文本的精选诗句 — 提供多种语言版本。';

  @override
  String get tour_title4 => '您的精神之旅';

  @override
  String get tour_body4 => '跟踪里程碑，设定誓愿，并反思您的成长和成就。';

  @override
  String get dialog_getStarted => '开始';

  @override
  String get dialog_next => '下一步';

  @override
  String get dialog_skip => '跳过';

  @override
  String get malatype_regular => '常规';

  @override
  String get malatype_crystal => '水晶';

  @override
  String get malatype_royal => '皇家金';

  @override
  String get profile_abandon => '放弃誓愿';

  @override
  String get profile_progress => '进度';

  @override
  String get profile_deadline => '截止日期';

  @override
  String get profile_achieved => '已达成！';

  @override
  String get support_donate => '捐赠';

  @override
  String get support_paymentSucc => '由 Razorpay 安全处理付款';

  @override
  String get support_thank => '🙏 谢谢';

  @override
  String get home_customizeMala => '自定义念珠';

  @override
  String get appTitle => 'Moksha Mala Jaap';

  @override
  String get login_welcome => '欢迎来到 Moksha Mala Jaap';

  @override
  String get profile_shareApp => '分享 Moksha Mala Jaap';

  @override
  String get profile_supportTitle => '支持 Moksha Mala Jaap';

  @override
  String get dialog_updateDesc => 'Moksha Mala Jaap 有包含重要更新的新版本。请更新应用以继续。';

  @override
  String get support_desc =>
      'Moksha Mala Jaap 是由一位独立开发者倾心打造的应用。您的无私奉献 (Seva) 有助于维持服务器运行、减少广告，并让所有信徒免费使用此应用。';

  @override
  String get support_title => '支持 Moksha Mala Jaap 项目';

  @override
  String get support_afterTitile => '感谢您支持 Moksha Mala Jaap — 每一份贡献都有帮助。';
}
