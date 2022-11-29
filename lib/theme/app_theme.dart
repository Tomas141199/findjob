import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF0487D9);
  static const Color deepBlue = Color(0xFF004D85);
  static const Color accentPink = Color(0xFFFF2772);
  static const Color textColor = Color.fromRGBO(13, 13, 13, 1);
  static const Color whiteApp = Color(0xFFFFFDFC);

  static final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );        

  static Color getRandomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  static const BoxDecoration backgroundRounded = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ));

  static const TextStyle subEncabezado = TextStyle(
    fontSize: 20.0,
    color: deepBlue,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subEncabezadoDos = TextStyle(
    fontSize: 16.0,
    color: deepBlue,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle subEncabezadoTres = TextStyle(
    fontSize: 25.0,
    color: deepBlue,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle datos = TextStyle(
    fontSize: 15.0,
    color: textColor,
  );
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    disabledColor: deepBlue,
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
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
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
