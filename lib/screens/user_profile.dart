import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/profile_widget.dart';
import '../provider/user_preferences.dart';
import '../models/user_data.dart';
import '../widgets/button_widget.dart';
import '../widgets/number_widget.dart';
import '../widgets/user_about.dart';
import '../widgets/drawer_widet.dart';

class UserProfile extends StatefulWidget {
  static const routeName = '/first_screen';
  final AppUser userbro;
  final String uid;
  UserProfile(this.userbro, this.uid);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    // final userpref = Provider.of<UserPreferences>(context, listen: false);
    // final user = userpref.myUser;
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder(
        future: users.doc(widget.uid).get(),
        builder: (ctx, snapShot) {
          if (snapShot.hasError) {
            return Text("Something went wrong");
          }
          if (snapShot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapShot.data.data();
            // print(data);
            AppUser user = AppUser(
              about: data["about"],
              email: data["email"],
              imagePath: data["avatar"],
              name: data["name"],
              uid: widget.uid,
              contribs: data["contributions"],
              downloads: data["downloads"],
              uploads: data["uploads"],
            );
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: Scaffold(
                drawer: DrawerWidget(widget.uid, user),
                appBar: BuildAppbar(context, user),
                body: SafeArea(
                  child: Consumer<UserPreferences>(
                    builder: (context, userpref, _) => Container(
                      color: userpref.isDark ? Color(0xFF1a2F45) : Colors.white,
                      padding: EdgeInsets.only(top: 20),
                      child: ListView(
                        children: [
                          Center(
                            child: Text(
                              "Pull to refresh",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          SizedBox(height: 5),
                          ProfileWidget(
                            imagePath: user.imagePath,
                            onClicked: () async {},
                            isedit: false,
                          ),
                          SizedBox(height: 24),
                          BuildInformation(user, userpref.isDark),
                          SizedBox(height: 24),
                          Center(
                            child: BuildPriviledgedButton(
                                userpref.isDark, context),
                          ),
                          SizedBox(height: 24),
                          NumberWidget(userpref.isDark, user),
                          SizedBox(height: 15),
                          Divider(
                            color: Colors.indigo,
                            endIndent: 15,
                            indent: 15,
                            thickness: 2,
                          ),
                          SizedBox(height: 15),
                          BuildAbout(user, userpref.isDark),
                          SizedBox(height: 50),
                          Divider(
                            color: Colors.indigo,
                            endIndent: 15,
                            indent: 15,
                            thickness: 2,
                          ),
                          Center(
                            child: FlatButton(
                              onPressed: () {},
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "edit profile",
                                      style: TextStyle(
                                          color: userpref.isDark
                                              ? Colors.white
                                              : Colors.black54),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.edit,
                                      color: userpref.isDark
                                          ? Colors.white
                                          : Colors.black54,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.indigo,
                            endIndent: 15,
                            indent: 15,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

Widget BuildPriviledgedButton(bool dark, BuildContext context) {
  final snackBar = SnackBar(content: Text('Priviledge not Enabled yet'));
  onclick() {
    Scaffold.of(context).showSnackBar(snackBar);
  }

  return ButtonWidget(
    text: "Priviledged doccuents here",
    onClicked: onclick,
    dark: dark,
  );
}

Widget BuildInformation(AppUser user, bool dark) {
  return Column(
    children: [
      Text(
        user.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: dark ? Colors.white : Colors.black,
        ),
      ),
      const SizedBox(height: 10),
      Text(
        user.email,
        style: TextStyle(
          color: dark ? Colors.white54 : Colors.black54,
        ),
      )
    ],
  );
}

AppBar BuildAppbar(BuildContext context, AppUser user) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    title: Text(
      user.name,
      style: TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    backgroundColor: Color(0xFF1a2F45),
    actions: [
      IconButton(
          icon: Icon(
            CupertinoIcons.moon_stars,
          ),
          onPressed: () {
            Provider.of<UserPreferences>(context, listen: false)
                .toggleDarkMode();
          })
    ],
  );
}
