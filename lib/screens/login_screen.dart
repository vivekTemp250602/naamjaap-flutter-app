import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigningIn = false;
  bool _hasAgreedToTerms = false;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
    });

    try {
      // 1. Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the sign-in, googleUser will be null
      if (googleUser == null) {
        setState(() {
          _isSigningIn = false;
        });
        return;
      }

      // 2. Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 3. Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Sign in to Firebase with the credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // 5. Create user document in Firestore if it doesn't exist
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final doc = await userDocRef.get();

        if (!doc.exists) {
          // Document does not exist, create it
          await userDocRef.set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'total_japps': 0,
            'japps': {},
            'isPremium': false,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        // 6. Navigate to the main app screen, PASSING THE USER OBJECT
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              // The user object is guaranteed not to be null here.
              builder: (context) => MainAppScreens(user: user),
            ),
          );
        }
      }
    } catch (e) {
      // Handle errors here
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing in: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  // Helper methods to launch your legal pages.
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Colors.brown.shade800;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withAlpha(190),
              Theme.of(context).colorScheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 120,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to Naam Jaap',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your personal digital chanting companion.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white.withAlpha(210)),
                ),
                const Spacer(),

                // NEW: The Terms and Conditions section.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _hasAgreedToTerms,
                      onChanged: (value) {
                        setState(() {
                          _hasAgreedToTerms = value ?? false;
                        });
                      },
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: textColor),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(color: textColor, fontSize: 14),
                          children: [
                            const TextSpan(
                                text: 'I have read and agree to the '),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchURL(
                                    'https://vivekTemp250602.github.io/naamjaap-legal/terms.html'),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => _launchURL(
                                    'https://vivekTemp250602.github.io/naamjaap-legal/privacy.html'),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // The Sign-In Button
                _isSigningIn
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : ElevatedButton.icon(
                        icon: Image.asset('assets/images/google_logo.png',
                            height: 24),
                        label: const Text('Sign in with Google'),
                        // MODIFIED: The button is disabled if the user hasn't agreed.
                        onPressed: _hasAgreedToTerms ? _signInWithGoogle : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          disabledBackgroundColor: Colors.white.withAlpha(129),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
