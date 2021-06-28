import 'package:flutter/foundation.dart';

class DownloadFile {
  final String fileName;
  final DateTime uploadedOn;
  final String domain;
  final String description;
  final String downloadUrl;
  final double downloads;
  final double uploads;
  final double contributions;
  final String userId;
  DownloadFile({
    @required this.fileName,
    @required this.uploadedOn,
    @required this.domain,
    @required this.description,
    @required this.downloadUrl,
    @required this.downloads,
    @required this.contributions,
    @required this.uploads,
    @required this.userId,
  });
}
