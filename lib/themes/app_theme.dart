import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de colores basada en el PDF de identidad visual
  static const Color primaryColor = Color(0xFF504E76); // Morado oscuro (Deep Purple)
  static const Color accentColor = Color(0xFFF1642E); // Naranja (Orange)
  static const Color lightPurple = Color(0xFFC4C3E3); // Lila claro
  static const Color creamBackground = Color(0xFFFDF8E2); // Fondo Crema
  static const Color oliveGreen = Color(0xFFA3B565); // Verde Oliva

  // Tema general de la aplicación
  static final ThemeData lightTheme = ThemeData(
    // 1. Configuración de colores
    primaryColor: primaryColor,
    scaffoldBackgroundColor: creamBackground,
    colorScheme: const ColorScheme.light( 
      primary: primaryColor,
      secondary: accentColor,
      background: creamBackground, // <-- ¡CORREGIDO! Faltaba el color de fondo.
      surface: lightPurple,
    ),
    
    // 2. Configuración de tipografía (simulando Ahkio/Berthold Block con 'Inter' como fallback)
    fontFamily: 'Inter', // Utiliza un font conocido o importa las fuentes
    textTheme: const TextTheme(
      // Títulos grandes con el color primario
      headlineLarge: TextStyle(
        fontFamily: 'Berthold Block', // Asume que esta fuente está importada
        fontSize: 28.0, 
        fontWeight: FontWeight.bold, 
        color: primaryColor,
      ),
      // Títulos de cards, etc.
      titleLarge: TextStyle(
        fontSize: 18.0, 
        fontWeight: FontWeight.bold, 
        color: primaryColor,
      ),
      // Texto principal, descripciones
      bodyMedium: TextStyle(
        fontSize: 14.0, 
        color: primaryColor,
      ),
    ),

    // 3. Configuración del AppBar
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

    // 4. Configuración de Cards
    cardTheme: CardThemeData( // <-- ¡CORREGIDO! Se añadió 'const'.
      color: AppTheme.lightPurple, 
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}