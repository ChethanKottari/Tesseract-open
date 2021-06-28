import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseract/models/user_data.dart';
import 'package:tesseract/screens/signIn_screen_screen.dart.dart';
import 'package:tesseract/screens/toggle_log_sin.dart';
import 'package:tesseract/screens/user_profile.dart';
import 'package:tesseract/services/auth.dart';

class Wrapper extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.userStream,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        }
        final AppUser user = snapshot.data;
        if (user == null) {
          return ToggleLS();
        }
        return UserProfile(user, user.uid);
      },
    );
  }
}
