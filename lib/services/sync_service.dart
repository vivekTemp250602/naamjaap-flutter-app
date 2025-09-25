// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naamjaap/services/achievements_service.dart';

const String _pendingJappsLedgerKey = 'pendingJappsLedger';

class SyncService {
  final ConnectivityService connectivityService;
  final FirestoreService firestoreService;
  final String uid;
  final VoidCallback onSyncComplete;
  final AchievementsService _achievementsService = AchievementsService();

  SyncService({
    required this.connectivityService,
    required this.firestoreService,
    required this.uid,
    required this.onSyncComplete,
  }) {
    // Listen for when the app comes online.
    connectivityService.addListener(syncPendingData);
    // Also, try to sync immediately when the app starts.
    syncPendingData();
  }

  Future<void> syncPendingData() async {
    if (!connectivityService.isOnline) return;

    final prefs = await SharedPreferences.getInstance();
    final ledgerJson = prefs.getString(_pendingJappsLedgerKey);
    if (ledgerJson == null || ledgerJson.isEmpty) return;

    final Map<String, int> pendingJappsLedger =
        Map<String, int>.from(json.decode(ledgerJson));

    if (pendingJappsLedger.isNotEmpty) {
      print("Found pending japps to sync: $pendingJappsLedger");
      try {
        await firestoreService.batchIncrementJappCount(
          uid: uid,
          pendingJapps: pendingJappsLedger,
        );

        // NEW: After a successful sync, we just tell the committee WHO to check.
        await _achievementsService.checkAndAwardBadges(uid);

        await prefs.remove(_pendingJappsLedgerKey);
        print("Sync successful!");
        onSyncComplete();
      } catch (e) {
        print("Sync failed, will retry on next connection change. Error: $e");
      }
    }
  }

  // This method cleans up the listener to prevent memory leaks.
  void dispose() {
    connectivityService.removeListener(syncPendingData);
  }
}
