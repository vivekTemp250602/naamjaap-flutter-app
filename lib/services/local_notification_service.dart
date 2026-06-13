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

    // Set local timezone to IST — critical for correct scheduling
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

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

    await _createNotificationChannels();
    // NOTE: Do NOT request permissions here.
    // Call requestPermissions() explicitly from the contextual soft-prompt.
  }

  /// Request OS notification permission explicitly.
  /// Returns true if the user granted permission.
  Future<bool> requestPermissions() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin == null) return false;
    final granted =
        await androidPlugin.requestNotificationsPermission() ?? false;
    // NOTE: requestExactAlarmsPermission() intentionally removed.
    // Naam Jaap uses inexact alarms and is not eligible for the exact
    // alarm policy exception (non-alarm/calendar app).
    return granted;
  }

  Future<void> _createNotificationChannels() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin == null) return;

    const AndroidNotificationChannel silentChannel = AndroidNotificationChannel(
      silentChannelId,
      silentChannelName,
      description: silentChannelDescription,
      importance: Importance.high,
      playSound: false,
      enableVibration: true,
    );

    const AndroidNotificationChannel soundChannel = AndroidNotificationChannel(
      soundChannelId,
      soundChannelName,
      description: soundChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    await androidPlugin.createNotificationChannel(silentChannel);
    await androidPlugin.createNotificationChannel(soundChannel);
  }

  String _getRandomString(List<String> strings) {
    final random = Random();
    return strings[random.nextInt(strings.length)];
  }

  Future<void> scheduleDailyReminders(
      {required bool isEnabled, required bool enableSound}) async {
    await flutterLocalNotificationsPlugin.cancelAll();

    if (!isEnabled) return;

    // Morning Notification — 6:30 AM IST
    await _scheduleDailyAtTime(
      id: 1,
      hour: 6,
      minute: 30,
      title: "Morning Sadhana",
      body: _getRandomString(morningStrings),
      enableSound: enableSound,
    );

    // Evening Notification — 6:00 PM IST
    await _scheduleDailyAtTime(
      id: 2,
      hour: 18,
      minute: 0,
      title: "Evening Jaap Reminder",
      body: _getRandomString(eveningStrings),
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
      importance: Importance.max,
      priority: Priority.high,
      playSound: enableSound,
      sound: enableSound
          ? const RawResourceAndroidNotificationSound('notification_sound')
          : null,
      enableVibration: true,
      ticker: title,
    );

    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentSound: enableSound,
      sound: enableSound ? 'notification_sound.mp3' : null,
      presentAlert: true,
      presentBadge: true,
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final scheduledDate = _nextInstanceOfTime(hour, minute);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: platformChannelSpecifics,
      // inexactAllowWhileIdle: fires even in Doze mode but does NOT require
      // SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM — fully Play-policy compliant.
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
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
