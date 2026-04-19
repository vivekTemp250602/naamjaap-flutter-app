import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _instance;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String silentChannelId = 'naamjaap_silent';
  static const String silentChannelName = 'Silent Reminders';
  static const String silentChannelDescription =
      'Daily chanting reminders (Silent/Vibrate)';

  static const String soundChannelId = 'naamjaap_sound';
  static const String soundChannelName = 'Reminders with Sound';
  static const String soundChannelDescription =
      'Daily chanting reminders with alert sound';

  // Hinglish Strings per Request
  final List<String> morningStrings = [
    "Radhe Radhe! Aaj ka sadhana baaki hai 🙏",
    "Prabhu ka dhyaan karein. Shubh prabhat! 🌅",
    "Brahma muhurta me jaap ka vishesh labh hai! Hari Bol 📿",
  ];

  final List<String> eveningStrings = [
    "Aapka streak tootne wala hai. Ek mala jaap karein 📿",
    "Sham dhal chuki hai, Prabhu ko yaad karna na bhoolein 🙏",
    "Sone se pehle ek baar naam jaap awashya karein ✨",
  ];

  final List<String> genericStrings = [
    "Take a deep breath and start your daily Jaap. 🙏",
    "Hari Bol! Give 5 minutes to your spiritual practice today.",
    "Aapka mann shant rakhne ke liye ek mala karein. 📿",
  ];

  Future<void> init() async {
    tz.initializeTimeZones();

    // Android Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    // iOS Initialization
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap
      },
    );

    // Ask for permissions on Android 13+
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  String _getRandomString(List<String> strings) {
    final random = Random();
    return strings[random.nextInt(strings.length)];
  }

  Future<void> scheduleDailyReminders(
      {required bool isEnabled, required bool enableSound}) async {
    // Cancel all previously scheduled matching notifications to reset
    await flutterLocalNotificationsPlugin.cancelAll();

    if (!isEnabled) {
      return;
    }

    // Schedule Morning Notification (6:30 AM)
    await _scheduleDailyAtTime(
      id: 1,
      hour: 6,
      minute: 30,
      title: "Morning Sadhana",
      body: _getRandomString(morningStrings),
      enableSound: enableSound,
    );

    // Schedule Evening Notification (8:00 PM)
    await _scheduleDailyAtTime(
      id: 2,
      hour: 20,
      minute: 0,
      title: "Evening Jaap Reminder",
      body: _getRandomString(eveningStrings),
      enableSound: enableSound,
    );

    // Generic Backup (e.g. 1:00 PM)
    await _scheduleDailyAtTime(
      id: 3,
      hour: 13,
      minute: 0,
      title: "Mid-day Pause",
      body: _getRandomString(genericStrings),
      enableSound: enableSound,
    );
  }

  Future<void> _scheduleDailyAtTime({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
    required bool enableSound,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      enableSound ? soundChannelId : silentChannelId,
      enableSound ? soundChannelName : silentChannelName,
      channelDescription:
          enableSound ? soundChannelDescription : silentChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: enableSound,
      enableVibration: true,
    );

    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentSound: enableSound,
      presentAlert: true,
      presentBadge: true,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _nextInstanceOfTime(hour, minute),
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
