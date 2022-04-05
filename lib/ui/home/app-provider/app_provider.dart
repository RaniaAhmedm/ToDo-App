import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier{
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;
  void changeAppLanguage(String langCode) {
    appLanguage = langCode;
    notifyListeners();
  }
  void changeAppTheme(ThemeMode themeMode) {
    appTheme = themeMode;
    notifyListeners();
  }
  String getMainBackground() {
    return appTheme == ThemeMode.light
        ? 'assets/images/main_background.png'
        : 'assets/images/dark_main_backgroub.png';
  }
}