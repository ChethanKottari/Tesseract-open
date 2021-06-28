import 'package:flutter/material.dart';
import 'package:tesseract/models/user_data.dart';
import 'package:tesseract/screens/uploads_screen.dart';
import 'package:tesseract/widgets/profile_widget.dart';

import '../widgets/number_widget.dart';

class Activity extends StatelessWidget {
  static const routeName = '/activity';

  @override
  Widget build(BuildContext context) {
    final AppUser user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFF1a2F45),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF1a2F45),
        title: Text(
          "My Activities",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              isedit: false,
              onClicked: () {},
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "${user.name}'s Activity So Far",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: NumberWidget(
                            false,
                            user,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.orange,
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UploadScreen.routeName);
                },
                child: Card(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  borderOnForeground: true,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        "Boost activity uploading more files",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
