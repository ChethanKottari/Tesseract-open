import 'package:flutter/cupertino.dart';

class UserPreferences with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void toggleDarkMode() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
