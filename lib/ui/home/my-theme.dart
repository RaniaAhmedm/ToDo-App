import 'package:flutter/material.dart';

class MyThemeData {
  static Color primaryLightColor = Color.fromARGB(255, 93, 156, 236);
  static Color primaryDarkColor = Color.fromARGB(255, 93, 156, 236);
  static Color lightBackgroundColor = Color.fromARGB(255, 223, 236, 219);
  static Color darkBackgroundColor = Color.fromARGB(255, 6, 14, 30);
  static Color whiteColor = Colors.white;
  static Color blackColor = Colors.black;
  static Color greenColor = Color.fromARGB(255, 97, 231, 87);
  static Color redColor = Color.fromARGB(255, 236, 75, 75);
  static Color greyColor = Color.fromARGB(255, 120, 120, 120);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      primary: primaryLightColor,
      onPrimary: whiteColor,
      secondary: lightBackgroundColor,
      onSecondary: whiteColor,
      error: Colors.red,
      onError: Colors.red,
      surface: whiteColor,
      onSurface: greyColor,
      background: lightBackgroundColor,
      onBackground: primaryLightColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLightColor,
      iconTheme: IconThemeData(color: whiteColor),
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: whiteColor,
      ),
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color:primaryLightColor,
          fontStyle: FontStyle.italic
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: greyColor,
      ),
      subtitle1: TextStyle(
          color: primaryLightColor, fontSize: 20, fontWeight: FontWeight.w400),
      bodyText1: TextStyle(
        fontSize: 12,
        color: blackColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      selectedItemColor: primaryLightColor,
      unselectedItemColor: Colors.grey.shade500,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLightColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      primary: primaryDarkColor,
      onPrimary: whiteColor,
      secondary: darkBackgroundColor,
      onSecondary: whiteColor,
      error: Colors.red,
      onError: Colors.red,
      surface: whiteColor,
      onSurface: greyColor,
      background: darkBackgroundColor,
      onBackground: primaryDarkColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryDarkColor,
      iconTheme: IconThemeData(color: whiteColor),
      elevation: 0.0,
    ),
    textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: whiteColor,
        fontStyle: FontStyle.italic
      ),
      headline3: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      headline4: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
      subtitle2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color:primaryDarkColor,
      ),
      headline5: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: greyColor,
      ),
      subtitle1: TextStyle(
          color: primaryDarkColor, fontSize: 20, fontWeight: FontWeight.w400),
      bodyText1: TextStyle(
        fontSize: 12,
        color: blackColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: whiteColor,
      selectedItemColor: primaryDarkColor,
      unselectedItemColor: Colors.grey.shade500,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDarkColor,
    ),
  );

}
