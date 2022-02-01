import 'package:flutter/material.dart';

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
        try {
          // FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
          // File file = File(fileResult!.files.first.path!);
          // // print(file?.files.first.path);
          // TaskSnapshot taskSnapshot =
          //     await FirebaseStorage.instance.ref('playlist.html').putFile(file);
          // String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          // //
          // http.Response response = await http.get(Uri.parse(downloadUrl));

          // var document = html.parse(response.body);
          // // final liElements = document.body!.getElementsByTagName("li");

          // List<TrackDetails> tracks = [
          //   TrackDetails(duration: "30:00", title: "Sufi track 1"),
          //   TrackDetails(duration: "1:30:00", title: "Sufi track 2"),
          //   TrackDetails(duration: "2:00:00", title: "Sufi track 3"),
          // ];

          // DateTime trackTime = trackStartTime;

          // for (var i = 0; i < 3; i++) {
          //   trackTime = trackTime
          //       .add(Duration(minutes: tracks[i].trackDurationInMinutes()));
          // }

          // final trackReminderTime = await Utils.getTrackStartTime(trackTime);

          // final timePicker = await showTimePicker(
          //     context: context, initialTime: TimeOfDay(hour: 00, minute: 00));

          // if (timePicker != null) {
          //   //
          //   print(timePicker.hour);
          //   //
          //   print(timePicker.minute);
          // }

          final datePicker = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 7)));
          if (datePicker != null) {
            print(datePicker.toString());
          }
        } catch (e) {
          print(e.toString());
        }

        //
      }),
    );
  }
}
