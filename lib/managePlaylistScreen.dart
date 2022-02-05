import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/managePlaylistProvider.dart';
import 'package:flutter_firebase/feature/utilityDataProvider.dart';
import 'package:provider/provider.dart';

class ManagePlaylistScreen extends StatefulWidget {
  ManagePlaylistScreen({Key? key}) : super(key: key);

  @override
  State<ManagePlaylistScreen> createState() => _ManagePlaylistScreenState();
}

class _ManagePlaylistScreenState extends State<ManagePlaylistScreen> {
  bool fileUploading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<ManagePlaylistProvider>().loadTracks(
          context.read<UtilityDataProvider>().utilityDataModel.playlistUrl);
    });
    super.initState();
  }

  Future<void> uploadFile() async {
    setState(() {
      fileUploading = true;
    });
    try {
      //

      FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
      File file = File(fileResult!.files.first.path!);
      TaskSnapshot taskSnapshot =
          await FirebaseStorage.instance.ref('playlist.html').putFile(file);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("utils")
          .doc(context.read<UtilityDataProvider>().utilityDocumentId)
          .update({"playlistUrl": downloadUrl});
      setState(() {
        fileUploading = false;
      });
      print("File upload success");
      context.read<UtilityDataProvider>().updatePlaylistUrl(downloadUrl);
      context.read<ManagePlaylistProvider>().changeIsLoading();
      context.read<ManagePlaylistProvider>().loadTracks(downloadUrl);
    } catch (e) {
      print(e.toString());
      print("File upload error");
      //
      setState(() {
        fileUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.upload),
          onPressed: () {
            uploadFile();
          }),
      appBar: AppBar(),
      body: Stack(
        children: [
          Consumer<ManagePlaylistProvider>(builder: (context, model, _) {
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

            return Text("Data : ${model.tracks.length}");

            // return ListView.builder(
            //     itemCount: model.tracks.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text("${model.tracks[index].title}"),
            //       );
            //     });
          }),
          fileUploading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
