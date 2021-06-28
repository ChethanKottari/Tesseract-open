import 'package:flutter/material.dart';

import './in_cloud_downloads.dart';
import './my_downloads.dart';

class Downloads extends StatefulWidget {
  static const routeName = "/downloads";

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  var lookup = "EC";
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Color(0xFF1a2F45),
          centerTitle: true,
          title: Text(
            "Downloads",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          actions: [
            PopupMenuButton(
                elevation: 7,
                padding: EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                onSelected: (value) {
                  setState(() {
                    lookup = value;
                  });
                },
                icon: Icon(Icons.search_rounded),
                itemBuilder: (ctontext) => [
                      PopupMenuItem(
                        child: Text("Electronics and Com"),
                        value: "EC",
                      ),
                      PopupMenuItem(
                        child: Text("Computer Science"),
                        value: "CS",
                      ),
                      PopupMenuItem(
                        child: Text("Electrical Electronics"),
                        value: "EE",
                      ),
                      PopupMenuItem(
                        child: Text("Mechanical "),
                        value: "ME",
                      ),
                      PopupMenuItem(
                        child: Text("Entrepreneurial"),
                        value: "Bb",
                      ),
                      PopupMenuItem(
                        child: Text("Finance"),
                        value: "Ff",
                      ),
                      PopupMenuItem(
                        child: Text("Ploymer Science"),
                        value: "PS",
                      ),
                    ]),
          ],
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.find_in_page_outlined),
                text: "Search By Name",
              ),
              Tab(
                icon: Icon(Icons.file_download),
                text: "In cloud",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Mydownloads(),
          InCloudScreen(lookup),
        ]),
      ),
    );
  }
}
