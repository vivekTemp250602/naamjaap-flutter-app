import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // We only need to call our one "captain" pilot function.
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // A small delay to show your beautiful splash screen.
    await Future.delayed(const Duration(seconds: 3));

    // This is the "Gatekeeper" logic. It runs after the splash screen is shown.
    if (mounted) await _checkVersionAndNavigate();
  }

  Future<void> _checkVersionAndNavigate() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    // 1. Get the minimum required version from the server.
    final int minVersion = remoteConfig.getInt('min_required_version_code');

    // 2. Get the version of the app currently running on the user's phone.
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final int currentVersion = int.parse(packageInfo.buildNumber);

    // 3. The Critical Comparison
    if (currentVersion < minVersion) {
      // If the user's app is outdated, show the "Force Update" dialog.
      if (mounted) _showUpdateDialog();
    } else {
      // If the app is up-to-date, proceed with the normal navigation.
      if (mounted) _navigateUser();
    }
  }

  void _navigateUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainAppScreens(user: user)));
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User cannot dismiss this dialog
      builder: (context) => AlertDialog(
        title: const Text('Update Required'),
        content: const Text(
            'A new version of Naam Jaap is available with important updates. Please update the app to continue.'),
        actions: [
          TextButton(
            onPressed: () {
              // This will open your app's page on the Google Play Store
              launchUrl(
                Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.vivek.naamjaap"),
                mode: LaunchMode.externalApplication,
              );
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  // This is your beautiful, custom build method. It is perfect.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png', width: 150),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
