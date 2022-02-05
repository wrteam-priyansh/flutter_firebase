import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloudStorageScreen.dart';
import 'package:flutter_firebase/notificationService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> menu = ["Cloud Storage"];

  late DateTime current = DateTime.now();

  @override
  void initState() {
    NotificationService.intitNotification();
    super.initState();
  }

  StreamSubscription<DateTime>? streamSubscription;

  List<DateTime> startTimes = [
    DateTime(2022, 2, 5, 16, 20),
    DateTime(2022, 2, 5, 16, 30),
    DateTime(2022, 2, 5, 16, 40)
  ];

  void setTimeListener() {
    current = DateTime.now();
    Stream<DateTime> timer = Stream.periodic(Duration(minutes: 1), (i) {
      current = current.add(Duration(minutes: 1));
      return current;
    });
    streamSubscription = timer.listen((data) {
      final startedTracks = startTimes
          .where((element) => element.difference(DateTime.now()).isNegative)
          .toList();
      print(startedTracks.length);

      if (startedTracks.isNotEmpty) {
        int currentPlaying = -1;
        for (var i = 0; i < startedTracks.length; i++) {
          if (DateTime.now().isAfter(startedTracks[i]) &&
              DateTime.now()
                  .isBefore(startedTracks[i].add(Duration(minutes: 10)))) {
            currentPlaying = i;
            break;
          }
        }

        print("Current playing index is $currentPlaying");
      }
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Firebase"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        setTimeListener();
        // String url = Platform.isAndroid
        //     ? "https://play.google.com/store/apps/details?id=com.wrteam.flutterquiz"
        //     : "";
        // try {
        //   bool canOpen = await canLaunch(url);
        //   if (canOpen) {
        //     launch(url);
        //   }
        // } catch (e) {}

        // //NotificationService.createScheduleNotification();

        // initializeTimeZones();

        // //current time zone
        // String localTimezone = await FlutterNativeTimezone.getLocalTimezone();
        // DateTime dateTime = DateTime(2022, 2, 1, 14, 45);

        // setLocalLocation(getLocation(localTimezone));

        // //indian time zone
        // TZDateTime indianStandraTimeDate =
        //     TZDateTime.from(dateTime, getLocation("Asia/Kolkata"));

        // TZDateTime localTimeZoneDatetime =
        //     TZDateTime.from(indianStandraTimeDate, local); //"Asia/Karachi"

        // print(localTimeZoneDatetime.minute); // 0 to 23 hour

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
