import 'package:flutter/material.dart';

class AppUser {
  final String uid;
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final double uploads;
  final double downloads;
  final double contribs;

  const AppUser({
    @required this.uid,
    @required this.imagePath,
    @required this.name,
    @required this.email,
    @required this.about,
    @required this.contribs,
    @required this.downloads,
    @required this.uploads,
  });
}
