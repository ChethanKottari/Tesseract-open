import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/search_service.dart';

class Mydownloads extends StatefulWidget {
  @override
  _MydownloadsState createState() => _MydownloadsState();
}

class _MydownloadsState extends State<Mydownloads> {
  var querryresult = [];
  var tempQueryStore = [];
  var _isLoading = false;
  final TextEditingController _controller = TextEditingController();

  void initiateSearch(value) {
    if (value == null) {
      return;
    }
    print(value);
    if (value.length == 0) {
      setState(() {
        _isLoading = true;
        querryresult = [];
        tempQueryStore = [];
        _isLoading = false;
      });
      return;
    }
    var capatilizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (querryresult.length == 0 && value.length == 1) {
      SearchService().searchByname(value).then((docks) {
        for (int i = 0; i < docks.docs.length; ++i) {
          print(docks.docs[i].data());
          querryresult.add(docks.docs[i].data());
          print(querryresult);
        }
      });
      print(capatilizedValue);
      // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      print(querryresult);
      return;
    }
    tempQueryStore = [];
    querryresult.forEach((element) {
      if (element["FileName"].toUpperCase().startsWith(capatilizedValue)) {
        setState(() {
          _isLoading = true;

          tempQueryStore.add(element);
          _isLoading = false;
        });
      }
    });
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() => initiateSearch(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? CircularProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _controller,
                    // onChanged: (val) {
                    //   initiateSearch(val);
                    // },
                    // onChanged: initiateSearch,
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                          color: Colors.orange,
                          icon: Icon(Icons.arrow_back),
                          iconSize: 20.0,
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.only(left: 25.0),
                        hintText: 'Search By Name',
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 10, color: Colors.orange),
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                SizedBox(height: 20),
                GridView.count(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    primary: false,
                    shrinkWrap: true,
                    children: tempQueryStore.map((e) {
                      return buildresultcard(e);
                    }).toList()),
              ],
            ),
    );
  }
}

Widget buildresultcard(data) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 4,
    child: Center(
      child: Text(
        data["FileName"],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ),
  );
}
