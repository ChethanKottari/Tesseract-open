import 'package:flutter/material.dart';

Widget BuildCircle({Widget child, double all, Color color}) {
  return ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child,
    ),
  );
}
