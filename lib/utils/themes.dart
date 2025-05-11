import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
  bodyLarge: GoogleFonts.poppins(fontSize: 22.0),
  bodyMedium: GoogleFonts.poppins(fontSize: 20.0),
  bodySmall: GoogleFonts.poppins(fontSize: 18.0),
  titleLarge: GoogleFonts.poppins(fontSize: 36.0),
  titleSmall: GoogleFonts.poppins(fontSize: 28.0),
  titleMedium: GoogleFonts.poppins(fontSize: 24.0),
  labelLarge: GoogleFonts.poppins(fontSize: 18.0),
  labelSmall: GoogleFonts.poppins(fontSize: 14.0),
  labelMedium: GoogleFonts.poppins(fontSize: 16.0),
);

Color lightTeal = const Color.fromARGB(255, 22, 190, 173);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: textTheme,
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
  textTheme: textTheme,
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
