import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Feedback {
  final String name;
  final String email;
  final String message;
  final Timestamp timestamp;
  final String id;

  Feedback(
      {required this.id,
      required this.email,
      required this.message,
      required this.name,
      required this.timestamp});

  static Feedback fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return Feedback(
        id: documentSnapshot.id,
        email: data['email'],
        message: data['message'],
        name: data['name'],
        timestamp: data['timestamp']);
  }
}

class FeedbacksProvider with ChangeNotifier {
  //
  bool isLoading = true;
  bool hasMore = false;
  String errorMessage = "";

  String isFetchMoreError = "";

  List<DocumentSnapshot> feedbackDocuments = [];

  Future<void> fetchFeedback() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("feedbacks")
          .orderBy("timestamp", descending: true)
          .limit(20)
          .get();

      feedbackDocuments = querySnapshot.docs;
      hasMore = querySnapshot.docs.length > 20;

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Error while fetching feedback";
      notifyListeners();
    }
  }

  Future<void> fetchMoreFeedbacks() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("feedbacks")
          .orderBy("timestamp", descending: true)
          .startAfterDocument(feedbackDocuments.last)
          .limit(20)
          .get();

      hasMore = querySnapshot.docs.length > 20;
      querySnapshot.docs.forEach((element) {
        feedbackDocuments.add(element);
      });

      notifyListeners();
    } catch (e) {
      isFetchMoreError = "Error";
      notifyListeners();
    }
  }
}
