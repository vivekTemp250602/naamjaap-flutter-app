import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/screens/login_screen.dart';
import 'package:naamjaap/screens/tabs/home_screen.dart';
import 'package:naamjaap/screens/tabs/leaderboard_screen.dart';
import 'package:naamjaap/screens/tabs/profile_screen.dart';
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
  late final List<Widget> _screens;
  late final List<Widget> _screenTitles;
  late final StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();

    _screens = const [
      HomeScreen(),
      LeaderboardScreen(),
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
      const Text('My Profile'),
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withAlpha(20),
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
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
