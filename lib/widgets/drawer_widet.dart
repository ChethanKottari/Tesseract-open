import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseract/models/user_data.dart';
import 'package:tesseract/screens/activity_screen.dart';
import 'package:tesseract/services/auth.dart';
import 'package:clipboard/clipboard.dart';

import '../provider/drawer_navigation_provider.dart';
import '../screens/downloads_screen.dart';
import '../screens/uploads_screen.dart';

// import '../models/drawer_item.dart';
// import '../models/drawer_items.dart';

class DrawerWidget extends StatelessWidget {
  final String uid;
  final AppUser user;
  DrawerWidget(
    this.uid,
    this.user,
  );
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    final isColapsed =
        Provider.of<DrawerNavigationProvider>(context).isColapsed;
    return Container(
      width: isColapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        child: Container(
          color: Color(0xFF1a2F45),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 1).add(safeArea),
                child: buildHeader(isColapsed),
                color: Colors.white12,
                width: double.infinity,
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.run_circle_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Activity.routeName, arguments: user);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "My Activity",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.run_circle_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Activity.routeName, arguments: user);
                        },
                      ),
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.download_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Downloads.routeName);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "Downloads",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.download_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Downloads.routeName);
                        },
                      ),
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.upload_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              UploadScreen.routeName,
                              arguments: uid);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "Uploads",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                        leading: Icon(
                          Icons.upload_rounded,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              UploadScreen.routeName,
                              arguments: uid);
                        },
                      ),
              ),
              Divider(color: Colors.white60),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.people,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          showAboutDialog(context);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "About Tesseract",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.people,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          showAboutDialog(context);
                        },
                      ),
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.help,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          showContribDialog(context);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "Contribute",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.help,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          showContribDialog(context);
                        },
                      ),
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.report,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          shoReportbDialog(context);
                        },
                      )
                    : ListTile(
                        title: Text(
                          "Report",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.report,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          shoReportbDialog(context);
                        },
                      ),
              ),
              Material(
                color: Colors.transparent,
                child: isColapsed
                    ? ListTile(
                        leading: Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await _auth.signOut();
                        },
                      )
                    : ListTile(
                        title: Text(
                          "LogOut",
                          style: TextStyle(color: Colors.white70),
                        ),
                        leading: Icon(
                          Icons.logout,
                          size: 30,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await _auth.signOut();
                        },
                      ),
              ),
              Spacer(),
              buildColapsibleIcon(context, isColapsed)
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildColapsibleIcon(BuildContext context, bool isColapsed) {
  final icon = isColapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
  final margin = EdgeInsets.only(right: 15);
  final align = isColapsed ? Alignment.center : Alignment.centerRight;
  final double size = isColapsed ? double.infinity : 52;
  return Container(
    alignment: align,
    margin: margin,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        child: Container(
          alignment: align,
          width: size,
          height: 52,
          child: Icon(icon, color: Colors.white),
        ),
        onTap: () {
          print("taped");
          final provider =
              Provider.of<DrawerNavigationProvider>(context, listen: false);
          provider.toggleIsColapsed();
        },
      ),
    ),
  );
}

Widget buildHeader(bool isColapsed) => isColapsed
    ? CircleAvatar(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "TOC",
              style: TextStyle(),
            )))
    : Row(
        children: [
          const SizedBox(
            width: 24,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
                child: Text(
              "TOC",
              style: TextStyle(),
            )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Tesseract",
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ],
      );

void showAboutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 15,
          insetPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xFF1a2F45),
          child: Container(
            width: 320,
            height: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                "Tessract is a cloud project for aggregation of e-resources that univ students use for learning,unforutnately this is usually lost when the learning process is over, now anyone can upload these files into private Tesseract Open Cloud(TOC). These uploaded files and doccuments are available for download to all other users. User stat can be seen in the profile page or My activity ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                  wordSpacing: 2,
                ),
              ),
            ),
          ),
        );
      });
}

void showContribDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 15,
          insetPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xFF1a2F45),
          child: Container(
            width: 320,
            height: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await FlutterClipboard.copy(
                        "tesseractsjce@gmail.com",
                      );
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Copy email",
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(
                            height: 3,
                          ),
                          Icon(Icons.copy, color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """Tessract is a cloud project for aggregation of e-resources that univ students use for learning.

keeping this in perspective, if you think you can contribute to this project(UI,UX,data management etc..)

Feel free to contact us at

        tesseractsjce@gmail.com
""",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void shoReportbDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 15,
          insetPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color(0xFF1a2F45),
          child: Container(
            width: 320,
            height: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      await FlutterClipboard.copy(
                        "tesseractsjce@gmail.com",
                      );
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Copy email",
                              style: TextStyle(color: Colors.white54)),
                          SizedBox(
                            height: 3,
                          ),
                          Icon(Icons.copy, color: Colors.white54),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    """We are sorry to see you here :-(.

Please address this issue to the mail mentioned below.
We will do everything we can to solve the issue :-)

tesseractsjce@gmail.com
""",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      wordSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
