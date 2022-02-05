import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/feedbacksProvider.dart';
import 'package:provider/provider.dart';

class FeedbacksScreen extends StatefulWidget {
  FeedbacksScreen({Key? key}) : super(key: key);

  @override
  State<FeedbacksScreen> createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<FeedbacksProvider>().fetchFeedback();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FeedbacksProvider>(
        builder: (context, model, _) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (model.errorMessage.isNotEmpty) {
            return Center(
              child: Text("Error fetching feedbacks"),
            );
          }

          return NotificationListener(
            onNotification: (ScrollUpdateNotification scrollNotification) {
              if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent) {
                if (model.hasMore) {
                  model.fetchMoreFeedbacks();
                }
              }
              return true;
            },
            child: ListView.builder(
                itemCount: model.feedbackDocuments.length,
                itemBuilder: (context, index) {
                  if (index == model.feedbackDocuments.length - 1) {
                    if (model.isFetchMoreError.isNotEmpty) {
                      return ListTile(
                        title: Icon(Icons.error),
                      );
                    }
                    if (model.hasMore) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          title: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }
                  return ListTile(
                    title: Text("Feedback ${index + 1}"),
                  );
                }),
          );
        },
      ),
    );
  }
}
