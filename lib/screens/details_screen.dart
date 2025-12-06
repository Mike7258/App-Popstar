import 'package:flutter/material.dart';
import 'package:popstar_database/config/api_config.dart';
import 'package:popstar_database/models/movie.dart';
import 'package:popstar_database/services/movie_service.dart';
import 'package:popstar_database/themes/app_theme.dart';
import 'package:popstar_database/widgets/cast_list.dart';
class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie initialMovie = ModalRoute.of(context)!.settings.arguments as Movie;
    final MovieService movieService = MovieService();

    return Scaffold(
      body: FutureBuilder<Movie>(
        future: movieService.getMovieCast(initialMovie.id).then((castList) {
          return initialMovie.copyWith(cast: castList);
        }),
        builder: (context, snapshot) {
          final movie = snapshot.data ?? initialMovie;

          return CustomScrollView(
            slivers: [
              _CustomAppBar(movie: movie),

              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: AppTheme.accentColor, size: 24),
                            const SizedBox(width: 5),
                            Text(
                              movie.voteAverage.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      'Sinopsis:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      movie.overview,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Reparto Principal:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(color: AppTheme.accentColor),
                        ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          child: CastList(cast: movie.cast), 
                        ),

                  const SizedBox(height: 30),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget personalizado para el App Bar del detalle
class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppTheme.primaryColor,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black54, // Sombra para que el título sea legible
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.creamBackground,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        background: movie.backdropPath.isNotEmpty
            ? FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'), // GIF o imagen de carga
                image: NetworkImage('${ApiConfig.baseImageUrl}${movie.backdropPath}'),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.lightPurple,
                    child: const Center(child: Icon(Icons.videocam, color: AppTheme.primaryColor, size: 80)),
                  );
                },
              )
            : Container(
                color: AppTheme.lightPurple,
                child: const Center(child: Icon(Icons.videocam, color: AppTheme.primaryColor, size: 80)),
              ),
      ),
    );
  }
}