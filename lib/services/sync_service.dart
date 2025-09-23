import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:naamjaap/services/connectivity_service.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _pendingJappsLedgerKey = 'pendingJappsLedger';

class SyncService {
  final ConnectivityService connectivityService;
  final FirestoreService firestoreService;
  final String uid;
  final VoidCallback onSyncComplete;

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
    if (ledgerJson == null || ledgerJson.isEmpty) return; // Nothing to sync

    final Map<String, int> pendingJappsLedger =
        Map<String, int>.from(json.decode(ledgerJson));

    if (pendingJappsLedger.isNotEmpty) {
      print("Found pending japps to sync: $pendingJappsLedger");
      try {
        await firestoreService.batchIncrementJappCount(
          uid: uid,
          pendingJapps: pendingJappsLedger,
        );
        // If sync is successful, clear the local ledger.
        await prefs.remove(_pendingJappsLedgerKey);
        print("Sync successful!");
        // Notify the UI to refresh its data.
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
