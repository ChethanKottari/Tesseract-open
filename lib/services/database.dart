import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tesseract/models/user_data.dart';

class DatabaseService with ChangeNotifier {
  final String uid;
  DatabaseService({this.uid});

  // final DocumentReference userCollection =
  //     FirebaseFirestore.instance.collection('users').doc();

  final CollectionReference allusers =
      FirebaseFirestore.instance.collection("users");

  Future adduser(
      {String name, String email, String about, String avatar}) async {
    return await allusers.doc(uid).set({
      "name": name,
      "email": email,
      "about": about,
      "avatar": avatar,
      "downloads": 0.0,
      "uploads": 0.0,
      "contributions": 0.0,
    });
  }

  // Stream<DocumentSnapshot> get myUser {
  //   return userCollection.snapshots();
  // }
}
