import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/tabs/home_screen.dart';
import 'package:naamjaap/screens/tabs/leaderboard_screen.dart';
import 'package:naamjaap/screens/tabs/profile_screen.dart';
import 'package:naamjaap/screens/tabs/settings_screen.dart';
import 'package:naamjaap/screens/tabs/wisdom_screen.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:naamjaap/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:naamjaap/providers/mantra_provider.dart';
import 'package:showcaseview/showcaseview.dart'; // 1. IMPORT THIS

class MainAppScreens extends StatefulWidget {
  final User? user;
  const MainAppScreens({super.key, this.user});

  @override
  State<MainAppScreens> createState() => _MainAppScreensState();
}

class _MainAppScreensState extends State<MainAppScreens> {
  int _currentIndex = 0;
  late final PageController _pageController;
  late final List<Widget> _screens;
  StreamSubscription<User?>? _authSubscription;
  DateTime? _lastBackPressed;

  bool get _isGuest => widget.user == null;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _screens = [
      HomeScreen(user: widget.user),
      LeaderboardScreen(user: widget.user),
      const WisdomScreen(),
      ProfileScreen(user: widget.user),
    ];

    if (widget.user != null) {
      NotificationService().initialize(widget.user!.uid);
    }

    if (!_isGuest) {
      _authSubscription =
          FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null && mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _authSubscription?.cancel();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
    );

    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MantraProvider(widget.user?.uid ?? 'guest'),
      // 2. WRAP EVERYTHING IN ShowCaseWidget
      child: ShowCaseWidget(
        builder: (context) => PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) return;
            if (_currentIndex != 0) {
              _onTabTapped(0);
            } else {
              final now = DateTime.now();
              if (_lastBackPressed == null ||
                  now.difference(_lastBackPressed!) >
                      const Duration(seconds: 2)) {
                _lastBackPressed = now;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Press back again to exit")),
                );
              } else {
                SystemNavigator.pop();
              }
            }
          },
          child: Scaffold(
            extendBody: true,
            body: Stack(
              fit: StackFit.expand,
              children: [
                PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: _screens,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomNavBar(
                    currentIndex: _currentIndex,
                    onTap: _onTabTapped,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
