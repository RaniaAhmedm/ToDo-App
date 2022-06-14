import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  void changeAppLanguage(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', langCode);
    if (langCode == appLanguage) return;
    appLanguage = langCode;
    notifyListeners();
  }

  void changeAppTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', themeMode == ThemeMode.light ? 'light' : 'dark');
    if (themeMode == appTheme) return;
    appTheme = themeMode;
    notifyListeners();
  }

  String getMainBackground() {
    return appTheme == ThemeMode.light
        ? 'assets/images/main_background.png'
        : 'assets/images/dark_main_backgroub.png';
  }
}
