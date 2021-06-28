import 'package:flutter/material.dart';

class DrawerNavigationProvider with ChangeNotifier {
  bool _isColapsed = false;

  bool get isColapsed {
    return _isColapsed;
  }

  void toggleIsColapsed() {
    _isColapsed = !_isColapsed;
    notifyListeners();
  }
}
