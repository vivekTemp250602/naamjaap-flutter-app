import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naamjaap/services/ad_service.dart';
import 'package:naamjaap/services/audio_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/storage_service.dart';
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
  final String _uid = FirebaseAuth.instance.currentUser!.uid;
  bool _isAmbianceEnabled = false;
  bool _areRemindersEnabled = false;
  bool _isDeleting = false;

  static const String _screenName = 'setting';
  final AdService _adService = AdService();

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

    if (mounted) {
      setState(() {
        _isAmbianceEnabled = prefs.getBool('isAmbianceEnabled') ?? false;
        _areRemindersEnabled =
            userData['settings']?['enableReminders'] ?? false;
      });
    }
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
    await _firestoreService.updateReminderSetting(_uid, value);
    setState(() {
      _areRemindersEnabled = value;
    });
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
    final Uri url = Uri.parse(
        'https://vivekTemp250602.github.io/naamjaap-legal/privacy.html');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Handle error
    }
  }

  // Terms and conditions pages
  Future<void> _launchTerms() async {
    final Uri url = Uri.parse(
        'https://vivekTemp250602.github.io/naamjaap-legal/terms.html');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      // Handle error
    }
  }

  Future<void> _showDeleteAccountDialog() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Delete Account?'),
            content: const Text(
                'This action is permanent and cannot be undone. All your chanting data, achievements, and personal information will be permanently erased.\n\nAre you absolutely sure you want to proceed?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              // The delete button is styled to be dangerous.
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Yes, Delete My Account',
                  style: TextStyle(color: Colors.white),
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
          title: const Text('Settings'),
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
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        // --- App Settings Card ---
                        Card(
                          child: Column(
                            children: [
                              SwitchListTile(
                                title: const Text("Temple Ambiance"),
                                subtitle: const Text(
                                    "Play subtle background temple sounds."),
                                secondary: const Icon(Icons.waves_rounded),
                                value: _isAmbianceEnabled,
                                onChanged: _toggleAmbiance,
                              ),

                              // Divider
                              const Divider(
                                  height: 1, indent: 16, endIndent: 16),

                              // Daily Remainder
                              SwitchListTile(
                                title: const Text("Daily Reminders"),
                                subtitle: const Text(
                                    "Get a notification if you haven't chanted today."),
                                secondary:
                                    const Icon(Icons.notifications_outlined),
                                // THIS IS THE FIX: It now uses the correct state variable.
                                value: _areRemindersEnabled,
                                onChanged: _toggleReminders,
                              ),
                            ],
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
                                title: const Text("Feedback & Support"),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 16),
                              ),

                              const Divider(
                                  height: 1, indent: 16, endIndent: 16),

                              // Privacy
                              ListTile(
                                onTap: _launchPrivacyPolicy,
                                leading: const Icon(Icons.privacy_tip_outlined,
                                    color: Colors.green),
                                title: const Text("Privacy Policy"),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 16),
                              ),

                              const Divider(
                                  height: 1, indent: 16, endIndent: 16),

                              // Terms
                              ListTile(
                                onTap: _launchTerms,
                                leading: const Icon(Icons.gavel_outlined,
                                    color: Colors.black54),
                                title: const Text("Terms & Conditions"),
                                trailing: const Icon(Icons.arrow_forward_ios,
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
                            title: Text("Delete My Account",
                                style: TextStyle(color: Colors.red.shade400)),
                          ),
                        ),

                        // Space
                        const SizedBox(height: 32),

                        // Sign Out
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          label: const Text('Sign Out'),
                          onPressed: _signOut,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 16),
                            Text("Deleting your account...",
                                style: TextStyle(color: Colors.white)),
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
              );
            },
          ),
        ));
  }
}
