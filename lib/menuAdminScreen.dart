import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/utilityDataProvider.dart';
import 'package:flutter_firebase/managePlaylistScreen.dart';
import 'package:flutter_firebase/manageStartTimeDateScreen.dart';
import 'package:provider/provider.dart';

class MenuAdminScreen extends StatefulWidget {
  MenuAdminScreen({Key? key}) : super(key: key);

  @override
  State<MenuAdminScreen> createState() => _MenuAdminScreenState();
}

class _MenuAdminScreenState extends State<MenuAdminScreen> {
  final List<String> menu = [
    "Manage Playlist",
    "Manage Start Time",
    "Feedbacks"
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      //
      context.read<UtilityDataProvider>().loadUtilityData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<UtilityDataProvider>(builder: (context, model, _) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (model.errorMessage.isNotEmpty) {
          return Center(
            child: Icon(Icons.error),
          );
        }

        return ListView.builder(
            itemCount: menu.length,
            itemBuilder: ((context, index) => ListTile(
                  onTap: () {
                    if (menu[index] == "Manage Playlist") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ManagePlaylistScreen()));
                    } else if (menu[index] == "Manage Start Time") {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ManageStartTimeDateScreen()));
                    }
                  },
                  title: Text("${menu[index]}"),
                )));
      }),
    );
  }
}
