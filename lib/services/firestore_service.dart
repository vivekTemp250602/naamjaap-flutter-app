import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  bool _isYesterday(DateTime date) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  // Helper function to check if a date is today.
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Updates a user's japp count for a specific mantra in an atomic transaction.
  /// Also increments the total_japps count and updates the lastActive timestamp.
  Future<void> updateJappCount(String uid, String mantraKey) async {
    final userRef = _db.collection('users').doc(uid);

    return _db.runTransaction((transaction) async {
      // Get the latest document snapshot within the transaction
      final snapshot = await transaction.get(userRef);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      final data = snapshot.data() as Map<String, dynamic>;
      int currentStreak = data['currentStreak'] ?? 0;
      Timestamp? lastChantTimeStamp = data['lastChantDate'];
      DateTime? lastChantDate = lastChantTimeStamp?.toDate();

      if (lastChantDate == null || !_isToday(lastChantDate)) {
        if (lastChantDate != null && _isYesterday(lastChantDate)) {
          currentStreak++;
        } else {
          currentStreak = 1;
        }

        transaction.update(userRef, {
          'lastChantDate': FieldValue.serverTimestamp(),
          'currentStreak': currentStreak,
        });
      }

      final jappsUpdate = {'japps.$mantraKey': FieldValue.increment(1)};
      final totalJappsUpdate = {'total_japps': FieldValue.increment(1)};
      final weeklyJappsUpdate = {'weekly_total_japps': FieldValue.increment(1)};
      final lastActiveUpdate = {'lastActive': FieldValue.serverTimestamp()};

      // Perform the updates
      transaction.update(userRef, jappsUpdate);
      transaction.update(userRef, totalJappsUpdate);
      transaction.update(userRef, lastActiveUpdate);
      transaction.update(userRef, weeklyJappsUpdate);
    });
  }

  /// Returns a stream of the top 100 users, ordered by their total japp count.
  /// This will update in real-time as counts change.
  Stream<QuerySnapshot> getLeaderboardStream() {
    return _db
        .collection('users')
        .orderBy('total_japps', descending: true)
        .limit(100)
        .snapshots();
  }

  Stream<QuerySnapshot> getWeeklyLeaderboardStream() {
    return _db
        .collection('users')
        .orderBy('weekly_total_japps', descending: true)
        .limit(100)
        .snapshots();
  }

  /// Returns a stream of a single user's document.
  /// This is useful for listening to live updates on a profile screen.
  Stream<DocumentSnapshot> getUserStatsStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  /// Updates the user's display name in their document.
  Future<void> updateUserName(String uid, String newName) {
    return _db.collection('users').doc(uid).update({'name': newName});
  }

  /// Returns a future of a single user's document snapshot for a one-time read.
  Future<DocumentSnapshot> getUserDocument(String uid) {
    return _db.collection('users').doc(uid).get();
  }

  /// Saves or updates the user's FCM token in their document.
  Future<void> saveUserToken(String uid, String token) {
    return _db.collection('users').doc(uid).set(
      {'fcmToken': token},
      SetOptions(merge: true), // merge:true prevents overwriting other fields
    );
  }

  /// Updates the user's preference for receiving reminder notifications.
  Future<void> updateReminderSetting(String uid, bool isEnabled) {
    // We use a nested map for settings for better organization.
    return _db.collection('users').doc(uid).set(
      {
        'settings': {'enableReminders': isEnabled}
      },
      SetOptions(merge: true),
    );
  }

  /// Returns a stream that listens to the 'Quote of the Day' document.
  Stream<DocumentSnapshot> getDailyQuoteStream() {
    // We listen to a specific, single document that our function will update.
    return _db.collection('app_config').doc('daily_quote').snapshots();
  }
}
