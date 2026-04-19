import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Removed Align, handled by parent Stack
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Dark Glass
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_rounded, currentIndex == 0),
              _buildNavItem(1, Icons.emoji_events_rounded, currentIndex == 1),
              _buildNavItem(2, Icons.menu_book_rounded, currentIndex == 2),
              _buildNavItem(3, Icons.person_rounded, currentIndex == 3),
            ],
          ),
        ),
      ),
    )
        .animate()
        .slideY(begin: 1, end: 0, duration: 600.ms, curve: Curves.easeOutBack);
  }

  Widget _buildNavItem(int index, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              // CRITICAL FIX: Changed from easeOutBack to easeOutCubic
              // easeOutBack caused negative values for Shadow Blur -> CRASH
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                            color: Colors.white.withOpacity(0.4),
                            blurRadius: 10)
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.black : Colors.white.withOpacity(0.6),
                size: 24,
              ),
            )
                .animate(target: isActive ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),

            const SizedBox(height: 4),

            // Tiny Dot Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 4 : 0,
              height: isActive ? 4 : 0,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
