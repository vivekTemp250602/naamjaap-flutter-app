import 'package:flutter/material.dart';
import 'package:naamjaap/l10n/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      // Styling for the navigation bar
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange.shade800,
      unselectedItemColor: Colors.grey.shade600,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.nav_home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.leaderboard_outlined),
          activeIcon: const Icon(Icons.leaderboard),
          label: AppLocalizations.of(context)!.nav_leaderboard,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.auto_stories_outlined),
          activeIcon: const Icon(Icons.auto_stories),
          label: AppLocalizations.of(context)!.nav_wisdom,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.nav_profile,
        ),
      ],
    );
  }
}
