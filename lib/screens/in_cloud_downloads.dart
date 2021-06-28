import 'dart:isolate';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../models/downloads.dart';
import '../provider/downloads_provider.dart';

class InCloudScreen extends StatefulWidget {
  final lookup;
  InCloudScreen(this.lookup);

  @override
  _InCloudScreenState createState() => _InCloudScreenState();
}

class _InCloudScreenState extends State<InCloudScreen> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  void downloadFile(String urllink, String fileName, String thatUser) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await path.getExternalStorageDirectory();
      print("******************");
      print(baseStorage.path);
      print(urllink);

      final id = await FlutterDownloader.enqueue(
        url: urllink,
        savedDir: baseStorage.path,
        fileName: fileName,
        openFileFromNotification: true,
      );
      print("******************");
      await users.doc(thatUser).update({"downloads": FieldValue.increment(1)});
    } else {
      print("no access");
      return;
    }
  }

  ReceivePort reciever = ReceivePort();
  @override
  void initState() {
    IsolateNameServer.registerPortWithName(reciever.sendPort, "downloading");

    reciever.listen((message) {
      // print(message);
    });

    FlutterDownloader.registerCallback(callbacker);
    super.initState();
  }

  static callbacker(id, status, progress) {
    SendPort sender = IsolateNameServer.lookupPortByName("downloading");
    sender.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    // final List<DownloadFile> files =
    //     Provider.of<DownloadsProvider>(context).getFiles;

    final futFunc =
        Provider.of<DownloadsProvider>(context).fetchAndSet(widget.lookup);
    Future<void> reloader() async {
      setState(() {});
      // await futFunc;
    }

    return FutureBuilder(
      initialData: [],
      future: futFunc,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          print("has an error");
          print(snapshot.error.toString());
          return Center(
            child: Text('Something Went wrong,Try Again :-))'),
          );
        }
        if (snapshot.hasData) {
          // print(snapshot.data);
          print(snapshot.data.forEach((value) {
            print(value.fileName);
          }));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          final List<DownloadFile> files = snapshot.data;
          return RefreshIndicator(
            onRefresh: reloader,
            child: ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient:
                          LinearGradient(colors: [Colors.orange, Colors.white]),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.orange,
                        onTap: () {},
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(files[index].domain),
                          ),
                          title: Text(
                            files[index].fileName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          dense: false,
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  files[index].description ?? "no description",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.file_download,
                            ),
                            onPressed: () async {
                              if (files[index].downloadUrl == "" ||
                                  files[index].downloadUrl == null ||
                                  files[index].fileName == "" ||
                                  files[index].fileName == null) {
                                return;
                              }
                              downloadFile(
                                files[index].downloadUrl,
                                files[index].fileName,
                                files[index].userId,
                              );
                            },
                            iconSize: 30,
                            splashColor: Colors.orange,
                            splashRadius: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
            backgroundColor: Colors.green,
          ),
        );
      },
    );
  }
}
