import 'package:flutter/material.dart';
import 'package:popstar_database/routes/app_routes.dart';
import 'package:popstar_database/themes/app_theme.dart';
import 'package:popstar_database/models/movie.dart'; 
import 'package:popstar_database/services/movie_service.dart'; 
import 'package:popstar_database/config/api_config.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();

  bool _isLoading = true;
  List<Movie> _recentMovies = [];
  List<Movie> _topRatedMovies = [];
  String _errorMessage = ''; 

  @override
  void initState() {
    super.initState();
    _fetchMovieData(); 
  }

  Future<void> _fetchMovieData() async {
    try {
      final popularMoviesList = await _movieService.getPopularMovies();
      
      setState(() {
        _recentMovies = popularMoviesList; 
        
        _topRatedMovies = popularMoviesList.take(3).toList(); 

        _isLoading = false;
        _errorMessage = '';
      });
    } catch (e) {
      debugPrint('Error al cargar datos: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error al cargar las películas. Revisa tu API Key y conexión.';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppTheme.accentColor)
              )
            : _errorMessage.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(_errorMessage, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red, fontSize: 16)),
                  )
                )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- ENCABEZADO (POPSTAR) ---
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

                    // --- PELÍCULAS RECIENTES ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Películas Recientes',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                      ),
                    ),

                    SizedBox(
                      height: 200,
                      child: _recentMovies.isEmpty
                          ? const Center(child: Text('No hay películas recientes disponibles.'))
                          : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            itemCount: _recentMovies.length,
                            itemBuilder: (context, index) {
                              final movie = _recentMovies[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: _MovieCard(movie: movie), 
                              );
                            },
                          ),
                    ),

                    const SizedBox(height: 40),

                    // --- MEJOR CALIFICADAS ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        'Mejor Calificadas',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: _topRatedMovies.isEmpty
                          ? const Center(child: Text('No hay películas mejor calificadas disponibles.'))
                          : Column(
                            children: _topRatedMovies.map((movie) => _RatingRow(movie: movie)).toList(),
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

// =========================================================
// WIDGETS AUXILIARES PARA MOSTRAR LA PELÍCULA Y NAVEGAR
// =========================================================

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(
      context, 
      AppRoutes.detailsRoute, // Usa la ruta 'details' definida en tu app_routes.dart
      arguments: movie, // Pasa el objeto Movie para que DetailsScreen lo use
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context), 
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: movie.posterPath.isNotEmpty
              ? FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage('${ApiConfig.baseImageUrl}${movie.posterPath}'),
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return _NoPosterPlaceholder(movie: movie);
                  },
                )
              : _NoPosterPlaceholder(movie: movie), 
        ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final Movie movie;
  const _RatingRow({required this.movie});

  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(
      context, 
      AppRoutes.detailsRoute,
      arguments: movie,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          children: [
            // Contenedor del Poster (o Placeholder)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.oliveGreen.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: movie.posterPath.isNotEmpty
                    ? FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: NetworkImage('${ApiConfig.baseImageUrl}${movie.posterPath}'),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) => const Center(child: Text('❌', style: TextStyle(fontSize: 18))),
                      )
                    : const Center(child: Text('POSTER', style: TextStyle(fontSize: 10, color: Colors.white))),
              ),
            ),
            
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppTheme.accentColor, size: 18),
                      Text(' ${movie.voteAverage.toStringAsFixed(1)}/10', 
                           style: const TextStyle(color: AppTheme.primaryColor)),
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

class _NoPosterPlaceholder extends StatelessWidget {
  final Movie movie;
  const _NoPosterPlaceholder({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightPurple,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.theaters, size: 50, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                movie.title, 
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}