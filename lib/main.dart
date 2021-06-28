import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:tesseract/provider/user_preferences.dart';
import 'package:tesseract/screens/activity_screen.dart';

import './provider/drawer_navigation_provider.dart';
// import './screens/user_profile.dart';
import './screens/downloads_screen.dart';
import './screens/uploads_screen.dart';
import './provider/downloads_provider.dart';
import './screens/authenticate_screen.dart';
import './services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DrawerNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserPreferences(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DownloadsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tesseract",
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.orange,
          dividerColor: Colors.black54,
        ),
        home: AuthScreen(),
        routes: {
          // UserProfile.routeName: (ctx) => UserProfile(),
          Downloads.routeName: (ctx) => Downloads(),
          UploadScreen.routeName: (ctx) => UploadScreen(),
          Activity.routeName: (ctx) => Activity(),
        },
      ),
    );
  }
}
