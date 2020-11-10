import 'package:flutter/material.dart';

class Constants {
  static String appName = "ashva";
//blue graident #00416A --> #E4E5E6
  //Colors for theme
//  static Color lightPrimary = Colors.orange[300];
//  static Color darkPrimary = Constants.darkPrimary;
//  static Color lightAccent = Colors.yellow[700];
//  static Color darkAccent = Color(0xff5563ff);
//  static Color lightBG = Color(0xfffcfcff);
//  static Color darkBG = Colors.black;
//  static Color ratingBG = Colors.yellow[600];

  // static Color lightPrimary = Colors.orange[300];
  // static Color darkPrimary = Colors.orange[600];

//blue main
  // static Color darkPrimary = Color(0xff3f2b96);
  // static Color lightPrimary = Color(0xff1CB5E0);
  // static Color lightAccent = Color(0xff00416A);

//green yellow
  // static Color darkPrimary = Color(0xff11998e);
  // static Color lightPrimary = Color(0xff38ef7d);
  // static Color lightAccent = Color(0xff71B280);

//dark green
  // static Color darkPrimary = Color(0xff134E5E);
  // static Color lightPrimary = Color(0xff71B280);
  // static Color lightAccent = Color(0xff71B280);

//green yellow mix
  // static Color darkPrimary = Color(0xff00416A);
  // static Color lightPrimary = Color(0xffFFE000);
  // static Color lightAccent = Color(0xff00416A);

//deep blue Gates reference

  static Color darkPrimary = Color(0xff4c205d);
  static Color lightPrimary = Color(0xff6f568d); //#ada0be
  static Color lightAccent = Color(0xff57387b);

  // static Color lightAccent = Colors.yellow[700];
  static Color darkAccent = Color(0xff5563ff);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellow[600];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );
}
