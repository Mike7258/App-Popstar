import 'package:flutter/material.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'POPSTAR',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppTheme.accentColor, 
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.info_outline, color: AppTheme.primaryColor, size: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.infoRoute);
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Películas Recientes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                ),
              ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _MoviePlaceholderCard(index: index),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Mejor Calificadas',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: List.generate(3, (index) => _RatingPlaceholderRow(index: index)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviePlaceholderCard extends StatelessWidget {
  final int index;
  const _MoviePlaceholderCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: AppTheme.lightPurple,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.theaters, size: 50, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(
              'Pelicula ${index + 1}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingPlaceholderRow extends StatelessWidget {
  final int index;
  const _RatingPlaceholderRow({required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.oliveGreen.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(child: Text('POSTER', style: TextStyle(fontSize: 10, color: Colors.white))),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título de Éxito ${index + 1}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    Icon(Icons.star, color: AppTheme.accentColor, size: 18),
                    Text(' 8.5/10', style: TextStyle(color: AppTheme.primaryColor)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}