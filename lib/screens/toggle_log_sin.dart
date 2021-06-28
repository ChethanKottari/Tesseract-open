import 'package:flutter/material.dart';
import 'package:tesseract/screens/register.dart';
import 'package:tesseract/screens/signIn_screen_screen.dart.dart';

class ToggleLS extends StatefulWidget {
  @override
  _ToggleLSState createState() => _ToggleLSState();
}

class _ToggleLSState extends State<ToggleLS> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return Register(toggleView);
    }
  }
}
