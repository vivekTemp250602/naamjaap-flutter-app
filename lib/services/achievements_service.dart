import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class AchievementsService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _newBadgeStreamController = StreamController<String>.broadcast();
  Stream<String> get newBadgeStream => _newBadgeStreamController.stream;

  Future<void> checkAndAwardBadges(String uid) async {
    final userRef = _db.collection('users').doc(uid);
    final snapshot = await userRef.get();

    if (!snapshot.exists) return;

    final userData = snapshot.data() as Map<String, dynamic>;
    List<String> currentBadges = List<String>.from(userData['badges'] ?? []);
    List<String> newBadges = [];

    final totalJapps = userData['total_japps'] ?? 0;
    final currentStreak = userData['currentStreak'] ?? 0;
    final totalMalas = (totalJapps / 108).floor();

    // --- 1. Japa Count Milestones ---
    if (totalJapps >= 108 && !currentBadges.contains('First Mala')) {
      newBadges.add('First Mala');
    }
    if (totalJapps >= 1008 && !currentBadges.contains('Sahasranama')) {
      newBadges.add('Sahasranama');
    }
    if (totalJapps >= 10000 && !currentBadges.contains('Ten Thousand Steps')) {
      newBadges.add('Ten Thousand Steps');
    }
    if (totalJapps >= 100000 && !currentBadges.contains('Lakshya Chanter')) {
      newBadges.add('Lakshya Chanter');
    }
    if (totalJapps >= 1000000 &&
        !currentBadges.contains('Millionaire of Faith')) {
      newBadges.add('Millionaire of Faith');
    }

    // --- 2. Daily Streak Milestones ---
    if (currentStreak >= 7 && !currentBadges.contains('7-Day Sadhana')) {
      newBadges.add('7-Day Sadhana');
    }
    if (currentStreak >= 30 && !currentBadges.contains('30-Day Devotion')) {
      newBadges.add('30-Day Devotion');
    }
    if (currentStreak >= 108 && !currentBadges.contains('Sacred Centurion')) {
      newBadges.add('Sacred Centurion');
    }
    if (currentStreak >= 365 &&
        !currentBadges.contains('Solar Cycle of Faith')) {
      newBadges.add('Solar Cycle of Faith');
    }

    // --- 3. Mala Completion Milestones ---
    if (totalMalas >= 11 && !currentBadges.contains('Ekadashi Mala')) {
      newBadges.add('Ekadashi Mala');
    }
    if (totalMalas >= 108 && !currentBadges.contains('Mala Master')) {
      newBadges.add('Mala Master');
    }

    if (newBadges.isNotEmpty) {
      await userRef.update({
        'badges': FieldValue.arrayUnion(newBadges),
      });
    }
  }
}
