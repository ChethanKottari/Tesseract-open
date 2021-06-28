import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tesseract/services/database.dart';

import '../models/user_data.dart';

class AuthService with ChangeNotifier {
  String uid;
  AppUser _appuser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _username = 'Name';
  String _userabout = "Write Something About you";
  String _userAvatar =
      "https://homepages.cae.wisc.edu/~ece533/images/baboon.png";
  //signIn annonymous
  AppUser get user {
    return _appuser;
  }

  AppUser createAppUser(User user) {
    return user != null
        ? AppUser(
            uid: user.uid,
            about: _userabout,
            email: user.email,
            imagePath: _userAvatar,
            name: _username,
            contribs: 0,
            downloads: 0,
            uploads: 0,
          )
        : null;
  }

  //authchageuser
  Stream<AppUser> get userStream {
    return _auth.authStateChanges().map((user) => createAppUser(
          user,
        ));
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
      return;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      {String email,
      String password,
      String name,
      String about,
      String avatarurl}) async {
    _username = name;
    _userabout = about;
    _userAvatar = avatarurl;

    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await DatabaseService(uid: user.user.uid).adduser(
        about: about,
        email: user.user.email,
        name: name,
        avatar: avatarurl,
      );
      return user.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
