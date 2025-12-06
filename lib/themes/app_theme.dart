import 'package:flutter/material.dart';

class AppTheme {

  static const Color primaryColor = Color(0xFF504E76); // Morado oscuro 
  static const Color accentColor = Color(0xFFF1642E); // Naranja 
  static const Color lightPurple = Color(0xFFC4C3E3); // Lila claro
  static const Color creamBackground = Color(0xFFFDF8E2); // Fondo Crema
  static const Color oliveGreen = Color(0xFFA3B565); // Verde Oliva

  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: creamBackground,
    colorScheme: const ColorScheme.light( 
      primary: primaryColor,
      secondary: accentColor,
      background: creamBackground,
      surface: lightPurple,
    ),

    fontFamily: 'Inter',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Berthold Block', 
        fontSize: 28.0, 
        fontWeight: FontWeight.bold, 
        color: primaryColor,
      ),

      titleLarge: TextStyle(
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
        color: primaryColor,
      ),

      bodyMedium: TextStyle(
        fontSize: 14.0, 
        color: primaryColor,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Berthold Block', 
        fontSize: 24, 
        fontWeight: FontWeight.bold,
        color: creamBackground,
      ),
      iconTheme: IconThemeData(color: creamBackground),
    ),

    cardTheme: CardThemeData( 
      color: AppTheme.lightPurple, 
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}