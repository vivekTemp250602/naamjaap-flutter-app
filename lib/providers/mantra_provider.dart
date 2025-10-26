import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MantraProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final String _uid;

  List<Mantra> _allMantras = [];
  Mantra? _selectedMantra;
  bool _isLoading = true;

  late StreamSubscription<DocumentSnapshot> _userStreamSubscription;

  List<Mantra> get allMantras => _allMantras;
  Mantra? get selectedMantra => _selectedMantra;
  bool get isLoading => _isLoading;

  MantraProvider(this._uid) {
    _listenToUserChanges();
  }

  void _listenToUserChanges() {
    _userStreamSubscription =
        _firestoreService.getUserStatsStream(_uid).listen((userSnapshot) {
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        _buildMantraList(userData);
      }
    });
  }

  Future<void> _buildMantraList(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Get Global Mantras
    final List<Mantra> globalMantras =
        RemoteConfigService().mantras.map((mantraName) {
      final mantraKey = mantraName.toLowerCase().replaceAll(' ', '_');
      return Mantra(
        id: mantraKey,
        name: mantraName,
        isCustom: false,
        imagePath: AppConstants.mantraImagePaths[mantraName]!.first,
        audioPath: AppConstants.mantraAudioPaths[mantraName]!,
      );
    }).toList();

    // 2. Get Custom Mantras (now from the live data)
    final List<Mantra> customMantras =
        _firestoreService.getCustomMantrasFromData(userData);

    // 3. Combine them
    _allMantras = [...globalMantras, ...customMantras];

    // 4. Load or update the selected mantra
    final lastMantraId = prefs.getString(AppConstants.prefsKeySelectedMantra);
    if (lastMantraId != null) {
      _selectedMantra = _allMantras.firstWhere((m) => m.id == lastMantraId,
          orElse: () => _allMantras.first);
    } else {
      _selectedMantra = _allMantras.first;
    }

    _isLoading = false;
    notifyListeners(); // This is the magic that updates all screens.
  }

  Future<void> setSelectedMantra(Mantra mantra) async {
    _selectedMantra = mantra;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.prefsKeySelectedMantra, mantra.id);
  }

  Future<void> addCustomMantra({
    required String mantraName,
    required String backgroundId,
  }) async {
    // 1. Only job is to update Firestore.
    await _firestoreService.addCustomMantra(
      uid: _uid,
      mantraName: mantraName,
      backgroundId: backgroundId,
    );
    // The stream will see this change and call _buildMantraList automatically.
  }

  Future<void> deleteCustomMantra(String mantraId) async {
    // 1. Only job is to update Firestore.
    await _firestoreService.deleteCustomMantra(_uid, mantraId);

    // 2. If the deleted mantra was the selected one, default to the first
    if (_selectedMantra?.id == mantraId) {
      await setSelectedMantra(_allMantras.first);
    }
    // The stream will see this change and call _buildMantraList automatically.
  }

  @override
  void dispose() {
    _userStreamSubscription.cancel();
    super.dispose();
  }
}
