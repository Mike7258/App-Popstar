
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
    Future.delayed(const Duration(seconds: 6), () { 
      Navigator.of(context).pushReplacementNamed(AppRoutes.initialRoute); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor, 
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
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
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