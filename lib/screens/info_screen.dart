import 'package:flutter/material.dart';
import 'package:popstar_database/themes/app_theme.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información del Desarrollador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. CircleAvatar() con información personal
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: AppTheme.accentColor,
                  backgroundImage: NetworkImage('https://placehold.co/150x150/504E76/C4C3E3/png?text=TU+FOTO'),
                  // NOTA: Reemplaza la URL de arriba con tu propia imagen.
                ),
                const SizedBox(height: 20),
                
                // 2. Ficha de Desarrollador
                Text(
                  'Desarrollador Principal',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  'Nombre del Estudiante', // ¡Reemplaza con tu nombre!
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 24),
                ),
                
                const SizedBox(height: 30),

                // 3. Información de la App (Popstar)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Acerca de Popstar',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
                        ),
                        const Divider(color: AppTheme.primaryColor),
                        const Text(
                          'Popstar es una aplicación móvil desarrollada para la clase de Programación Móvil, utilizando Flutter y la API pública de The Movie Database (TMDB).',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 14, color: AppTheme.primaryColor),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Funcionalidades:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.primaryColor),
                        ),
                        _buildInfoRow(context, Icons.api, 'Consumo de TMDB API'),
                        _buildInfoRow(context, Icons.list, 'Vista de lista (GridView)'),
                        _buildInfoRow(context, Icons.screen_rotation, 'Diseño responsivo (Vertical y Horizontal)'),
                        _buildInfoRow(context, Icons.palette, 'Identidad Visual de marca'),
                        _buildInfoRow(context, Icons.navigation, 'Navegación con Rutas'),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                // Mensaje final
                Text(
                  '¡Califica, Descubre, Disfruta!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppTheme.accentColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para las filas de información
  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppTheme.oliveGreen),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: AppTheme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}