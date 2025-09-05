import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/main_app_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // A short delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // Check if a user is currently signed in
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // If no user, go to LoginScreen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // If user is signed in, go to the main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainAppScreens(user: user)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // NEW: Add the app logo here
            Image.asset('assets/images/app_logo.png', width: 150),
            const SizedBox(height: 20),
            Text(
              'NaamJaap',
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
