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
      body: CurrentSongListener(),
      /*
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

       */
    );
  }
}

class CurrentSongListener extends StatefulWidget {
  CurrentSongListener({Key? key}) : super(key: key);

  @override
  State<CurrentSongListener> createState() => _CurrentSongListenerState();
}

class _CurrentSongListenerState extends State<CurrentSongListener> {
  StreamSubscription<DateTime>? streamSubscription;

  late DateTime current = DateTime.now();
  int currentTrackIndex = -1;

  List<DateTime> startTimes = [
    DateTime(2022, 2, 5, 16, 45),
    DateTime(2022, 2, 5, 16, 55),
    DateTime(2022, 2, 5, 15, 5),
  ];

  @override
  void initState() {
    setTimeListener();
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

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
                  .isBefore(startedTracks[i].add(Duration(minutes: 5)))) {
            currentPlaying = i;
            break;
          }
        }

        print(currentPlaying);

        if (currentTrackIndex != currentPlaying) {
          print("Current playing index is $currentPlaying");
          currentTrackIndex = currentPlaying;
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(currentTrackIndex == -1
          ? "No tracks"
          : "Track index of current playing $currentTrackIndex"),
    );
  }
}
