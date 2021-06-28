import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesseract/models/user_data.dart';

// import '../models/uploads.dart';

class NumberWidget extends StatelessWidget {
  final bool dark;
  final AppUser user;

  NumberWidget(
    this.dark,
    this.user,
  );

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BuildButton(context, user.uploads, "Uploads", dark),
          buildDivider(dark),
          BuildButton(context, user.downloads, "Downloads", dark),
          buildDivider(dark),
          BuildButton(context, user.contribs, "Contributions", dark),
        ],
      ),
    );
  }
}

Widget BuildButton(
    BuildContext context, double number, String title, bool dark) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: MaterialButton(
      onPressed: () {},
      child: Column(
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: dark ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildDivider(bool dark) {
  return Container(
      height: 24,
      child: VerticalDivider(
        color: dark ? Colors.white54 : Colors.grey,
      ));
}
