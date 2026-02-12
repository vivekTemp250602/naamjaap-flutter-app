import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:naamjaap/screens/main_app_screens.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isLoading = false;

  late final AnimationController _particleController;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _particleController.dispose();
    super.dispose();
  }

  // --- AUTH LOGIC ---

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          // Create/Update user in Firestore
          await _firestoreService.createOrUpdateUser(userCredential.user!);

          if (mounted) {
            _navigateToHome(userCredential.user);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Failed: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleGuestLogin() {
    // No terms check needed anymore
    _navigateToHome(null);
  }

  void _navigateToHome(User? user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => MantraProvider(user?.uid ?? 'guest'),
          child: MainAppScreens(user: user),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // --- UI WIDGETS ---

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. DIVINE BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFCC80), // Light Saffron
                  Color(0xFFFF9800), // Deep Orange
                  Color(0xFFE65100), // Dark Ritual Orange
                ],
              ),
            ),
          ),

          // 2. RISING EMBERS
          Positioned.fill(
            child: CustomPaint(
              painter: EmberPainter(_particleController),
            ),
          ),

          // 3. HOLY AURA (Behind Logo)
          Positioned(
            top: size.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.2, 0.5, 1.0],
                  ),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1.2, 1.2),
                  duration: 3000.ms),
            ),
          ),

          // 4. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // APP LOGO
                Hero(
                  tag: 'app_logo',
                  child: Image.asset(
                    'assets/images/app_logo_simple.png',
                    width: 160,
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(
                    begin: 0,
                    end: -15,
                    duration: 2000.ms,
                    curve: Curves.easeInOut),

                const SizedBox(height: 20),

                // WELCOME TEXT
                Text(
                  l10n.login_welcome ?? "Welcome to Naam Jaap",
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4))
                      ]),
                ).animate().fade().slideY(begin: 0.3, end: 0),

                const Spacer(flex: 3),

                // 5. THE GLASS ALTAR (Login Area)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        border: Border(
                            top: BorderSide(
                                color: Colors.white.withOpacity(0.3))),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isLoading)
                            const CircularProgressIndicator(color: Colors.white)
                          else ...[
                            // GOOGLE SIGN IN BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                onPressed: _handleGoogleSignIn,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/google_logo.png',
                                        height: 24),
                                    const SizedBox(width: 12),
                                    Text(
                                      l10n.login_signInWithGoogle,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // DIVIDER OR
                            Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                        color: Colors.white.withOpacity(0.3))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text("OR",
                                      style: TextStyle(
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                ),
                                Expanded(
                                    child: Divider(
                                        color: Colors.white.withOpacity(0.3))),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // GUEST MODE BUTTON
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () => _handleGuestLogin(),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.temple_buddhist,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      "Prarambh (Continue as Guest)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // IMPLICIT TERMS FOOTER (The new addition)
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.4),
                                children: [
                                  TextSpan(
                                      text: l10n.login_termsAgreement ??
                                          "By continuing, you agree to the "),
                                  TextSpan(
                                    text: l10n.login_termsAndConditions ??
                                        "Terms & Conditions",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => _launchURL(
                                          'https://vivektemp250602.github.io/terms.html'),
                                  ),
                                  TextSpan(text: l10n.login_and ?? " and "),
                                  TextSpan(
                                    text: l10n.login_privacyPolicy ??
                                        "Privacy Policy",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => _launchURL(
                                          'https://vivektemp250602.github.io/privacy.html'),
                                  ),
                                  const TextSpan(text: "."),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ).animate().slideY(
                    begin: 1,
                    end: 0,
                    duration: 600.ms,
                    curve: Curves.easeOutQuart),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✨ CUSTOM PAINTER FOR RISING EMBERS
class EmberPainter extends CustomPainter {
  final AnimationController controller;
  final List<_Ember> embers = [];
  final math.Random random = math.Random();

  EmberPainter(this.controller) : super(repaint: controller) {
    for (int i = 0; i < 40; i++) {
      embers.add(_Ember(random));
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var ember in embers) {
      ember.update(size.height);
      paint.color = Colors.white.withOpacity(ember.opacity * 0.5);
      canvas.drawCircle(
          Offset(ember.x * size.width, ember.y), ember.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Ember {
  late double x;
  late double y;
  late double speed;
  late double size;
  late double opacity;
  final math.Random rnd;

  _Ember(this.rnd) {
    reset(true);
  }

  void reset(bool startRandomY) {
    x = rnd.nextDouble();
    y = startRandomY ? rnd.nextDouble() * 800 : 800 + rnd.nextDouble() * 100;
    speed = 0.2 + rnd.nextDouble() * 0.5;
    size = 1.0 + rnd.nextDouble() * 2.0;
    opacity = 0.1 + rnd.nextDouble() * 0.5;
  }

  void update(double height) {
    y -= speed;
    if (y < -10) reset(false);
  }
}
