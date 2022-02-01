import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloudStorageScreen.dart';
import 'package:flutter_firebase/notificationService.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest_all.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> menu = ["Cloud Storage"];

  @override
  void initState() {
    NotificationService.intitNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        //NotificationService.createScheduleNotification();

        initializeTimeZones();

        //current time zone
        String localTimezone = await FlutterNativeTimezone.getLocalTimezone();
        DateTime dateTime = DateTime(2022, 2, 1, 14, 45);

        setLocalLocation(getLocation(localTimezone));

        //indian time zone
        TZDateTime indianStandraTimeDate =
            TZDateTime.from(dateTime, getLocation("Asia/Kolkata"));

        TZDateTime localTimeZoneDatetime =
            TZDateTime.from(indianStandraTimeDate, local); //"Asia/Karachi"

        print(localTimeZoneDatetime.minute); // 0 to 23 hour

        //TZDateTime nextDate = timeZoneDatetime.add(Duration(minutes: 120));

        // print("Next date is ${nextDate.day}");
      }),
      body: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                if (index == 0) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => CloudStorageScreen()));
                }
              },
              title: Text("${menu[index]}"),
            );
          }),
    );
  }
}
