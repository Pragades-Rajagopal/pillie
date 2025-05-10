import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    surface: Colors.white, // grey 300
    primary: Colors.black,
    secondary: Color(0xFF757575), //grey 600
    tertiary: Color(0xFFBDBDBD), //grey 400
    primaryContainer: Color.fromARGB(255, 244, 244, 244),
    surfaceBright: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    backgroundColor: Colors.black,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    surface: Colors.black,
    primary: Colors.white,
    secondary: Color(0xFFB8B8B8),
    tertiary: Color(0xFF757575),
    primaryContainer: Color(0xFF3D3D3D),
    surfaceBright: Colors.white,
  ),
);
