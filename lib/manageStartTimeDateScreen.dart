import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/utilityDataProvider.dart';
import 'package:provider/provider.dart';

class ManageStartTimeDateScreen extends StatefulWidget {
  ManageStartTimeDateScreen({Key? key}) : super(key: key);

  @override
  State<ManageStartTimeDateScreen> createState() =>
      _ManageStartTimeDateScreenState();
}

class _ManageStartTimeDateScreenState extends State<ManageStartTimeDateScreen> {
  DateTime? selectedDateTime;
  TimeOfDay? selectedTimeOfDay;

  String buildSelectedTime() {
    return "";
  }

  String isTimeAmOrPm() {
    if (selectedTimeOfDay == null) {
      return "";
    }
    return selectedTimeOfDay!.hour > 12 ? "PM" : "AM";
  }

  String selectedTimeHour() {
    if (selectedTimeOfDay == null) {
      return "";
    }
    return selectedTimeOfDay!.hour > 12
        ? (selectedTimeOfDay!.hour - 12).toString().padLeft(2, '0')
        : selectedTimeOfDay!.hour.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UtilityDataProvider>(builder: (context, model, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Start time : ${model.utilityDataModel.startTime}"),
            SizedBox(
              height: 20.0,
            ),
            Text("Start date : ${model.utilityDataModel.startDate}"),
            SizedBox(
              height: 20.0,
            ),
            Divider(),
            Text("Select new start date"),
            SizedBox(
              height: 20.0,
            ),
            selectedDateTime == null
                ? SizedBox()
                : Text("Selected date : ${selectedDateTime.toString()}"),
            TextButton(
                onPressed: () async {
                  final result = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 7)));

                  setState(() {
                    selectedDateTime = result;
                  });
                },
                child: Text("Pick date")),
            Divider(),
            Text("Select new start time"),
            SizedBox(
              height: 20.0,
            ),
            selectedTimeOfDay == null
                ? SizedBox()
                : Text(
                    "Selected time : ${selectedTimeHour()}:${selectedTimeOfDay!.minute.toString().padLeft(2, '0')} ${isTimeAmOrPm()}"),
            TextButton(
                onPressed: () async {
                  final result = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  setState(() {
                    selectedTimeOfDay = result;
                  });
                },
                child: Text("Pick start time")),
            Divider(),

            //
          ],
        );
      }),
    );
  }
}
