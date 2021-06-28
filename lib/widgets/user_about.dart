import 'package:flutter/material.dart';

import '../models/user_data.dart';

class BuildAbout extends StatelessWidget {
  final AppUser user;
  final bool dark;
  BuildAbout(this.user, this.dark);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("About",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              )),
          SizedBox(
            height: 24,
          ),
          Container(
            width: 320,
            height: 150,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: SingleChildScrollView(
              child: Text(user.about,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
