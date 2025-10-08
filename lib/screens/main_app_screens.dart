// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';
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

class MainAppScreens extends StatefulWidget {
  final User user;
  const MainAppScreens({super.key, required this.user});

  @override
  State<MainAppScreens> createState() => _MainAppScreensState();
}

class _MainAppScreensState extends State<MainAppScreens> {
  int _currentIndex = 0;
  DateTime? _lastBackPressed;

  late final List<Widget> _screens;
  late final List<Widget> _screenTitles;
  late final StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      LeaderboardScreen(),
      WisdomScreen(),
      ProfileScreen(),
    ];

    _screenTitles = [
      const Text('Home'),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events_outlined, color: Colors.amber.shade300),
          const SizedBox(width: 8),
          const Text('Leaderboard'),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/peacock_feather.png',
              height: 24), // Assuming you have a feather icon
          const SizedBox(width: 8),
          const Text('Wisdom'),
        ],
      ),
      const Text('My Profile'),
    ];

    NotificationService().initialize(widget.user.uid);

    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null && mounted) {
        // If the user signs out, navigate back to the LoginScreen.
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              const SnackBar(content: Text('Press back again to exit')),
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
                  color: Colors.black.withOpacity(0.25),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.2),
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
            child: _screenTitles[_currentIndex],
          ),
          actions: [
            if (_currentIndex == 3)
              IconButton(
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
                },
                tooltip: 'Settings',
              ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
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
