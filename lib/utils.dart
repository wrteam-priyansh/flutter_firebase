import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

import 'package:timezone/data/latest_all.dart';

class Utils {
  static Future<tz.TZDateTime> getTrackStartTime(DateTime dateTime) async {
    initializeTimeZones();
    //current time zone
    String localTimezone = await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(localTimezone));

    //indian time zone
    tz.TZDateTime indianStandraTimeDate =
        tz.TZDateTime.from(dateTime, tz.getLocation("Asia/Kolkata"));

    tz.TZDateTime localTimeZoneDatetime =
        tz.TZDateTime.from(indianStandraTimeDate, tz.local);

    return localTimeZoneDatetime;
  }
}
