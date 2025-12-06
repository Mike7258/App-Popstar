
import 'package:flutter/material.dart';
import 'package:popstar_database/screens/details_screen.dart';
import 'package:popstar_database/screens/home_screen.dart';
import 'package:popstar_database/screens/info_screen.dart';
import 'package:popstar_database/screens/splash_screen.dart';

class AppRoutes {
  // Nombres de las rutas
  static const String splashRoute = '/'; 
  static const String initialRoute = 'home'; 
  static const String detailsRoute = 'details';
  static const String infoRoute = 'info';
  static const String moviesRoute = 'movies'; // Nueva ruta: Todas las películas
  static const String searchRoute = 'search'; // Nueva ruta: Búsqueda

  // Mapa de rutas
  static Map<String, Widget Function(BuildContext)> routes = {
    splashRoute: (context) => const SplashScreen(), // Pantalla de carga
    initialRoute: (context) => const HomeScreen(), // Pantalla principal (con navegación)
    detailsRoute: (context) => const DetailsScreen(), 
    infoRoute: (context) => const InfoScreen(),
  };

  // Función para generar una ruta de error (por si acaso)
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      // Si la ruta no existe, vuelve al Home
      builder: (context) => const HomeScreen(), 
    );
  }
}