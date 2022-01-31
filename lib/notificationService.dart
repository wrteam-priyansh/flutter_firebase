import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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

  static Future<void> createScheduleNotification() async {
    tz.initializeTimeZones();
    String localTimezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimezone));
    int differenceMinute = ((13 * 60) + 10) -
        tz.TZDateTime.now(tz.local).hour * 60 -
        tz.TZDateTime.now(tz.local).minute;

    print(differenceMinute);

    // if (differenceMinute <= 0) {
    //   //
    //   print(differenceMinute);
    //   return;
    // }

    await FlutterLocalNotificationsPlugin().zonedSchedule(
        0,
        "Reminder title",
        "Reminder body",
        tz.TZDateTime.now(tz.local).add(
          Duration(minutes: differenceMinute),
        ),
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
