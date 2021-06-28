import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../models/downloads.dart';
import '../models/uploads.dart';
import 'dart:io';

class DownloadsProvider with ChangeNotifier {
  List<Upload> _uploaded = [];
  final CollectionReference store_down_link =
      FirebaseFirestore.instance.collection("downFiles");
  final CollectionReference user_uploads =
      FirebaseFirestore.instance.collection("UserUploads");
  final CollectionReference user =
      FirebaseFirestore.instance.collection("users");

  List<DownloadFile> _availableFiles = [];

  List<DownloadFile> get getFiles {
    return _availableFiles;
  }

  List<Upload> get getUploads {
    return _uploaded;
  }

  Future<List<DownloadFile>> fetchAndSet(String dom) async {
    List<DownloadFile> files = [];
    final result = await store_down_link.where("Domain", isEqualTo: dom).get();
    result.docs.forEach((element) {
      files.add(DownloadFile(
        fileName: element["FileName"],
        uploadedOn: element["Date"].toDate(),
        domain: element['Domain'],
        description: element["description"],
        downloadUrl: element["DownLoadUrl"],
        contributions: 0,
        downloads: 0,
        uploads: 0,
        userId: element["userId"],
      ));
    });

    return files;
  }

  Future<List<DownloadFile>> userFetchset(String uid) async {
    List<DownloadFile> files = [];
    final result = await user_uploads.doc(uid).collection("Files").get();
    result.docs.forEach((element) {
      files.add(DownloadFile(
        fileName: element["FileName"],
        uploadedOn: element["Date"].toDate(),
        domain: element["Domain"],
        description: element["description"],
        downloadUrl: null,
        contributions: 0,
        downloads: 0,
        uploads: 0,
        userId: uid,
      ));
    });
    return files;
  }

  Future<void> uloadFile(DownloadFile file, File uploadFile, String uid) async {
    print("i was here");
    if (uploadFile == null) {
      print("file is null");
      return;
    }

    final String destination = "stuFiles/${file.fileName}";
    String downLink = '';
    try {
      final firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref(destination)
          .putFile(uploadFile);
      print('success');
      final snapshot = await task.whenComplete(() => null);
      downLink = await snapshot.ref.getDownloadURL();
      store_down_link.add({
        "DownLoadUrl": downLink,
        "FileName": file.fileName,
        "description": file.description,
        "Date": file.uploadedOn,
        "Domain": file.domain,
        "SearchFeild": file.fileName.substring(0, 1).toUpperCase(),
        "userId": uid,
      });
      user_uploads.doc(uid).collection("Files").add({
        "DownLoadUrl": downLink,
        "FileName": file.fileName,
        "description": file.description,
        "Date": file.uploadedOn,
        "Domain": file.domain,
      }).then((value) {
        user.doc(uid).update({
          "uploads": FieldValue.increment(1),
        });
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }
}
