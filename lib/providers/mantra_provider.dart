import 'dart:async';
import 'dart:io';
import 'package:naamjaap/utils/mala_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/remote_config_service.dart';
import 'package:naamjaap/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MantraProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final String uid;

  List<Mantra> _allMantras = [];
  Mantra? _selectedMantra;
  bool _isLoading = true;

  MalaType _selectedMalaType = MalaType.royal;
  MalaType get selectedMalaType => _selectedMalaType;

  StreamSubscription<DocumentSnapshot>? _userStreamSubscription;

  List<Mantra> get allMantras => _allMantras;
  Mantra? get selectedMantra => _selectedMantra;
  bool get isLoading => _isLoading;

  MantraProvider(this.uid) {
    if (uid == 'guest') {
      _loadGuestMantras();
    } else {
      _listenToUserChanges();
    }
  }

  // --- 1. GUEST MODE LOGIC (NEW) ---
  Future<void> _loadGuestMantras() async {
    final prefs = await SharedPreferences.getInstance();

    // Load Mala Type preference
    final String malaTypeName =
        prefs.getString(prefsKeyMalaType) ?? MalaType.royal.name;
    _selectedMalaType = MalaType.values.firstWhere(
      (e) => e.name == malaTypeName,
      orElse: () => MalaType.royal,
    );

    // Load ONLY Global Mantras (Guests don't have custom ones)
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

    _allMantras = globalMantras;

    final List<String> order = RemoteConfigService().mantras;
    _allMantras.sort((a, b) {
      int indexA = order.indexOf(a.name);
      int indexB = order.indexOf(b.name);
      // Put unknown/custom mantras at the end
      if (indexA == -1) indexA = 999;
      if (indexB == -1) indexB = 999;
      return indexA.compareTo(indexB);
    });

    // Load selected mantra preference
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

  // --- 2. LOGGED-IN USER LOGIC (EXISTING) ---
  void _listenToUserChanges() {
    _userStreamSubscription =
        _firestoreService.getUserStatsStream(uid).listen((userSnapshot) {
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        _buildMantraList(userData);
      } else {
        // Handle case where user doc doesn't exist yet (new user)
        // We pass an empty map so at least Global Mantras load
        _buildMantraList({});
      }
    });
  }

  Future<void> _buildMantraList(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();

    final String malaTypeName =
        prefs.getString(prefsKeyMalaType) ?? MalaType.royal.name;
    _selectedMalaType = MalaType.values.firstWhere(
      (e) => e.name == malaTypeName,
      orElse: () => MalaType.royal,
    );

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

    final List<String> order = RemoteConfigService().mantras;
    _allMantras.sort((a, b) {
      int indexA = order.indexOf(a.name);
      int indexB = order.indexOf(b.name);
      // Put custom mantras (which won't be in the config list) at the end
      if (indexA == -1) indexA = 999;
      if (indexB == -1) indexB = 999;
      return indexA.compareTo(indexB);
    });

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
    // SECURITY GUARD: Guests cannot add custom mantras
    if (uid == 'guest') return;

    // 1. Create the mantra in Firestore first to get its unique ID
    final String newMantraId = await _firestoreService.createCustomMantra(
      uid: uid,
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
          uid: uid,
          mantraId: newMantraId,
          audioPath: permanentRelativePath,
        );
      } catch (e) {
        permanentRelativePath = null; // Failed to save
      }
    }
  }

  Future<void> deleteCustomMantra(String mantraId) async {
    // SECURITY GUARD: Guests cannot delete mantras
    if (uid == 'guest') return;

    // 1. Only job is to update Firestore.
    await _firestoreService.deleteCustomMantra(uid, mantraId);

    // 2. If the deleted mantra was the selected one, default to the first
    if (_selectedMantra?.id == mantraId) {
      await setSelectedMantra(_allMantras.first);
    }
    // The stream will see this change and call _buildMantraList automatically.
  }

  Future<void> setSelectedMalaType(MalaType type) async {
    _selectedMalaType = type;
    notifyListeners(); // This will rebuild the HomeScreen!

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefsKeyMalaType, type.name);
  }

  @override
  void dispose() {
    _userStreamSubscription?.cancel(); // Null-safe cancel
    super.dispose();
  }
}
