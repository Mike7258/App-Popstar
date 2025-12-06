import 'package:flutter/material.dart';
import 'package:popstar_database/config/api_config.dart';
import 'package:popstar_database/models/movie.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.detailsRoute,
          arguments: movie,
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: movie.posterPath.isNotEmpty
                    ? FadeInImage(
                        placeholder: const AssetImage('assets/popcorn_placeholder.png'),
                        image: NetworkImage('${ApiConfig.baseImageUrl}${movie.posterPath}'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.movie_filter, color: AppTheme.primaryColor, size: 50));
                        },
                      )
                    : const Center(child: Icon(Icons.local_movies, color: AppTheme.primaryColor, size: 50)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  
                  Row(
                    children: [
                      Icon(Icons.star, color: AppTheme.accentColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Icon(Icons.local_movies, color: AppTheme.oliveGreen, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}