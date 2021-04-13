import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData themeData;
  bool dark = true;
  final lightTheme = ThemeData.light().copyWith(
      primaryColor: Colors.cyan,
      primaryColorBrightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black));
  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
  );
  ThemeChanger() {
    themeData = darkTheme;
    dark = true;
  }
  ThemeData getTheme() => themeData;
  void themeSwitch() {
    if (themeData == darkTheme) {
      dark = false;
      themeData = lightTheme;
    } else {
      dark = true;
      themeData = darkTheme;
    }
    notifyListeners();
  }
}
