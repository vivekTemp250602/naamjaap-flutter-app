import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/locale_provider.dart';
import 'package:naamjaap/screens/language_selector_page.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:naamjaap/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final StorageService _storageService = StorageService();
  final NotificationService _notificationService = NotificationService();
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  bool _isAmbianceEnabled = false;
  bool _areRemindersEnabled = false;
  bool _isDeleting = false;

  static const String _screenName = 'setting';
  final AdService _adService = AdService();

  final List<Map<String, dynamic>> notificationLanguages = [
    {'name': 'English', 'locale': const Locale('en')},
    {'name': 'हिन्दी', 'locale': const Locale('hi')},
    {'name': 'संस्कृतम्', 'locale': const Locale('sa')}, // Assuming 'sa'
  ];

  @override
  void initState() {
    super.initState();
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
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final userDoc = await _firestoreService.getUserDocument(_uid);
    if (!userDoc.exists) return;

    final userData = userDoc.data() as Map<String, dynamic>;
    final settings = userData['settings'] as Map<String, dynamic>? ?? {};

    if (mounted) {
      setState(() {
        _isAmbianceEnabled = prefs.getBool('isAmbianceEnabled') ?? false;
        _areRemindersEnabled = settings['enableReminders'] ?? false;
      });
    }
  }

  Future<void> _updateUserPreferences() async {
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

  Future<void> _toggleAmbiance(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAmbianceEnabled', value);
    setState(() {
      _isAmbianceEnabled = value;
    });
    if (value) {
      AudioService().startAmbientSound('assets/audio/temple_bells.mp3');
    } else {
      AudioService().stopAmbientSound();
    }
  }

  Future<void> _toggleReminders(bool value) async {
    setState(() {
      _areRemindersEnabled = value;
    });
    await _updateUserPreferences();
  }

  Future<void> _signOut() async {
    await AudioService().stop();
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  // Add the function to launch the Google Form URL.
  Future<void> _launchFeedbackForm() async {
    // IMPORTANT: Replace the URL below with the actual link to YOUR Google Form.
    final Uri feedbackUri = Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSemtDuaiggPyF-cvUgKQqS3NxlB6LZyHFBc_cvXN6ZIbVLr_w/viewform?usp=header');

    if (!await launchUrl(feedbackUri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open feedback form.')),
        );
      }
    }
  }

  //  Privacy pages.
  Future<void> _launchPrivacyPolicy() async {
    final Uri url = Uri.parse('https://vivekTemp250602.github.io/privacy.html');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Handle error
    }
  }

  // Terms and conditions pages
  Future<void> _launchTerms() async {
    final Uri url = Uri.parse('https://vivektemp250602.github.io/terms.html');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Handle error
    }
  }

  Future<void> _showDeleteAccountDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.dialog_deleteTitle),
            content: Text(AppLocalizations.of(context)!.dialog_deleteBody),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.dialog_cancel),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              // The delete button is styled to be dangerous.
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  AppLocalizations.of(context)!.dialog_deleteConfirm,
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog
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
        // User cancelled the re-authentication
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

      // Now that the user is re-authenticated, we can proceed with deletion.
      // The order is important: data first, then the account.
      await _firestoreService.deleteUser(_uid);
      await _storageService.deleteUserProfilePicture(_uid);
      await FirebaseAuth.instance.currentUser!.delete();

      // The sign out happens automatically after deletion, handled by our auth listener.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('An error occurred. Please try again. Error: $e')),
        );
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bannerAd = _adService.getAdForScreen(_screenName);

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings_title),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
            stream: _firestoreService.getUserStatsStream(_uid),
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                return const Center(child: CircularProgressIndicator());
              }
              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>;
              final bool isPremium = userData['isPremium'] ?? false;
              // final String uid = FirebaseAuth.instance.currentUser!.uid;
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            // --- App Settings Card ---
                            Card(
                              child: Column(children: [
                                SwitchListTile(
                                  title: Text(AppLocalizations.of(context)!
                                      .settings_ambiance),
                                  subtitle: Text(AppLocalizations.of(context)!
                                      .settings_ambianceDesc),
                                  secondary: const Icon(Icons.waves_rounded),
                                  value: _isAmbianceEnabled,
                                  onChanged: _toggleAmbiance,
                                ),

                                // Divider
                                const Divider(
                                    height: 1, indent: 16, endIndent: 16),

                                // Daily Remainder
                                SwitchListTile(
                                  title: Text(AppLocalizations.of(context)!
                                      .settings_reminders),
                                  subtitle: Text(AppLocalizations.of(context)!
                                      .settings_remindersDesc),
                                  secondary:
                                      const Icon(Icons.notifications_outlined),
                                  value: _areRemindersEnabled,
                                  onChanged: _toggleReminders,
                                ),
                              ]),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            // Language Button
                            Card(
                              child: ListTile(
                                leading: const Icon(Icons.language),
                                title: Text(AppLocalizations.of(context)!
                                    .settings_language),
                                subtitle: Text(
                                    Provider.of<LocaleProvider>(context)
                                            .locale
                                            ?.languageCode
                                            .toUpperCase() ??
                                        AppLocalizations.of(context)!
                                            .localeName
                                            .toUpperCase()),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LanguageSelectorPage(
                                        uid: _uid,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 20),

                            // --- Legal & Support Card ---
                            Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: _launchFeedbackForm,
                                    leading: const Icon(Icons.feedback_outlined,
                                        color: Colors.blueGrey),
                                    title: Text(AppLocalizations.of(context)!
                                        .settings_feedback),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16),
                                  ),

                                  const Divider(
                                      height: 1, indent: 16, endIndent: 16),

                                  // Privacy
                                  ListTile(
                                    onTap: _launchPrivacyPolicy,
                                    leading: const Icon(
                                        Icons.privacy_tip_outlined,
                                        color: Colors.green),
                                    title: Text(AppLocalizations.of(context)!
                                        .settings_privacy),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16),
                                  ),

                                  const Divider(
                                      height: 1, indent: 16, endIndent: 16),

                                  // Terms
                                  ListTile(
                                    onTap: _launchTerms,
                                    leading: const Icon(Icons.gavel_outlined,
                                        color: Colors.black54),
                                    title: Text(AppLocalizations.of(context)!
                                        .settings_terms),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16),
                                  ),
                                ],
                              ),
                            ),

                            // Space
                            const SizedBox(height: 20),

                            // --- Account Actions Card ---
                            Card(
                              child: ListTile(
                                onTap: _showDeleteAccountDialog,
                                leading: Icon(Icons.delete_forever_outlined,
                                    color: Colors.red.shade400),
                                title: Text(
                                    AppLocalizations.of(context)!
                                        .settings_deleteAccount,
                                    style:
                                        TextStyle(color: Colors.red.shade400)),
                              ),
                            ),

                            // Space
                            const SizedBox(height: 32),

                            // Sign Out
                            ElevatedButton.icon(
                              icon: const Icon(Icons.logout),
                              label: Text(AppLocalizations.of(context)!
                                  .settings_signOut),
                              onPressed: _signOut,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade400,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Indicator
                      if (_isDeleting)
                        Container(
                          color: Colors.black.withAlpha(130),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                    color: Colors.white),
                                const SizedBox(height: 16),
                                Text(
                                    AppLocalizations.of(context)!
                                        .settings_deletingAccount,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),

                      if (bannerAd != null &&
                          !isPremium &&
                          _adService.isAdLoadedForScreen(_screenName))
                        Container(
                          alignment: Alignment.center,
                          width: bannerAd.size.width.toDouble(),
                          height: bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: bannerAd),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}
