import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseract/models/user_data.dart';
import 'package:tesseract/services/auth.dart';

import './wrapper.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/authenticate_screen";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrapper();
  }
}
