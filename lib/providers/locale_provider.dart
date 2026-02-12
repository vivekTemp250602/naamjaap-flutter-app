import 'package:flutter/material.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  final FirestoreService _firestoreService = FirestoreService();

  Locale? _locale;
  Locale? get locale => _locale;
  bool get isLocaleSet => _locale != null;

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

  Future<void> setLocale(Locale newLocale, [String? uid]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLocale.languageCode);
    _locale = newLocale;

    // Only update Firestore if a UID is provided (logged-in users)
    if (uid != null && uid.isNotEmpty) {
      String notificationLang = 'en';
      if (_supportedNotificationLangs.contains(newLocale.languageCode)) {
        notificationLang = newLocale.languageCode;
      }

      final userDoc = await _firestoreService.getUserDocument(uid);
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final settings = userData['settings'] as Map<String, dynamic>? ?? {};
        final bool remindersEnabled = settings['enableReminders'] ?? false;

        await _firestoreService.updateUserSettings(uid, {
          'notificationLanguage': notificationLang,
        });

        await _notificationService.updateNotificationPreferences(
          language: notificationLang,
          isEnabled: remindersEnabled,
        );
      }
    }

    notifyListeners();
  }
}
