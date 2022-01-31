import 'package:flutter/material.dart';
import 'package:flutter_firebase/cloudStorageScreen.dart';
import 'package:flutter_firebase/notificationService.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
        NotificationService.createScheduleNotification();
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
