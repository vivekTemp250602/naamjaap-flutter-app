import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR WEEK ID

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- HELPER METHODS ---

  int _calculateNewStreak(int currentStreak, DateTime? lastChantDate) {
    if (lastChantDate == null) return 1;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last =
        DateTime(lastChantDate.year, lastChantDate.month, lastChantDate.day);

    if (last.isAtSameMomentAs(today)) {
      return currentStreak > 0 ? currentStreak : 1;
    } else if (last.difference(today).inDays == -1) {
      return currentStreak + 1;
    } else {
      return 1;
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // NEW: Generates a unique ID for the current week (e.g., "2026_07")
  String _getWeekId(DateTime date) {
    final dayOfYear = int.parse(DateFormat("D").format(date));
    // Calculate week number (1-52)
    final week = ((dayOfYear - date.weekday + 10) / 7).floor();
    return "${date.year}_$week";
  }

  // --- AUTH METHODS ---

  Future<void> createOrUpdateUser(User user) async {
    final userRef = _db.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        'name': user.displayName ?? 'Chanter',
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'lastActive': FieldValue.serverTimestamp(),
        'lastChantDate': null,
        'total_japps': 0,
        'daily_japps': 0,
        'weekly_total_japps': 0,
        'week_id': _getWeekId(DateTime.now()), // NEW: Initialize week ID
        'currentStreak': 0,
        'total_malas': 0,
        'japps': {},
        'badges': [],
        'settings': {
          'enableReminders': true, 
          'enableNotificationSound': false,
          'notificationLanguage': 'en'
        }
      });
    } else {
      await userRef.update({
        'lastActive': FieldValue.serverTimestamp(),
      });
    }
  }

  // --- CHANTING LOGIC (BATCHED + WEEKLY RESET) ---

  Future<void> syncJapaEvents({
    required String uid,
    required Map<String, dynamic> events,
  }) async {
    if (events.isEmpty) return;

    final userRef = _db.collection('users').doc(uid);

    int totalNewChants = 0;
    final Map<String, int> mantraCounts = {};

    for (final entry in events.values) {
      final mantraId = entry['mantraId'];
      mantraCounts[mantraId] = (mantraCounts[mantraId] ?? 0) + 1;
      totalNewChants++;
    }

    await _db.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) return;

      final userData = userSnap.data() as Map<String, dynamic>;

      // Streak & Daily Logic
      final int currentStreak = userData['currentStreak'] ?? 0;
      final Timestamp? lastChantTs = userData['lastChantDate'];
      final DateTime? lastChantDate = lastChantTs?.toDate();
      final int newStreak = _calculateNewStreak(currentStreak, lastChantDate);

      final DateTime now = DateTime.now();
      final bool isResetDaily =
          lastChantDate == null || !_isToday(lastChantDate);
      final int currentDailyJapps =
          isResetDaily ? 0 : (userData['daily_japps'] ?? 0);

      // --- WEEKLY RESET LOGIC START ---
      final String currentWeekId = _getWeekId(now);
      final String storedWeekId = userData['week_id'] ?? '';

      // If the stored week doesn't match the current week, reset to 0
      final int baseWeeklyTotal = (storedWeekId == currentWeekId)
          ? (userData['weekly_total_japps'] ?? 0)
          : 0;
      // --- WEEKLY RESET LOGIC END ---

      final Map<String, dynamic> updates = {
        'total_japps': FieldValue.increment(totalNewChants),
        'week_id': currentWeekId, // Always stamp the current week
        'weekly_total_japps':
            baseWeeklyTotal + totalNewChants, // Set exact amount
        'daily_japps': currentDailyJapps + totalNewChants,
        'currentStreak': newStreak,
        'lastChantDate': FieldValue.serverTimestamp(),
        'lastActive': FieldValue.serverTimestamp(),
      };

      mantraCounts.forEach((mantraId, count) {
        updates['japps.$mantraId'] = FieldValue.increment(count);
      });

      tx.update(userRef, updates);
    });
  }

  Future<void> logManualJapa({
    required String uid,
    required String mantraId,
    required int count,
    required DateTime date,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) throw Exception("User does not exist!");

      final data = snapshot.data() ?? {};
      Map<String, dynamic> japps = data['japps'] ?? {};

      japps[mantraId] = (japps[mantraId] ?? 0) + count;
      int currentTotal = data['total_japps'] ?? 0;
      int newTotal = currentTotal + count;
      int newTotalMalas = (newTotal / 108).floor();

      int currentStreak = data['currentStreak'] ?? 0;
      Timestamp? lastChantTs = data['lastChantDate'];
      int newStreak = currentStreak;

      final now = DateTime.now();
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      // --- WEEKLY RESET LOGIC START ---
      final String currentWeekId = _getWeekId(now);
      final String storedWeekId = data['week_id'] ?? '';

      final int baseWeeklyTotal = (storedWeekId == currentWeekId)
          ? (data['weekly_total_japps'] ?? 0)
          : 0;
      // --- WEEKLY RESET LOGIC END ---

      final Map<String, dynamic> updates = {
        'japps': japps,
        'total_japps': newTotal,
        'total_malas': newTotalMalas,
        'week_id': currentWeekId, // Always stamp the current week
        'weekly_total_japps': baseWeeklyTotal + count, // Set exact amount
        'lastActive': FieldValue.serverTimestamp(),
      };

      if (isToday) {
        newStreak = _calculateNewStreak(currentStreak, lastChantTs?.toDate());
        updates['currentStreak'] = newStreak;
        updates['lastChantDate'] = FieldValue.serverTimestamp();

        bool wasLastChantToday =
            lastChantTs != null && _isToday(lastChantTs.toDate());
        int currentDaily = wasLastChantToday ? (data['daily_japps'] ?? 0) : 0;
        updates['daily_japps'] = currentDaily + count;
      }

      transaction.update(userRef, updates);
    });
  }

  // --- LEADERBOARD STREAMS ---

  Stream<QuerySnapshot> getLeaderboardStream() {
    return _db
        .collection('users')
        .orderBy('total_japps', descending: true)
        .limit(50)
        .snapshots();
  }

  Stream<QuerySnapshot> getWeeklyLeaderboardStream() {
    // ONLY FETCH USERS ACTIVE THIS WEEK
    final String currentWeekId = _getWeekId(DateTime.now());
    return _db
        .collection('users')
        .where('week_id', isEqualTo: currentWeekId)
        .orderBy('weekly_total_japps', descending: true)
        .limit(50)
        .snapshots();
  }

  Future<QuerySnapshot> getLeaderboard() {
    return _db
        .collection('users')
        .orderBy('total_japps', descending: true)
        .limit(50)
        .get();
  }

  // --- REST OF THE FILE REMAINS UNCHANGED ---

  Future<String> createCustomMantra({
    required String uid,
    required String mantraName,
    required String backgroundId,
  }) async {
    final userRef = _db.collection('users').doc(uid);
    final String mantraId = _db.collection('users').doc().id;

    await userRef.update({
      'custom_mantras.$mantraId': {
        'name': mantraName,
        'backgroundId': backgroundId,
        'customAudioPath': null,
      }
    });
    return mantraId;
  }

  Future<void> updateCustomMantraAudioPath({
    required String uid,
    required String mantraId,
    required String audioPath,
  }) {
    final userRef = _db.collection('users').doc(uid);
    return userRef.update({
      'custom_mantras.$mantraId.customAudioPath': audioPath,
    });
  }

  List<Mantra> getCustomMantrasFromData(Map<String, dynamic> userData) {
    final List<Mantra> customMantras = [];
    final mantrasMap =
        userData['custom_mantras'] as Map<String, dynamic>? ?? {};

    for (final entry in mantrasMap.entries) {
      final String? relativeAudioPath = entry.value['customAudioPath'];
      customMantras.add(Mantra(
        id: entry.key,
        name: entry.value['name'] ?? 'Unnamed Mantra',
        isCustom: true,
        backgroundId: entry.value['backgroundId'] ??
            AppConstants.customBackgrounds.first.id,
        customAudioPath: relativeAudioPath,
        audioPath: 'assets/audio/temple_bells.mp3',
        imagePaths: [],
      ));
    }
    return customMantras;
  }

  Future<void> deleteCustomMantra(String uid, String mantraId) async {
    final userRef = _db.collection('users').doc(uid);
    try {
      final directory = await getApplicationDocumentsDirectory();
      final localPath = '${directory.path}/$mantraId.m4a';
      final file = File(localPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {/* ignore */}

    await userRef.update({
      'custom_mantras.$mantraId': FieldValue.delete(),
      'japps.$mantraId': FieldValue.delete(),
    });
  }

  Future<void> setSankalpa({
    required String uid,
    required Mantra mantra,
    required int targetCount,
    required DateTime endDate,
    required int startCount,
  }) {
    final sankalpaData = {
      'mantraId': mantra.id,
      'mantraName': mantra.name,
      'targetCount': targetCount,
      'startCount': startCount,
      'startDate': FieldValue.serverTimestamp(),
      'endDate': Timestamp.fromDate(endDate),
      'isActive': true,
    };
    return _db
        .collection('users')
        .doc(uid)
        .set({'sankalpa': sankalpaData}, SetOptions(merge: true));
  }

  Future<void> removeSankalpa(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .update({'sankalpa': FieldValue.delete()});
  }

  Future<void> createUser(
      String uid, String? email, String? displayName) async {
    final userRef = _db.collection('users').doc(uid);
    final doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'name': displayName ?? 'Chanter',
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'lastActive': FieldValue.serverTimestamp(),
        'lastChantDate': FieldValue.serverTimestamp(),
        'total_japps': 0,
        'daily_japps': 0,
        'weekly_total_japps': 0,
        'week_id': _getWeekId(DateTime.now()),
        'currentStreak': 1,
        'total_malas': 0,
        'japps': {},
        'badges': [],
        'settings': {
          'enableReminders': true, 
          'enableNotificationSound': false,
          'notificationLanguage': 'en'
        }
      });
    }
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

  Future<void> saveUserToken(String uid, String token) {
    return _db
        .collection('users')
        .doc(uid)
        .set({'fcmToken': token}, SetOptions(merge: true));
  }

  Future<void> updateUserSettings(
      String uid, Map<String, dynamic> settingsUpdate) {
    return _db
        .collection('users')
        .doc(uid)
        .set({'settings': settingsUpdate}, SetOptions(merge: true));
  }

  Future<void> deleteUser(String uid) {
    return _db.collection('users').doc(uid).delete();
  }

  Future<void> incrementTotalMalas(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .update({'total_malas': FieldValue.increment(1)});
  }
}
