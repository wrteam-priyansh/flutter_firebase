import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class TrackDetails {
  final String title;
  final String duration;

  TrackDetails({required this.duration, required this.title});

  int trackDurationInMinutes() {
    final result = this.duration.split(":");

    int durationInMinutes = 0;

    //then duration is in hour
    if (result.length == 3) {
      durationInMinutes = (int.parse(result.first) * 60) + durationInMinutes;
      durationInMinutes = int.parse(result[1]) + durationInMinutes;
      durationInMinutes = (int.parse(result.last) ~/ 60) + durationInMinutes;
      return durationInMinutes;
    }

    //then duration is in minutes
    if (result.length == 2) {
      durationInMinutes = int.parse(result.first) + durationInMinutes;
      durationInMinutes = (int.parse(result.last) ~/ 60) + durationInMinutes;
    }

    durationInMinutes = (int.parse(result.first) ~/ 60) + durationInMinutes;
    return durationInMinutes;
  }
}

class CloudStorageScreen extends StatefulWidget {
  CloudStorageScreen({Key? key}) : super(key: key);

  @override
  State<CloudStorageScreen> createState() => _CloudStorageScreenState();
}

class _CloudStorageScreenState extends State<CloudStorageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Storage"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        //
        try {
          FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
          File file = File(fileResult!.files.first.path!);
          // print(file?.files.first.path);
          TaskSnapshot taskSnapshot =
              await FirebaseStorage.instance.ref('playlist.html').putFile(file);
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          //
          http.Response response = await http.get(Uri.parse(downloadUrl));

          var document = html.parse(response.body);
          final liElements = document.body!.getElementsByTagName("li");
          for (var element in liElements) {
            List<String> result = element.text.split("(");
            String title = result.first;
            String time = result.last.split(")").first;
            print("Title is $title");
            print("Time is $time");

            TrackDetails trackDetails =
                TrackDetails(duration: time, title: title);

            print(
                "Duration in minutes is ${trackDetails.trackDurationInMinutes()}");
          }
        } catch (e) {
          print(e.toString());
        }
      }),
    );
  }
}
