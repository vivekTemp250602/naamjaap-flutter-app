import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naamjaap/screens/main_app_screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSigningIn = false;

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
            'japps': {}, // Empty map for future detailed tracking
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // A beautiful gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
              Theme.of(context).colorScheme.background,
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
                // Your App Logo
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 120,
                  // Add a subtle shadow to the logo
                  semanticLabel: 'Naam Jaap Logo',
                ),
                const SizedBox(height: 24),
                // Welcome Text
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
                      ?.copyWith(color: Colors.white.withOpacity(0.9)),
                ),
                const Spacer(),
                // Sign-In Button
                _isSigningIn
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : ElevatedButton.icon(
                        icon: Image.asset('assets/images/google_logo.png',
                            height: 24), // A nice Google logo
                        label: const Text('Sign in with Google'),
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
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
