import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService with ChangeNotifier {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityService() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialStatus();
  }

  bool get isOnline => !_connectionStatus.contains(ConnectivityResult.none);

  Future<void> _checkInitialStatus() async {
    final status = await Connectivity().checkConnectivity();
    _updateConnectionStatus(status);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    bool wasOnline = isOnline;
    _connectionStatus = result;
    if (wasOnline != isOnline) {
      notifyListeners();
      print("Connectivity changed: $result -> Online: $isOnline");
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
