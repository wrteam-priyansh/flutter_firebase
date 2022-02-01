import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  static void intitNotification() async {
    //
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {});

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: (payload) {
      print("payload is $payload");
    });
  }

  static Future<void> createScheduleNotification(
      TZDateTime scheduleDateTime) async {
    initializeTimeZones();
    String localTimezone = await FlutterNativeTimezone.getLocalTimezone();
    setLocalLocation(getLocation(localTimezone));

    await FlutterLocalNotificationsPlugin().zonedSchedule(
        0,
        "Reminder title updated",
        "Reminder body updated",
        scheduleDateTime,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);

    print("Notification sent successfully");
  }
}
