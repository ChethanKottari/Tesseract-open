import 'package:flutter/foundation.dart';

class Upload {
  final String fileName;
  final String description;
  final DateTime uploadedOn;
  String domain;
  int downloads;

  Upload({
    @required this.fileName,
    @required this.description,
    @required this.uploadedOn,
    @required this.domain,
    @required this.downloads,
  });
}
