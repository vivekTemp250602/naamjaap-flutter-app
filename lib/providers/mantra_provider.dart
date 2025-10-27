import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
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
        imagePaths: AppConstants.mantraImagePaths[mantraName],
        audioPath: AppConstants.mantraAudioPaths[mantraName]!,
      );
    }).toList();

    // 2. Get Custom Mantras (now from the live data)
    final List<Mantra> customMantras =
        _firestoreService.getCustomMantrasFromData(userData);

    // 2b. Rebuild the full file path for custom audio
    final directory = await getApplicationDocumentsDirectory();
    final List<Mantra> processedCustomMantras = customMantras.map((mantra) {
      return Mantra(
        id: mantra.id,
        name: mantra.name,
        isCustom: true,
        backgroundId: mantra.backgroundId,
        audioPath: mantra.audioPath,
        imagePaths: [],
        customAudioPath: mantra.customAudioPath != null
            ? '${directory.path}/${mantra.customAudioPath}'
            : null,
      );
    }).toList();

    // 3. Combine them
    _allMantras = [...globalMantras, ...processedCustomMantras];

    // 4. Load or update the selected mantra
    final lastMantraId = prefs.getString(AppConstants.prefsKeySelectedMantra);
    if (lastMantraId != null) {
      _selectedMantra = _allMantras.firstWhere((m) => m.id == lastMantraId,
          orElse: () => _allMantras.first);
    } else {
      _selectedMantra = _allMantras.first;
    }

    _isLoading = false;
    notifyListeners();
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
    String? tempAudioPath,
  }) async {
    // 1. Create the mantra in Firestore first to get its unique ID
    final String newMantraId = await _firestoreService.createCustomMantra(
      uid: _uid,
      mantraName: mantraName,
      backgroundId: backgroundId,
    );

    String? permanentRelativePath;

    // 2. If an audio file was provided, rename it and prepare its path
    if (tempAudioPath != null) {
      final directory = await getApplicationDocumentsDirectory();
      final permanentLocalPath = '${directory.path}/$newMantraId.m4a';
      permanentRelativePath =
          '$newMantraId.m4a'; // This is what we save to Firestore

      try {
        // Rename the temporary file to its new, permanent name
        await File(tempAudioPath).rename(permanentLocalPath);

        // 3. Now, update Firestore with the new, permanent audio path
        await _firestoreService.updateCustomMantraAudioPath(
          uid: _uid,
          mantraId: newMantraId,
          audioPath: permanentRelativePath,
        );
      } catch (e) {
        permanentRelativePath = null; // Failed to save
      }
    }
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
