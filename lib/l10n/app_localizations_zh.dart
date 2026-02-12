// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Naam Jaap';

  @override
  String get login_welcome => '欢迎来到 Naam Jaap';

  @override
  String get login_subtitle => '您的个人数字诵经伴侣。';

  @override
  String get login_termsAgreement => '我已阅读并同意 ';

  @override
  String get login_termsAndConditions => '条款和条件';

  @override
  String get login_and => ' 和 ';

  @override
  String get login_privacyPolicy => '隐私政策';

  @override
  String get login_signInWithGoogle => '使用 Google 登录';

  @override
  String get nav_home => '主页';

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
  String get home_total => '总计：';

  @override
  String get home_mantraInfo => '真言信息';

  @override
  String get home_chooseMala => '选择您的念珠';

  @override
  String get home_chooseMalaDesc => '选择一种与您的精神产生共鸣的风格。';

  @override
  String get home_customizeMala => '自定义念珠';

  @override
  String get tour_home_carousel_title => '选择您的真言';

  @override
  String get tour_home_carousel_desc => '向左或向右滑动以切换强大的吠陀真言。';

  @override
  String get tour_home_mala_title => '点击诵经';

  @override
  String get tour_home_mala_desc => '点击圆圈上的任意位置移动念珠。完成 108 次为一串。';

  @override
  String get tour_home_toolkit_title => '您的工具箱';

  @override
  String get tour_home_toolkit_desc => '自定义念珠样式，切换音频或查看真言含义。';

  @override
  String get tour_leader_toggle_title => '每周 vs 历史';

  @override
  String get tour_leader_toggle_desc => '点击此处在每周领袖和历史传奇之间切换。';

  @override
  String get tour_leader_podium_title => '前 3 名';

  @override
  String get tour_leader_podium_desc => '最虔诚的诵经者会出现在这里。继续诵经以加入他们！';

  @override
  String get tour_wisdom_card_title => '每日智慧与分享';

  @override
  String get tour_wisdom_card_desc => '用新的颂歌开始新的一天。点击分享图标创建精美图片！';

  @override
  String get tour_profile_stats_title => '您的精神统计';

  @override
  String get tour_profile_stats_desc => '在此跟踪您的连续记录、总诵经数和全球排名。';

  @override
  String get tour_profile_offline_title => '实体诵经？';

  @override
  String get tour_profile_offline_desc => '如果您使用真实的念珠，请点击此处手动添加您的计数。';

  @override
  String get tour_profile_bodhi_desc => '您诵念的每一串念珠都有助于您的精神花园成长。随着进步解锁新树！';

  @override
  String get tour_profile_sankalpa_desc => '设定目标日期和计数以致力于精神目标。';

  @override
  String get guest_mode_title => '访客模式';

  @override
  String get guest_mode_desc => '登录以解锁您的精神档案。';

  @override
  String get guest_signin_btn => '登录';

  @override
  String get wisdom_title => '今日智慧';

  @override
  String get wisdom_dismissed => '今天的智慧已被沉思。\n新的见解将在明天到来。';

  @override
  String get wisdom_loading => '正在加载智慧...';

  @override
  String get wisdom_signin_to_share => '登录以分享卡片！';

  @override
  String get wisdom_creating_card => '正在创建您的神圣卡片...';

  @override
  String get leaderboard_allTime => '所有时间';

  @override
  String get leaderboard_thisWeek => '本周';

  @override
  String get leaderboard_yourProgress => '您的进度';

  @override
  String get leaderboard_yourRank => '您的排名';

  @override
  String leaderboard_jappsToPass(Object count, Object playerName) {
    return '还需 $count 次诵经才能超过 $playerName';
  }

  @override
  String leaderboard_malasToPass(Object count, Object playerName) {
    return '还需 $count 串念珠才能超过 $playerName';
  }

  @override
  String get leaderboard_empty => '旅程开始！';

  @override
  String get leaderboard_emptySubtitle => '成为第一个荣登排行榜的人！';

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
  String leaderboard_topMantra(String mantra) {
    return '热门真言：$mantra';
  }

  @override
  String get profile_yourProgress => '您的进度';

  @override
  String get profile_dailyStreak => '每日连续';

  @override
  String get profile_totalJapps => '总诵经数';

  @override
  String get profile_globalRank => '全球排名';

  @override
  String get profile_mantraTotals => '真言总数';

  @override
  String get profile_achievements => '成就';

  @override
  String get profile_shareProgress => '分享进度';

  @override
  String get profile_badgesEmpty => '开始诵经以获得您的第一个徽章！';

  @override
  String get profile_mantrasEmpty => '开始诵经以在此查看您的总数！';

  @override
  String get profile_rateApp => '评价我们的应用';

  @override
  String get profile_supportTitle => '支持 Naam Jaap';

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
  String get profile_shareApp => '分享 Naam Jaap';

  @override
  String get profile_yourCustomMantra => '我的自定义真言';

  @override
  String get profile_noCustoms => '您尚未添加任何自定义真言。';

  @override
  String get profile_addNewMantra => '添加新真言';

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
  String get profile_offline_card_title => '记录离线诵经';

  @override
  String get profile_offline_card_subtitle => '从您的实体念珠添加计数';

  @override
  String get profile_gamification_header => '游戏化';

  @override
  String get profile_commitments_header => '承诺';

  @override
  String get profile_insights_header => '真言洞察';

  @override
  String get profile_my_mantras_header => '我的真言';

  @override
  String get profile_quick_actions_header => '快速操作';

  @override
  String get profile_sankalpaSet => '立下神圣誓愿';

  @override
  String get profile_sankalpaSubtitle => '设定个人诵经目标。';

  @override
  String get profile_sankalpaTitle => '您的持咒誓愿';

  @override
  String get profile_sankalpaChanting => '正在诵经';

  @override
  String get profile_abandon => '放弃誓愿';

  @override
  String get profile_progress => '进度';

  @override
  String get profile_deadline => '截止日期';

  @override
  String get profile_achieved => '已达成！';

  @override
  String profile_sankalpaToReach(int targetCount) {
    return ' 以达到 $targetCount 次。';
  }

  @override
  String profile_sankalpaByDate(String date) {
    return '截至 $date';
  }

  @override
  String get settings_title => '设置';

  @override
  String get settings_ambiance => '寺庙氛围';

  @override
  String get settings_ambianceDesc => '播放微妙的寺庙声音。';

  @override
  String get settings_reminders => '每日提醒';

  @override
  String get settings_remindersDesc => '如果您今天没有诵经，请接收通知。';

  @override
  String get settings_language => '应用语言';

  @override
  String get settings_feedback => '反馈与支持';

  @override
  String get settings_feedbackDesc => '报告错误或建议功能。';

  @override
  String get settings_deletingAccount => '正在删除您的帐户...';

  @override
  String get settings_privacy => '隐私政策';

  @override
  String get settings_terms => '条款和条件';

  @override
  String get settings_deleteAccount => '删除我的帐户';

  @override
  String get settings_signOut => '登出';

  @override
  String get settings_exit_guest => '退出访客模式';

  @override
  String get settings_support_header => '支持与法律';

  @override
  String get settings_account_header => '帐户';

  @override
  String get support_title => '支持 Naam Jaap 项目';

  @override
  String get support_desc =>
      'Naam Jaap 是由一位独立开发者倾心打造的应用。您的无私奉献 (Seva) 有助于维持服务器运行、减少广告，并让所有信徒免费使用此应用。';

  @override
  String get support_afterTitile => '感谢您支持 Naam Jaap — 每一份贡献都有帮助。';

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
  String get support_donate => '捐赠';

  @override
  String get support_paymentSucc => '由 Razorpay 安全处理付款';

  @override
  String get support_thank => '🙏 谢谢';

  @override
  String get support_offer_seva => '提供 Seva';

  @override
  String get support_signin_required => '请登录以捐款。';

  @override
  String get support_payment_error => '无法开始付款。请重试。';

  @override
  String get support_blessed => '愿您受保佑。';

  @override
  String get support_tier_flower => '鲜花供养';

  @override
  String get support_tier_lamp => '点灯';

  @override
  String get support_tier_garland => '花环 Seva';

  @override
  String get support_tier_temple => '寺庙支持';

  @override
  String get support_tier_grand => '大供养';

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
  String get custom_preview => '预览';

  @override
  String get custom_voice_saved => '语音备忘录已保存';

  @override
  String get custom_tap_record => '点击录音';

  @override
  String get custom_ready_use => '可以使用';

  @override
  String get custom_error_empty_name => '请输入真言名称';

  @override
  String get garden_title => '菩提花园';

  @override
  String get garden_subtitle => '培育您的精神森林';

  @override
  String get garden_growth => '精神成长';

  @override
  String get garden_totalMala => '完成的念珠';

  @override
  String get dialog_deleteTitle => '删除帐户？';

  @override
  String get dialog_deleteBody =>
      '此操作是永久性的，无法撤消。您的所有诵经数据、成就和个人信息将被永久删除。\n\n您确定要继续吗？';

  @override
  String get dialog_deleteConfirm => '是的，删除我的帐户';

  @override
  String get dialog_continue => '继续';

  @override
  String get dialog_pressBack => '再按一次返回键退出';

  @override
  String get dialog_update => '需要更新';

  @override
  String get dialog_updateDesc => 'Naam Jaap 有包含重要更新的新版本。请更新应用以继续。';

  @override
  String get dialog_updateNow => '立即更新';

  @override
  String get dialog_save => '保存';

  @override
  String get dialog_close => '关闭';

  @override
  String get dialog_something => '出错了。';

  @override
  String get dialog_cancel => '取消';

  @override
  String get dialog_profilePictureUpdate => '个人资料图片已更新！';

  @override
  String get dialog_failedToUpload => '上传图片失败。';

  @override
  String get dialog_exceptionCard => '可共享卡片上下文不可用。';

  @override
  String get dialog_couldNotOpenPS => '无法打开 Play 商店。';

  @override
  String get dialog_mic => '录制音频需要麦克风权限。';

  @override
  String get dialog_getStarted => '开始';

  @override
  String get dialog_next => '下一步';

  @override
  String get dialog_skip => '跳过';

  @override
  String get dialog_checkoutMyProgress => '在 Naam Jaap 应用上查看我的进度！';

  @override
  String get dialog_sankalpaTitle => '设定您的持咒誓愿';

  @override
  String get dialog_sankalpaSelectMantra => '选择真言';

  @override
  String get dialog_sankalpaTargetCount => '目标次数（例如 11000）';

  @override
  String get dialog_sankalpaTargetDate => '目标日期';

  @override
  String get dialog_sankalpaSelectDate => '选择日期';

  @override
  String get dialog_sankalpaSetPledge => '立下我的誓愿';

  @override
  String get dialog_sankalpaError => '请正确填写所有字段。';

  @override
  String get dialog_sankalpaErrorTarget => '目标次数必须大于您当前的次数。';

  @override
  String get misc_japps => '次诵经';

  @override
  String get misc_days => '天';

  @override
  String get misc_badge => '徽章';

  @override
  String get misc_malas => '念珠';

  @override
  String get misc_anonymous => '匿名';

  @override
  String get lang_chooseLang => '选择您偏好的语言以继续';

  @override
  String get lang_searchLang => '搜索语言';

  @override
  String get malatype_regular => '常规';

  @override
  String get malatype_crystal => '水晶';

  @override
  String get malatype_royal => '皇家金';
}
