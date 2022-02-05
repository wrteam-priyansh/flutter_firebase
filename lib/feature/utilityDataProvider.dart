import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase/feature/utilityDataModel.dart';

class UtilityDataProvider with ChangeNotifier {
  //
  bool isLoading = true;
  String errorMessage = "";

  UtilityDataModel utilityDataModel = UtilityDataModel(
      playlistUrl: "playlistUrl",
      startDate: "startDate",
      startTime: "startTime");

  String utilityDocumentId = "";

  void updatePlaylistUrl(String url) {
    utilityDataModel = utilityDataModel.copyWith(newPlaylistUrl: url);
    notifyListeners();
  }

  void updateStartTimeDate(String startTime, String startDate) {
    utilityDataModel = utilityDataModel.copyWith(
        newStartDate: startDate, newStartTime: startTime);
    notifyListeners();
  }

  Future<void> loadUtilityData() async {
    try {
      //

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("utils").get();
      final utilityData =
          querySnapshot.docs.first.data() as Map<String, dynamic>;

      utilityDocumentId = querySnapshot.docs.first.id;
      utilityDataModel = utilityDataModel.copyWith(
          newPlaylistUrl: utilityData['playlistUrl'],
          newStartDate: utilityData['startDate'],
          newStartTime: utilityData['startTime']);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Error";
      notifyListeners();
    }
  }
}
