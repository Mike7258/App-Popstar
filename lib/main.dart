import 'package:flutter/material.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';

// Asegúrate de añadir 'http' en tu pubspec.yaml

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nombre único de la aplicación (para la barra de tareas/apps)
      title: 'Popstar Movies',
      
      // Tema basado en la identidad visual
      theme: AppTheme.lightTheme,
      
      // Definición de las rutas de navegación
      initialRoute: AppRoutes.splashRoute,
      routes: AppRoutes.routes,
      
      // Manejo de rutas no definidas
      onGenerateRoute: AppRoutes.onGenerateRoute,
      
      // Desactivar el banner de "debug"
      debugShowCheckedModeBanner: false,
    );
  }
}
