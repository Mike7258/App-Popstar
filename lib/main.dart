import 'package:flutter/material.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popstar Movies',
      
      theme: AppTheme.lightTheme,

      initialRoute: AppRoutes.splashRoute,
      routes: AppRoutes.routes,

      onGenerateRoute: AppRoutes.onGenerateRoute,

      debugShowCheckedModeBanner: false,
    );
  }
}
