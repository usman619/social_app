import 'package:flutter/material.dart';
import 'package:social_app/themes/dark_mode.dart';
import 'package:social_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // initial theme --> light mode
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (!isDarkMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
