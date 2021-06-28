import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/uploads.dart';
import '../provider/downloads_provider.dart';

class MyUploads extends StatelessWidget {
  final String uid;
  MyUploads(this.uid);

  @override
  Widget build(BuildContext context) {
    final futfunc = Provider.of<DownloadsProvider>(context).userFetchset(uid);
    // final List<Upload> uploads =
    //     Provider.of<DownloadsProvider>(context).getUploads;
    return FutureBuilder(
        future: futfunc,
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
            print(snapshot.data);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final uploads = snapshot.data;
            return GridView.builder(
              itemCount: uploads.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.greenAccent,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.green,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                maxRadius: 15,
                                child: Text(uploads[index].domain),
                              ),
                              title: Text(
                                uploads[index].fileName.toUpperCase(),
                                style: TextStyle(fontSize: 20),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 20,
                              padding: EdgeInsets.all(2),
                              width: double.infinity,
                              child: Text(
                                uploads[index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Divider(),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.download_done_sharp,
                                          color: Colors.redAccent,
                                        ),
                                        // Text(
                                        //     "Downloads ${uploads[index].downloads}",
                                        //     style: TextStyle(
                                        //         color: Colors.redAccent)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    DateFormat.yMMMMd('en_US').format(
                                      uploads[index].uploadedOn,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
