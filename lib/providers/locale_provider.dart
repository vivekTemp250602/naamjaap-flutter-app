import 'package:flutter/material.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  final FirestoreService _firestoreService = FirestoreService();

  Locale? _locale;
  Locale? get locale => _locale;

  // This is the list of languages your NOTIFICATIONS support.
  final List<String> _supportedNotificationLangs = ['en', 'hi', 'sa'];

  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code');
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale newLocale, String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
    _locale = newLocale;

    // --- THIS IS THE "GRAND UNIFICATION" LOGIC ---
    // 1. Determine the language for notifications.
    String notificationLang = 'en'; // Default to English
    if (_supportedNotificationLangs.contains(newLocale.languageCode)) {
      notificationLang = newLocale.languageCode;
    }

    // 2. Get the current "enableReminders" status from Firestore.
    final userDoc = await _firestoreService.getUserDocument(uid);
    if (!userDoc.exists) return; // Safety check

    final userData = userDoc.data() as Map<String, dynamic>;
    final settings = userData['settings'] as Map<String, dynamic>? ?? {};
    final bool remindersEnabled = settings['enableReminders'] ?? false;

    // 3. Update both Firestore and FCM subscriptions at the same time.
    await _firestoreService.updateUserSettings(uid, {
      'notificationLanguage': notificationLang,
    });

    await _notificationService.updateNotificationPreferences(
      language: notificationLang,
      isEnabled: remindersEnabled,
    );
    // --- END OF NEW LOGIC ---

    notifyListeners();
  }
}
