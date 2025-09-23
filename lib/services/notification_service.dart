import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:naamjaap/services/firestore_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> initialize(String uid) async {
    await _firebaseMessaging.requestPermission();
    final String? fcmToken = await _firebaseMessaging.getToken();

    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
      await _firestoreService.saveUserToken(uid, fcmToken);
    }

    /// Subscribe the user to the daily quote topic.
    await _firebaseMessaging.subscribeToTopic('daily_quote');

    /// Set up a handler for messages that come in when the app is terminated
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}
