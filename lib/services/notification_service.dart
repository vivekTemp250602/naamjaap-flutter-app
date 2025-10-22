import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naamjaap/services/firestore_service.dart';

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
    await _firebaseMessaging.subscribeToTopic('daily_quote');

    /// Set up a handler for messages that come in when the app is terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
