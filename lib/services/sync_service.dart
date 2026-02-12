import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/achievements_service.dart';

const String _pendingEventsKey = 'pendingJapaEvents'; // Key matches HomeScreen

class SyncService {
  final ConnectivityService connectivityService;
  final FirestoreService firestoreService;
  final String uid;
  final VoidCallback onSyncComplete;

  final AchievementsService _achievementsService = AchievementsService();
  bool _syncInProgress = false;

  SyncService({
    required this.connectivityService,
    required this.firestoreService,
    required this.uid,
    required this.onSyncComplete,
  }) {
    connectivityService.addListener(syncPendingData);
    syncPendingData();
  }

  Future<void> syncPendingData() async {
    if (_syncInProgress) return;
    _syncInProgress = true;

    try {
      final hasInternet = await connectivityService.hasInternetAccess();
      if (!hasInternet) return;

      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_pendingEventsKey);

      if (jsonStr == null || jsonStr.isEmpty) return;

      final Map<String, dynamic> pendingEvents =
          Map<String, dynamic>.from(json.decode(jsonStr));

      if (pendingEvents.isEmpty) return;

      // 1. Upload to Firestore (Transaction)
      await firestoreService.syncJapaEvents(
        uid: uid,
        events: pendingEvents,
      );

      // 2. Check Badges
      await _achievementsService.checkAndAwardBadges(uid);

      // 3. Clear Local Storage ONLY after successful upload
      await prefs.remove(_pendingEventsKey);

      // 4. Notify Home Screen to clear its memory state
      onSyncComplete();
    } catch (e, s) {
      // Logic: If error occurs, we DO NOT clear local storage.
      // The events stay there and will retry next time.
      FirebaseCrashlytics.instance.recordError(
        e,
        s,
        reason: 'Idempotent japa sync failed',
      );
    } finally {
      _syncInProgress = false;
    }
  }

  void dispose() {
    connectivityService.removeListener(syncPendingData);
  }
}
