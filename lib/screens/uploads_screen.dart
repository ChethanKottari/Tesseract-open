import 'package:flutter/material.dart';

import './my_upoads.dart';
import './to_cloud_upload.dart';

class UploadScreen extends StatelessWidget {
  static const routeName = "/uploads";
  Widget build(BuildContext context) {
    final String uid = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF1a2F45),
          title: Text(
            "Uploads",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.cloud_done_rounded),
                text: "My Uploads",
              ),
              Tab(
                icon: Icon(Icons.cloud_upload),
                text: "To cloud",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          MyUploads(uid),
          ToCloudUploadScreen(),
        ]),
      ),
    );
  }
}
