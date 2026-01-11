import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<String> addCustomMantra({
    required String uid,
    required String mantraName,
    required String backgroundId,
    String? localAudioPath,
  }) async {
    final userRef = _db.collection('users').doc(uid);
    final String mantraId = _db.collection('users').doc().id;

    final String customAudioPath = 'mantras/$mantraId.m4a';

    await userRef.update({
      'custom_mantras.$mantraId': {
        'name': mantraName,
        'backgroundId': backgroundId,
        'customAudioPath': localAudioPath != null ? customAudioPath : null,
      }
    });

    return mantraId;
  }

  // Future<void> deleteCustomMantra(String uid, String mantraId) async {
  //   final userRef = _db.collection('users').doc(uid);

  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final localPath = '${directory.path}/$mantraId.m4a';
  //     final file = File(localPath);
  //     if (await file.exists()) {
  //       await file.delete();
  //     }
  //   } catch (e) {
  //     //
  //   }

  //   // Now, delete the Firestore records
  //   await userRef.update({
  //     'custom_mantras.$mantraId': FieldValue.delete(),
  //     'japps.$mantraId': FieldValue.delete(),
  //   });
  // }

  // /// NEW: Fetches the user's custom mantras in a structured way.
  // List<Mantra> getCustomMantrasFromData(Map<String, dynamic> userData) {
  //   final List<Mantra> customMantras = [];
  //   final mantrasMap =
  //       userData['custom_mantras'] as Map<String, dynamic>? ?? {};

  //   for (final entry in mantrasMap.entries) {
  //     final String? relativeAudioPath = entry.value['customAudioPath'];

  //     customMantras.add(Mantra(
  //       id: entry.key,
  //       name: entry.value['name'] ?? 'Unnamed Mantra',
  //       isCustom: true,
  //       backgroundId: entry.value['backgroundId'] ??
  //           AppConstants.customBackgrounds.first.id,
  //       customAudioPath: relativeAudioPath,
  //       audioPath: 'assets/audio/temple_bells.mp3',
  //       imagePaths: [],
  //     ));
  //   }
  //   return customMantras;
  // }

  /// It atomically increments japps and handles the daily streak logic.
  Future<void> updateJappCount(String uid, String mantraKey) async {
    final userRef = _db.collection('users').doc(uid);

    return _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      final data = snapshot.data() as Map<String, dynamic>;
      // int currentStreak = data['currentStreak'] ?? 0;
      Timestamp? lastChantTimestamp = data['lastChantDate'];
      DateTime? lastChantDate = lastChantTimestamp?.toDate();

      // Create a single map to hold all our updates.
      final Map<String, dynamic> updates = {};

      // --- Streak Logic ---
      if (lastChantDate == null || !_isToday(lastChantDate)) {
        if (lastChantDate != null && _isYesterday(lastChantDate)) {
          updates['currentStreak'] = FieldValue.increment(1);
        } else {
          updates['currentStreak'] = 1;
        }
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

  Stream<DocumentSnapshot> getDailyGitaQuoteStream() {
    return _db.collection('app_config').doc('daily_gita_quote').snapshots();
  }

  /// NEW: This stream gets the new RAMAYANA quote.
  Stream<DocumentSnapshot> getDailyRamayanaQuoteStream() {
    return _db.collection('app_config').doc('daily_ramayana_quote').snapshots();
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

  Future<void> grantPremiumAccess(String uid) {
    return _db.collection('users').doc(uid).update({'isPremium': true});
  }

  // Delete Account
  Future<void> deleteUser(String uid) {
    return _db.collection('users').doc(uid).delete();
  }

  // A dedicated method to increment the total malas count.
  Future<void> incrementTotalMalas(String uid) {
    final userRef = _db.collection('users').doc(uid);
    return userRef.update({
      'total_malas': FieldValue.increment(1),
    });
  }

  Future<void> updateUserSettings(
      String uid, Map<String, dynamic> settingsUpdate) {
    return _db.collection('users').doc(uid).set(
      {
        'settings': settingsUpdate,
      },
      SetOptions(merge: true),
    );
  }

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

  Future<void> deleteCustomMantra(String uid, String mantraId) async {
    final userRef = _db.collection('users').doc(uid);

    try {
      final directory = await getApplicationDocumentsDirectory();
      final localPath = '${directory.path}/$mantraId.m4a';
      final file = File(localPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      //
    }

    // Now, delete the Firestore records
    await userRef.update({
      'custom_mantras.$mantraId': FieldValue.delete(),
      'japps.$mantraId': FieldValue.delete(),
    });
  }

  /// Fetches the user's custom mantras in a structured way.
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
        imagePaths: const [],
      ));
    }
    return customMantras;
  }

  // Set Sankalpa
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

  Future<void> syncJapaEvents({
    required String uid,
    required Map<String, dynamic> events,
  }) async {
    final userRef = _db.collection('users').doc(uid);

    await _db.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) {
        throw Exception('User document does not exist');
      }

      int newEventCount = 0;
      final Map<String, Object> updates = {};

      for (final entry in events.entries) {
        final String eventId = entry.key;
        final Map<String, dynamic> eventData =
            Map<String, dynamic>.from(entry.value);

        final String mantraId = eventData['mantraId'];

        final eventRef = userRef.collection('japa_events').doc(eventId);

        final eventSnap = await tx.get(eventRef);

        // 🔒 IDEMPOTENCY GUARANTEE
        if (!eventSnap.exists) {
          tx.set(eventRef, {
            'mantraId': mantraId,
            'createdAt': FieldValue.serverTimestamp(),
          });

          newEventCount++;

          updates['japps.$mantraId'] = FieldValue.increment(1);
        }
      }

      // 🚫 NOTHING NEW → NOTHING TO UPDATE
      if (newEventCount == 0) return;

      updates['total_japps'] = FieldValue.increment(newEventCount);
      updates['weekly_total_japps'] = FieldValue.increment(newEventCount);
      updates['lastActive'] = FieldValue.serverTimestamp();

      tx.update(userRef, updates);
    });
  }
}
