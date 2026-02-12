import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naamjaap/l10n/app_localizations.dart'; // Ensure imported
import 'package:naamjaap/providers/locale_provider.dart';
import 'package:naamjaap/screens/language_selector_page.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:naamjaap/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

// ... [Keep SettingsSparkles and _Sparkle classes exactly as they are] ...
class SettingsSparkles extends CustomPainter {
  final AnimationController controller;
  final List<_Sparkle> sparkles = [];
  final math.Random random = math.Random();

  SettingsSparkles(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 20; i++) {
      sparkles.add(_Sparkle(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var s in sparkles) {
      s.update(size.height);
      paint.color = Colors.white.withOpacity(s.opacity * 0.3);
      canvas.drawCircle(Offset(s.x * size.width, s.y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Sparkle {
  late double x;
  late double y;
  late double speed;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Sparkle(this.rnd) {
    reset(true);
  }

  void reset(bool startRandomY) {
    x = rnd.nextDouble();
    y = startRandomY ? rnd.nextDouble() * 400 : 400 + rnd.nextDouble() * 50;
    speed = 0.2 + rnd.nextDouble() * 0.5;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height) {
    y -= speed;
    if (y < -10) reset(false);
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final NotificationService _notificationService = NotificationService();

  late final String _uid;
  late final bool _isGuest;
  late final AnimationController _particleController;

  bool _isAmbianceEnabled = false;
  bool _areRemindersEnabled = false;
  bool _isDeleting = false;

  static const String _screenName = 'setting';
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    _isGuest = user == null;
    _uid = user?.uid ?? 'guest';

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _adService.loadAdForScreen(
        screenName: _screenName,
        onAdLoaded: () {
          if (mounted) setState(() {});
        });

    _loadSettings();
  }

  @override
  void dispose() {
    _adService.disposeAdForScreen(_screenName);
    _particleController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        _isAmbianceEnabled = prefs.getBool('isAmbianceEnabled') ?? false;
      });
    }

    if (_isGuest) return;

    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final settings = userData['settings'] as Map<String, dynamic>? ?? {};

    if (mounted) {
      setState(() {
        _areRemindersEnabled = settings['enableReminders'] ?? false;
      });
    }
  }

  Future<void> _updateUserPreferences() async {
    if (_isGuest) return;

    final langCode = Provider.of<LocaleProvider>(context, listen: false)
            .locale
            ?.languageCode ??
        'en';
    final bool isEnabled = _areRemindersEnabled;

    await _notificationService.updateNotificationPreferences(
      language: langCode,
      isEnabled: isEnabled,
    );

    await _firestoreService.updateUserSettings(_uid, {
      'enableReminders': isEnabled,
      'notificationLanguage': langCode,
    });
  }

  Future<void> _toggleReminders(bool value) async {
    setState(() {
      _areRemindersEnabled = value;
    });
    await _updateUserPreferences();
  }

  Future<void> _signOut() async {
    try {
      await AudioService().stopMantra();
    } catch (e) {}

    if (!_isGuest) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _launchFeedbackForm() async {
    final Uri feedbackUri = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSemtDuaiggPyF-cvUgKQqS3NxlB6LZyHFBc_cvXN6ZIbVLr_w/viewform?usp=header');
    if (!await launchUrl(feedbackUri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          // LOC: Could not open feedback
          const SnackBar(content: Text('Could not open feedback form.')),
        );
      }
    }
  }

  Future<void> _launchPrivacyPolicy() async {
    final Uri url = Uri.parse('https://vivekTemp250602.github.io/privacy.html');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _launchTerms() async {
    final Uri url = Uri.parse('https://vivektemp250602.github.io/terms.html');
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _showDeleteAccountDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            // LOC: Delete Title
            title: Text(AppLocalizations.of(context)!.dialog_deleteTitle),
            // LOC: Delete Body
            content: Text(AppLocalizations.of(context)!.dialog_deleteBody),
            actions: <Widget>[
              TextButton(
                // LOC: Cancel
                child: Text(AppLocalizations.of(context)!.dialog_cancel),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                // LOC: Confirm Delete
                child: Text(
                  AppLocalizations.of(context)!.dialog_deleteConfirm,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  _deleteAccount();
                },
              ),
            ],
          );
        });
  }

  Future<void> _deleteAccount() async {
    setState(() => _isDeleting = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isDeleting = false);
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      await _firestoreService.deleteUser(_uid);
      await _storageService.deleteUserProfilePicture(_uid);
      await FirebaseAuth.instance.currentUser!.delete();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        setState(() => _isDeleting = false);
      }
    }
  }

  // --- UI WIDGETS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Colors.grey.shade500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // ... [Keep _buildSettingsCard as is] ...
  Widget _buildSettingsCard(
      {required List<Widget> children, bool overlap = false}) {
    return SliverToBoxAdapter(
      child: Transform.translate(
        offset: overlap ? const Offset(0, 10) : Offset.zero,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(children: children),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.1, end: 0, curve: Curves.easeOut),
      ),
    );
  }

  // ... [Keep _buildSwitchTile and _buildActionTile as is] ...
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
    Color activeColor = Colors.deepOrange,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: activeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: activeColor),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(subtitle,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
    );
  }

  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    String? subtitle,
    Color iconColor = Colors.grey,
    bool showArrow = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13))
          : null,
      trailing: showArrow
          ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
          : null,
    );
  }

  Widget _buildHeader() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFF8C00), Color(0xFFFF5E62), Color(0xFF6A0572)],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
        ),
        CustomPaint(painter: SettingsSparkles(_particleController)),
        SafeArea(
          child: Center(
            child: Text(
              // LOC: Settings Title
              AppLocalizations.of(context)!.settings_title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // 1. DIVINE HEADER (Sliver)
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                stretch: true,
                backgroundColor: const Color(0xFFFF5E62),
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeader(),
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground
                  ],
                ),
              ),

              // 2. PREFERENCES (Overlapping Card)
              _buildSettingsCard(
                overlap: true, // PULLS IT UP
                children: [
                  if (!_isGuest) ...[
                    Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: Colors.grey.shade100),
                    _buildSwitchTile(
                      // LOC: Reminders
                      title: AppLocalizations.of(context)!.settings_reminders,
                      subtitle:
                          AppLocalizations.of(context)!.settings_remindersDesc,
                      icon: Icons.notifications_active_rounded,
                      value: _areRemindersEnabled,
                      onChanged: _toggleReminders,
                      activeColor: Colors.amber.shade800,
                    ),
                  ],
                  Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade100),
                  _buildActionTile(
                    // LOC: Language
                    title: AppLocalizations.of(context)!.settings_language,
                    subtitle: Provider.of<LocaleProvider>(context)
                            .locale
                            ?.languageCode
                            .toUpperCase() ??
                        AppLocalizations.of(context)!.localeName.toUpperCase(),
                    icon: Icons.language_rounded,
                    iconColor: Colors.purple,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LanguageSelectorPage(uid: _uid))),
                  ),
                ],
              ),

              // 3. SUPPORT & LEGAL
              // LOC: Support Header
              SliverToBoxAdapter(
                  child: _buildSectionHeader(
                      AppLocalizations.of(context)!.settings_support_header)),
              _buildSettingsCard(
                children: [
                  _buildActionTile(
                    // LOC: Feedback
                    title: AppLocalizations.of(context)!.settings_feedback,
                    icon: Icons.feedback_rounded,
                    iconColor: Colors.teal,
                    onTap: _launchFeedbackForm,
                  ),
                  Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade100),
                  _buildActionTile(
                    // LOC: Privacy
                    title: AppLocalizations.of(context)!.settings_privacy,
                    icon: Icons.privacy_tip_rounded,
                    iconColor: Colors.green,
                    onTap: _launchPrivacyPolicy,
                  ),
                  Divider(
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                      color: Colors.grey.shade100),
                  _buildActionTile(
                    // LOC: Terms
                    title: AppLocalizations.of(context)!.settings_terms,
                    icon: Icons.gavel_rounded,
                    iconColor: Colors.brown,
                    onTap: _launchTerms,
                  ),
                ],
              ),

              // 4. ACCOUNT / DANGER ZONE
              if (!_isGuest) ...[
                // LOC: Account Header
                SliverToBoxAdapter(
                    child: _buildSectionHeader(
                        AppLocalizations.of(context)!.settings_account_header)),
                _buildSettingsCard(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      onTap: _showDeleteAccountDialog,
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.delete_forever_rounded,
                            color: Colors.red.shade400),
                      ),
                      // LOC: Delete Account
                      title: Text(
                        AppLocalizations.of(context)!.settings_deleteAccount,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.red),
                    ),
                  ],
                ),
              ],

              // 5. SIGN OUT BUTTON & AD
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.logout_rounded),
                        // LOC: Sign Out / Exit Guest
                        label: Text(_isGuest
                            ? AppLocalizations.of(context)!.settings_exit_guest
                            : AppLocalizations.of(context)!.settings_signOut),
                        onPressed: _signOut,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.red.shade100)),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (bannerAd != null &&
                          _adService.isAdLoadedForScreen(_screenName))
                        Container(
                          alignment: Alignment.center,
                          width: bannerAd.size.width.toDouble(),
                          height: bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: bannerAd),
                        ),
                      const SizedBox(height: 65),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Loading Overlay
          if (_isDeleting)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(color: Colors.white),
                    const SizedBox(height: 20),
                    // LOC: Deleting
                    Text(AppLocalizations.of(context)!.settings_deletingAccount,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.none)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
