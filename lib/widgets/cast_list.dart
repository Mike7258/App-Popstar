import 'package:flutter/material.dart';
import 'package:popstar_database/config/api_config.dart';
import 'package:popstar_database/models/cast.dart';
import 'package:popstar_database/themes/app_theme.dart';

class CastList extends StatelessWidget {
  final List<Cast> cast;

  const CastList({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text('Casting no disponible.', style: TextStyle(color: AppTheme.primaryColor)),
      );
    }
    
    // Muestra una lista horizontal de los miembros del casting
    return SizedBox(
      height: 150, // Altura fija para el ListView horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cast.length,
        itemBuilder: (context, index) {
          final actor = cast[index];
          
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Column(
              children: [
                // Avatar del Actor/Actriz
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: actor.profilePath.isNotEmpty
                      ? FadeInImage(
                          placeholder: const AssetImage('assets/person_placeholder.png'), // Placeholder local
                          image: NetworkImage('${ApiConfig.baseImageUrl}${actor.profilePath}'),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppTheme.lightPurple,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.person, color: AppTheme.primaryColor),
                            );
                          },
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.lightPurple,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person, color: AppTheme.primaryColor),
                        ),
                ),
                const SizedBox(height: 5),
                
                // Nombre del Actor/Actriz
                SizedBox(
                  width: 80,
                  child: Text(
                    actor.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                  ),
                ),
                
                // Nombre del Personaje
                SizedBox(
                  width: 80,
                  child: Text(
                    'como ${actor.character}',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10, color: AppTheme.primaryColor),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}