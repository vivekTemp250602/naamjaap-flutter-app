import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:naamjaap/l10n/app_localizations.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/tabs/home_screen.dart';
import 'package:naamjaap/screens/tabs/leaderboard_screen.dart';
import 'package:naamjaap/screens/tabs/profile_screen.dart';
import 'package:naamjaap/screens/tabs/settings_screen.dart';
import 'package:naamjaap/screens/tabs/wisdom_screen.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:naamjaap/widgets/bottom_nav_bar.dart';

class MainAppScreens extends StatefulWidget {
  final User user;
  const MainAppScreens({super.key, required this.user});

  @override
  State<MainAppScreens> createState() => _MainAppScreensState();
}

class _MainAppScreensState extends State<MainAppScreens> {
  int _currentIndex = 0;
  late final PageController _pageController;
  late final List<Widget> _screens;
  late final StreamSubscription<User?> _authSubscription;
  DateTime? _lastBackPressed;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _screens = const [
      HomeScreen(),
      LeaderboardScreen(),
      WisdomScreen(),
      ProfileScreen(),
    ];

    NotificationService().initialize(widget.user.uid);
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null && mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // We build the titles list here, where the context is safe.
    final l10n = AppLocalizations.of(context)!;
    final List<Widget> screenTitles = [
      Text(l10n.nav_home),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events_outlined, color: Colors.amber.shade300),
          const SizedBox(width: 8),
          Text(l10n.nav_leaderboard),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/peacock_feather.png', height: 24),
          const SizedBox(width: 8),
          Text(l10n.nav_wisdom),
        ],
      ),
      Text(l10n.nav_profile),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        } else {
          final now = DateTime.now();
          if (_lastBackPressed == null ||
              now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
            _lastBackPressed = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.dialog_pressBack)),
            );
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(45),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withAlpha(80),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: DefaultTextStyle(
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Colors.black54,
                    offset: Offset(1.0, 1.0),
                  )
                ]),
            child: screenTitles[_currentIndex],
          ),
          actions: [
            if (_currentIndex == 3) // Profile Screen
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {
                  // This context is now a child of the Provider,
                  // so the SettingsScreen can find it!
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                tooltip: 'Settings',
              ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
