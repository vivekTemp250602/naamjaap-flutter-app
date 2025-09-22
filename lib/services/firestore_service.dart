import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Helper function to check if a date was yesterday.
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

  /// It atomically increments japps and handles the daily streak logic.
  Future<void> updateJappCount(String uid, String mantraKey) async {
    final userRef = _db.collection('users').doc(uid);

    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      final data = snapshot.data() as Map<String, dynamic>;
      int currentStreak = data['currentStreak'] ?? 0;
      Timestamp? lastChantTimestamp = data['lastChantDate'];
      DateTime? lastChantDate = lastChantTimestamp?.toDate();

      // Create a single map to hold all our updates.
      final Map<String, dynamic> updates = {};

      // --- Streak Logic ---
      if (lastChantDate == null || !_isToday(lastChantDate)) {
        if (lastChantDate != null && _isYesterday(lastChantDate)) {
          // The streak continues.
          updates['currentStreak'] = FieldValue.increment(1);
        } else {
          // The streak was broken, so reset to 1.
          updates['currentStreak'] = 1;
        }
        // Always update the last chant date on the first chant of a new day.
        updates['lastChantDate'] = FieldValue.serverTimestamp();
      }

      // --- Japp Count Logic ---
      updates['japps.$mantraKey'] = FieldValue.increment(1);
      updates['total_japps'] = FieldValue.increment(1);
      updates['weekly_total_japps'] = FieldValue.increment(1);
      updates['lastActive'] = FieldValue.serverTimestamp();

      // Perform one single, efficient update with all the changes.
      transaction.update(userRef, updates);
    });
  }

  // Batch Sync Update
  Future<void> batchIncrementJappCount({
    required String uid,
    required Map<String, int> pendingJapps,
  }) async {
    final userRef = _db.collection('users').doc(uid);
    final int totalIncrement =
        pendingJapps.values.fold(0, (sum, count) => sum + count);

    final Map<String, Object> updates = {
      'total_japps': FieldValue.increment(totalIncrement),
      'weekly_total_japps': FieldValue.increment(totalIncrement),
      'lastChantDate': FieldValue.serverTimestamp(),
      'lastActive': FieldValue.serverTimestamp(),
    };

    pendingJapps.forEach((mantraKey, count) {
      updates['japps.$mantraKey'] = FieldValue.increment(count);
    });

    // We use a batched write for safety, but a direct update is also efficient.
    return userRef.update(updates);
  }

  /// Creates or updates a user's Japa Sankalpa.
  Future<void> setSankalpa({
    required String uid,
    required String mantraKey,
    required int targetCount,
    required DateTime endDate,
  }) {
    final sankalpaData = {
      'mantraKey': mantraKey,
      'targetCount': targetCount,
      'startDate': FieldValue.serverTimestamp(),
      'endDate': Timestamp.fromDate(endDate),
      'isActive': true,
    };
    return _db.collection('users').doc(uid).set(
      {'sankalpa': sankalpaData},
      SetOptions(merge: true),
    );
  }

  /// Removes a user's Japa Sankalpa.
  Future<void> removeSankalpa(String uid) {
    return _db.collection('users').doc(uid).update({
      'sankalpa': FieldValue.delete(),
    });
  }

  // The rest of your service file is perfect and remains unchanged.
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

  Stream<DocumentSnapshot> getUserStatsStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  Future<DocumentSnapshot> getUserDocument(String uid) {
    return _db.collection('users').doc(uid).get();
  }

  Future<void> updateUserName(String uid, String newName) {
    return _db.collection('users').doc(uid).update({'name': newName});
  }

  Future<void> updateUserProfilePicture(String uid, String newPhotoUrl) {
    return _db.collection('users').doc(uid).update({'photoURL': newPhotoUrl});
  }

  Stream<DocumentSnapshot> getDailyQuoteStream() {
    return _db.collection('app_config').doc('daily_quote').snapshots();
  }

  Future<void> saveUserToken(String uid, String token) {
    return _db.collection('users').doc(uid).set(
      {'fcmToken': token},
      SetOptions(merge: true),
    );
  }

  Future<void> updateReminderSetting(String uid, bool isEnabled) {
    return _db.collection('users').doc(uid).set(
      {
        'settings': {'enableReminders': isEnabled}
      },
      SetOptions(merge: true),
    );
  }
}
