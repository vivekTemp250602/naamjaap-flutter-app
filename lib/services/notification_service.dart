import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naamjaap/services/firestore_service.dart';
import 'package:naamjaap/services/local_notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> initialize(String uid) async {
    await _firebaseMessaging.requestPermission();
    final String? fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      await _firestoreService.saveUserToken(uid, fcmToken);
    }

    /// Subscribe the user to the daily quote topic.
    // await _firebaseMessaging.subscribeToTopic('daily_quote');

    /// Set up a handler for messages that come in when the app is terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // CRITICAL FIX: Schedule local notifications when FCM is initialized
    // Get user's notification preferences and schedule local notifications
    final userDoc = await _firestoreService.getUserDocument(uid);
    if (userDoc.exists) {
      final userData = userDoc.data() as Map<String, dynamic>;
      final settings = userData['settings'] as Map<String, dynamic>? ?? {};
      final enableReminders = settings['enableReminders'] ?? true;
      final enableSound = settings['enableNotificationSound'] ?? true;
      final notificationLang = settings['notificationLanguage'] ?? 'en';

      // CRITICAL: init() must be called first to set Asia/Kolkata timezone
      // Without this, tz.local defaults to UTC and 21:00 fires at 2:30 AM IST instead of 9 PM IST
      await LocalNotificationService().init();

      // Schedule local daily reminders
      await LocalNotificationService().scheduleDailyReminders(
        isEnabled: enableReminders,
        enableSound: enableSound,
      );

      // Subscribe to FCM topics based on preferences
      await updateNotificationPreferences(
        language: notificationLang,
        isEnabled: enableReminders,
      );
    }
  }

  Future<void> updateNotificationPreferences(
      {required String language, required bool isEnabled}) async {
    const allTopics = [
      'daily_quote_en',
      'daily_quote_hi',
      'daily_quote_sa',
      'daily_reminder_en',
      'daily_reminder_hi',
      'daily_reminder_sa'
    ];

    for (final topic in allTopics) {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }

    if (!isEnabled) {
      return;
    }

    final quoteTopic = 'daily_quote_$language';
    final reminderTopic = 'daily_reminder_$language';

    await _firebaseMessaging.subscribeToTopic(quoteTopic);
    await _firebaseMessaging.subscribeToTopic(reminderTopic);
  }
}
