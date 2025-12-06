
import 'package:flutter/material.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navega a la HomeScreen después de 6 segundos.
    Future.delayed(const Duration(seconds: 6), () { // <-- CAMBIADO DE 2 A 6 SEGUNDOS
      // Usamos pushReplacementNamed para que el usuario no pueda volver al Splash
      Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute); 
    });
  }

  @override
  Widget build(BuildContext context) {
    // Usamos los colores de la identidad visual de Popstar
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, // Fondo Morado Oscuro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_popstar.png', 
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Text(
                  'POPSTAR',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.creamBackground,
                    fontSize: 48,
                  ),
                );
              },
            ),
            
            const SizedBox(height: 50),
            // Indicador de carga
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor), // Color Naranja
            ),
            const SizedBox(height: 20),
            Text(
              'CALIFICANDO ESTRELLAS...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.creamBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}