import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:naamjaap/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPermissionPrompt extends StatelessWidget {
  const NotificationPermissionPrompt({super.key});

  static const String _prefKey = 'notif_prompt_shown';

  /// Call from HomeScreen.initState via addPostFrameCallback.
  /// Shows the sheet once and never again.
  static Future<void> showIfNeeded(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyShown = prefs.getBool(_prefKey) ?? false;
    if (alreadyShown) return;

    // Mark as shown immediately so even if user force-quits,
    // we don't show it again.
    await prefs.setBool(_prefKey, true);

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => const NotificationPermissionPrompt(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5D1049), // Deep spiritual maroon
                  Color(0xFF8B2500), // Rich saffron-brown
                  Color(0xFF1A0A00), // Near-black base
                ],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Decorative top handle ──
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700).withOpacity(0.35),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 32),

                // ── Animated Bell Icon ──
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFFAA20).withOpacity(0.28),
                        const Color(0xFFFF6B00).withOpacity(0.10),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: Color(0xFFFFD700),
                    size: 48,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scale(
                      begin: const Offset(0.92, 0.92),
                      end: const Offset(1.08, 1.08),
                      duration: 1800.ms,
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .shimmer(
                      color: const Color(0xFFFFD700).withOpacity(0.5),
                      duration: 1200.ms,
                    ),

                const SizedBox(height: 24),

                // ── Title ──
                const Text(
                  'Keep Your Jaap Streak Alive! 📿',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.3,
                    height: 1.3,
                    shadows: [
                      Shadow(
                        color: Color(0x88000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Description ──
                Text(
                  'Get gentle morning & evening reminders to complete your daily Naam Jaap — so your sadhana stays consistent, even on busy days.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.72),
                    height: 1.55,
                    letterSpacing: 0.2,
                  ),
                ),

                const SizedBox(height: 10),

                // ── Reminder times badge ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _timeBadge('🌅 6:30 AM'),
                    const SizedBox(width: 12),
                    _timeBadge('🌙 6:00 PM'),
                  ],
                ),

                const SizedBox(height: 30),

                // ── Primary CTA ──
                SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFCC44), Color(0xFFC8860A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFC8860A).withOpacity(0.45),
                          blurRadius: 18,
                          spreadRadius: 0,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.notifications_active_rounded,
                          color: Colors.white, size: 20),
                      label: const Text(
                        'Enable Reminders',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        // Trigger the native OS permission prompt
                        final granted =
                            await LocalNotificationService().requestPermissions();
                        if (granted) {
                          // Schedule the daily reminders once permission is granted.
                          // Default: enabled with sound. User can adjust in Settings.
                          await LocalNotificationService().scheduleDailyReminders(
                            isEnabled: true,
                            enableSound: true,
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Secondary: Maybe Later ──
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white38,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Maybe Later',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFD700).withOpacity(0.22),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.80),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
