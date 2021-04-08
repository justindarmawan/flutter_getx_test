import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: redColor,
  backgroundColor: whiteColor,
  accentColor: blueColor,
  buttonColor: yellowColor,
  accentColorBrightness: Brightness.dark,
  fontFamily: GoogleFonts.montserrat().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      primary: yellow,
      onPrimary: white,
      textStyle: TextStyle(fontSize: 20),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: yellow,
      textStyle: TextStyle(fontSize: 20),
    ),
  ),
  textTheme: TextTheme(
    headline3: TextStyle(
      fontSize: 25.0,
      color: Colors.black,
    ),
    headline4: TextStyle(
      fontSize: 22.0,
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    headline6: TextStyle(
      fontSize: 18.0,
      color: Colors.black,
    ),
  ),
);
