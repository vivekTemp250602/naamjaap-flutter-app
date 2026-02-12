import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- STREAK HELPER ---
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

  // --- AUTH METHODS ---

  // This is the method your LoginScreen is looking for
  Future<void> createOrUpdateUser(User user) async {
    final userRef = _db.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      // 1. NEW USER: Set all default values
      await userRef.set({
        'name': user.displayName ?? 'Chanter',
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'lastActive': FieldValue.serverTimestamp(),
        'lastChantDate': null, // Null until they chant
        'total_japps': 0,
        'daily_japps': 0, // Critical for V25 logic
        'weekly_total_japps': 0,
        'currentStreak': 0,
        'total_malas': 0,
        'japps': {},
        'badges': [],
        'settings': {'enableReminders': true, 'notificationLanguage': 'en'}
      });
    } else {
      // 2. RETURNING USER: Just update the "last seen" time
      // This is important for tracking MAU/DAU correctly
      await userRef.update({
        'lastActive': FieldValue.serverTimestamp(),
      });
    }
  }

  // --- CRITICAL FIX: PARALLEL READS IN TRANSACTION ---
  Future<void> syncJapaEvents({
    required String uid,
    required Map<String, dynamic> events,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    await _db.runTransaction((tx) async {
      // 1. READ
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) throw Exception('User document does not exist');

      final List<DocumentReference> eventRefs = [];
      final List<String> mantraIds = [];

      for (final entry in events.entries) {
        final eventId = entry.key;
        final eventData = Map<String, dynamic>.from(entry.value);
        eventRefs.add(userRef.collection('japa_events').doc(eventId));
        mantraIds.add(eventData['mantraId']);
      }

      final List<DocumentSnapshot> eventSnaps =
          await Future.wait(eventRefs.map((ref) => tx.get(ref)));

      // 2. LOGIC
      final userData = userSnap.data() as Map<String, dynamic>;
      final int currentStreak = userData['currentStreak'] ?? 0;
      final Timestamp? lastChantTs = userData['lastChantDate'];
      final DateTime? lastChantDate = lastChantTs?.toDate();

      final int newStreak = _calculateNewStreak(currentStreak, lastChantDate);

      // Check if we need to reset daily count (if last chant was not today)
      final bool isResetDaily =
          lastChantDate == null || !_isToday(lastChantDate);
      int currentDailyJapps = isResetDaily ? 0 : (userData['daily_japps'] ?? 0);

      int newEventCount = 0;
      final Map<String, int> mantraIncrements = {};

      for (int i = 0; i < eventSnaps.length; i++) {
        if (!eventSnaps[i].exists) {
          newEventCount++;
          final mId = mantraIds[i];
          mantraIncrements[mId] = (mantraIncrements[mId] ?? 0) + 1;

          tx.set(eventRefs[i], {
            'mantraId': mId,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      if (newEventCount == 0) return;

      // 3. WRITE
      final Map<String, Object> updates = {};
      mantraIncrements.forEach((key, count) {
        updates['japps.$key'] = FieldValue.increment(count);
      });

      updates['total_japps'] = FieldValue.increment(newEventCount);
      updates['weekly_total_japps'] = FieldValue.increment(newEventCount);

      // Update Daily Count
      updates['daily_japps'] = currentDailyJapps + newEventCount;

      updates['currentStreak'] = newStreak;
      updates['lastChantDate'] = FieldValue.serverTimestamp();
      updates['lastActive'] = FieldValue.serverTimestamp();

      tx.update(userRef, updates);
    });
  }

  // --- 4. OFFLINE JAPA LOGGING (Updated for Daily Count) ---
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

      // Update counts
      japps[mantraId] = (japps[mantraId] ?? 0) + count;
      int currentTotal = data['total_japps'] ?? 0;
      int newTotal = currentTotal + count;
      int newTotalMalas = (newTotal / 108).floor();

      // Update streak & Daily if today
      int currentStreak = data['currentStreak'] ?? 0;
      Timestamp? lastChantTs = data['lastChantDate'];
      int newStreak = currentStreak;

      final now = DateTime.now();
      final isToday = date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      final Map<String, dynamic> updates = {
        'japps': japps,
        'total_japps': newTotal,
        'total_malas': newTotalMalas,
        'weekly_total_japps': FieldValue.increment(count),
        'lastActive': FieldValue.serverTimestamp(),
      };

      if (isToday) {
        newStreak = _calculateNewStreak(currentStreak, lastChantTs?.toDate());
        updates['currentStreak'] = newStreak;
        updates['lastChantDate'] = FieldValue.serverTimestamp();

        // Handle Daily Count for Manual Entry
        bool wasLastChantToday =
            lastChantTs != null && _isToday(lastChantTs.toDate());
        int currentDaily = wasLastChantToday ? (data['daily_japps'] ?? 0) : 0;
        updates['daily_japps'] = currentDaily + count;
      }

      transaction.update(userRef, updates);
    });
  }

  // Helper to verify today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // --- REST OF THE SERVICE (Standard Methods) ---

  // Custom Mantra Logic
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

  // Sankalpa
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

  // General Methods
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
        'weekly_total_japps': 0,
        'currentStreak': 1,
        'total_malas': 0,
        'japps': {},
        'badges': [],
        'settings': {'enableReminders': true, 'notificationLanguage': 'en'}
      });
    }
  }

  Stream<QuerySnapshot> getLeaderboardStream() {
    return _db
        .collection('users')
        .orderBy('total_japps', descending: true)
        .limit(50)
        .snapshots();
  }

  Stream<QuerySnapshot> getWeeklyLeaderboardStream() {
    return _db
        .collection('users')
        .orderBy('weekly_total_japps', descending: true)
        .limit(50)
        .snapshots();
  }

  // For Profile Screen FutureBuilder
  Future<QuerySnapshot> getLeaderboard() {
    return _db
        .collection('users')
        .orderBy('total_japps', descending: true)
        .limit(50)
        .get();
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

  Stream<DocumentSnapshot> getDailyGitaQuoteStream() {
    return _db.collection('app_config').doc('daily_gita_quote').snapshots();
  }

  Stream<DocumentSnapshot> getDailyRamayanaQuoteStream() {
    return _db.collection('app_config').doc('daily_ramayana_quote').snapshots();
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
