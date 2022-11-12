import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0487D9);
  static const Color deepBlue = Color(0xFF004D85);
  static const Color accentPink = Color(0xFFFF2772);

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //Color primario
    primaryColor: primary,
    //AppBar Theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
    //TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    //Floationg action button
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primary),

    //Elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: primary, shape: const StadiumBorder(), elevation: 0),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: primary,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primary,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
      //Color primario
      primaryColor: Colors.indigo,
      //AppBar Theme
      appBarTheme: const AppBarTheme(color: primary, elevation: 0),
      scaffoldBackgroundColor: Colors.black);
}
