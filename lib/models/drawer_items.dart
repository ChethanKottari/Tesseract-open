import 'package:flutter/material.dart';

import './drawer_item.dart';
import '../screens/downloads_screen.dart';

final itemsFirst = [
  DrawerItem(
    title: "My Activity",
    icon: Icons.run_circle_outlined,
    route: '',
  ),
  DrawerItem(
      title: "Downloads",
      icon: Icons.cloud_download,
      route: Downloads.routeName),
  DrawerItem(
    title: "Uploads",
    icon: Icons.cloud_upload,
    route: '',
  ),
];

final itemsSecond = [
  DrawerItem(
    title: "What Is Tesseract",
    icon: Icons.question_answer,
    route: '',
  ),
  DrawerItem(
    title: "About us",
    icon: Icons.people,
    route: '',
  ),
  DrawerItem(
    title: "Report Abuse",
    icon: Icons.report,
    route: '',
  ),
];
