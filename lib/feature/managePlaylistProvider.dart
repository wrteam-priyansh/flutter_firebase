import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/trackDetails.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;

class ManagePlaylistProvider with ChangeNotifier {
  List<TrackDetails> tracks = [];

  bool isLoading = true;
  String errorMessage = "";

  void changeIsLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> loadTracks(String playlistUrl) async {
    //
    if (!isLoading) {
      return;
    }
    try {
      http.Response response = await http.get(Uri.parse(playlistUrl));

      var document = html.parse(response.body);
      final liElements = document.body!.getElementsByTagName("li");

      for (var liElement in liElements) {
        print(liElement.text);
      }

      isLoading = false;
      tracks = [];
      notifyListeners();
    } catch (e) {
      print(e.toString());

      isLoading = false;
      errorMessage = "Error";
      notifyListeners();
    }
  }
}
