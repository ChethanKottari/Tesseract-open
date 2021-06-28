import 'package:flutter/material.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../models/downloads.dart';
import '../provider/downloads_provider.dart';

class ToCloudUploadScreen extends StatefulWidget {
  @override
  _ToCloudUploadScreenState createState() => _ToCloudUploadScreenState();
}

class _ToCloudUploadScreenState extends State<ToCloudUploadScreen> {
  final filter = ProfanityFilter();
  var curr_branch = "EC";
  Map<String, String> branches = {
    "EC": "ELECTRONICS n COM",
    'CS': "COMPUTER SCIENCES",
    "EE": "ELECTRICAL n Electronics",
    "PS": "POLYMER SCIRNCES",
    'ME': 'MECHANICAL',
    'Bb': "entrepreneurial",
    'Ff': "FINANCE",
  };
  Map<String, List<String>> branchCategory = {
    "EC": [
      "signals and sys",
      "control systems",
      "analog electronics",
      "digital electronics",
      "switching circuits",
      "circuit theory",
      "mems",
      "DSP",
      "DIP",
      "VLSI"
    ],
    "CS": [
      "os",
      "DSA",
      "computer achitecture",
      "agile",
      "C++",
      "Java",
      "web dev",
      "app dev",
      "DBMS"
    ],
    "EE": [
      "signals and syst",
      "Induction Motors",
      "circuit analysis",
      "Electrical Budgeting"
    ],
    "PS": ["polymer materials", "BOnds", "design", "real world Polymers"],
    "ME": [
      "IC enginnes",
      "thermodynamics",
      "manufacturing processes",
      "strength of materials"
    ],
    "Bb": [
      "how to start",
      "how to find",
      "how to stay",
      "marketing",
      "prospect analysis",
      "market overview"
    ],
    "Ff": [
      "Basic finance",
      "Trading",
      "Equity markets",
      "Bonds",
      "Macro Economics"
    ],
  };
  int selectedIndex1 = 0;
  final domainFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  File _file;
  bool isLoading = false;
  var domain = "EC";
  var _createdDownload = DownloadFile(
      downloadUrl: null,
      fileName: '',
      uploadedOn: DateTime.now(),
      domain: '',
      description: '',
      contributions: 0,
      downloads: 0,
      userId: null,
      uploads: 0);

  @override
  void dispose() {
    domainFocusNode.dispose();
    super.dispose();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    print(result);
    if (result == null) {
      return;
    }

    final path = result.files.single.path;
    _file = File(path);
    print(_file);
  }

  Future<void> _saveForm(BuildContext context, String uid) async {
    setState(() {
      isLoading = true;
    });
    final isValidaed = _form.currentState.validate();

    if (!isValidaed || _file == null) {
      return;
    }

    _createdDownload = DownloadFile(
        fileName: _createdDownload.fileName,
        uploadedOn: DateTime.now(),
        domain: _createdDownload.domain,
        description: _createdDownload.description,
        downloadUrl: null,
        contributions: 0,
        downloads: 0,
        uploads: 0,
        userId: uid);
    _form.currentState.save();
    await Provider.of<DownloadsProvider>(context, listen: false).uloadFile(
      _createdDownload,
      _file,
      uid,
    );
    setState(() {
      isLoading = false;
    });

    // print(_createdDownload.fileName);
    // print(_createdDownload.description);
    // print(_createdDownload.domain);
    // print(_createdDownload.uploadedOn);
  }

  void showUploaddialog(BuildContext context, String uid) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.orange[300],
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Container(
                  height: 600,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "File Name",
                        ),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(domainFocusNode);
                        },
                        onSaved: (value) {
                          _createdDownload = DownloadFile(
                            fileName: value,
                            uploadedOn: _createdDownload.uploadedOn,
                            domain: _createdDownload.domain,
                            description: _createdDownload.description,
                            downloadUrl: null,
                            contributions: 0,
                            downloads: 0,
                            uploads: 0,
                            userId: uid,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "File Name cannot be empty";
                          }
                          if (filter.hasProfanity(value)) {
                            return "Please be appropiate";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Author ",
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: domainFocusNode,
                        onSaved: (value) {
                          _createdDownload = DownloadFile(
                            fileName: _createdDownload.fileName,
                            uploadedOn: _createdDownload.uploadedOn,
                            domain: _createdDownload.domain,
                            downloadUrl: null,
                            description: _createdDownload.description,
                            contributions: 0,
                            downloads: 0,
                            uploads: 0,
                            userId: uid,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Author Name cannot be empty.provide so the users have better experience";
                          }
                          if (filter.hasProfanity(value)) {
                            return "Please be appropiate";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Add description",
                        ),
                        maxLines: 3,
                        maxLength: 50,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          _createdDownload = DownloadFile(
                              fileName: _createdDownload.fileName,
                              downloadUrl: null,
                              uploadedOn: _createdDownload.uploadedOn,
                              domain: _createdDownload.domain,
                              description: value,
                              contributions: 0,
                              downloads: 0,
                              userId: uid,
                              uploads: 0);
                        },
                        validator: (value) {
                          if (value.isEmpty || value == null) {
                            return "Atleast 8 characters";
                          }
                          if (filter.hasProfanity(value)) {
                            return "Please be appropiate";
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Please select a category";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Select Domain",
                        ),
                        elevation: 4,
                        icon: Icon(Icons.expand_more_rounded),
                        value: curr_branch,
                        dropdownColor: Colors.indigo,
                        onChanged: (value) {
                          setState(() {
                            curr_branch = value;
                            print(branchCategory["EC"]);
                          });
                        },
                        items: branches.entries
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.key,
                                child: Text("${e.value} (${e.key})"),
                              ),
                            )
                            .toList(),
                        onSaved: (value) {
                          _createdDownload = DownloadFile(
                              fileName: _createdDownload.fileName,
                              downloadUrl: null,
                              uploadedOn: _createdDownload.uploadedOn,
                              domain: value,
                              description: _createdDownload.description,
                              contributions: 0,
                              downloads: 0,
                              userId: uid,
                              uploads: 0);
                        },
                      ),
                      if (branchCategory[_createdDownload.domain] != null)
                        DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return "Please select a sub domain";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Select Sub Domain",
                          ),
                          elevation: 4,
                          icon: Icon(Icons.expand_more_rounded),
                          dropdownColor: Colors.indigo,
                          items: branchCategory["EC"]
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text("$e"),
                                ),
                              )
                              .toList(),
                        ),
                      ElevatedButton(
                          onPressed: selectFile,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Select Pdf"),
                              Icon(Icons.picture_as_pdf),
                            ],
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final isValidaed = _form.currentState.validate();

                            if (!isValidaed || _file == null) {
                              return;
                            }
                            Navigator.of(context).pop();
                            _saveForm(context, uid);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Upload Doccument"),
                              Icon(Icons.cloud_upload_outlined),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final String uid = ModalRoute.of(context).settings.arguments as String;
    return isLoading
        ? Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Center(
                child: Text(
                  "Uploading Your File",
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ))
        : Container(
            child: Center(
              child: FloatingActionButton.extended(
                icon: Icon(
                  Icons.add,
                  size: 35,
                ),
                label: Text("Upload a File"),
                onPressed: () {
                  showUploaddialog(context, uid);
                },
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                splashColor: Colors.deepOrange,
              ),
            ),
          );
  }
}
