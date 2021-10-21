import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CalculatorTheme {
  static double elevationValue = 7.0;
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
backgroundColor: Colors.white,
    primaryColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevationValue),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.w300
      ),
      bodyText2: TextStyle(
          color: Colors.black26,
          fontSize: 28,
          fontWeight: FontWeight.w300

      ),
      headline1: TextStyle(
          color: Colors.orange,
          fontSize: 28,
          fontWeight: FontWeight.w300
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 46,
        fontWeight: FontWeight.w300,
      ),
    ),

    // textTheme: GoogleFonts.getFont('Roboto')
  );
  static final darkTheme = ThemeData(
scaffoldBackgroundColor: Colors.black12,
    primaryColor: Colors.black,
    backgroundColor: Colors.black,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(elevationValue),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w300

      ),
      bodyText2: TextStyle(
          color: Colors.white30,
          fontSize: 28,
          fontWeight: FontWeight.w300

      ),
      headline1: TextStyle(
          color: Colors.orange,
          fontSize: 28,
          fontWeight: FontWeight.w300
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 46,
        fontWeight: FontWeight.w300,
      ),
    ),

    // textTheme: GoogleFonts.getFont('Roboto')
  );

}