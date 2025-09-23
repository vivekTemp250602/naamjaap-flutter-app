import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> checkAndAwardBadges(String uid) async {
    final userRef = _db.collection('users').doc(uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) return;

    final userData = snapshot.data() as Map<String, dynamic>;
    List<String> currentBadges = List<String>.from(userData['badges'] ?? []);
    List<String> newBadges = [];
    int totalJapps = userData['total_japps'] ?? 0;

    // --- Define and check for badges ---

    // Milestone Badges
    if (totalJapps >= 108 && !currentBadges.contains('First Mala')) {
      newBadges.add('First Mala');
    }
    if (totalJapps >= 1008 && !currentBadges.contains('Pious Chanter')) {
      newBadges.add('Pious Chanter');
    }
    if (totalJapps >= 10008 && !currentBadges.contains('Devout Follower')) {
      newBadges.add('Devout Follower');
    }

    // --- 2. NEW: Check for Daily Streak Milestones ---
    int currentStreak = userData['currentStreak'] ?? 0;

    if (currentStreak >= 7 && !currentBadges.contains('7-Day Streak')) {
      newBadges.add('7-Day Streak');
    }
    if (currentStreak >= 30 && !currentBadges.contains('30-Day Devotion')) {
      newBadges.add('30-Day Devotion');
    }
    if (currentStreak >= 108 && !currentBadges.contains('108-Day Pilgrim')) {
      newBadges.add('108-Day Pilgrim');
    }

    // If new badges were earned, update them in Firestore
    if (newBadges.isNotEmpty) {
      await userRef.update({
        'badges': FieldValue.arrayUnion(newBadges),
      });
    }
  }
}
