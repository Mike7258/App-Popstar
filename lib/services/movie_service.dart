import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:popstar_database/config/api_config.dart';
import 'package:popstar_database/models/movie.dart';
import 'package:popstar_database/models/cast.dart';

class MovieService {
  final String _baseUrl = ApiConfig.baseUrl;
  final String _apiKey = ApiConfig.apiKey;

  Future<dynamic> _get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint?api_key=$_apiKey&language=es-ES');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al cargar datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fallo al obtener datos de la API: $e');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final data = await _get(ApiConfig.popularMovies);
    
    if (data != null && data['results'] != null) {
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    final endpoint = '/movie/$movieId/credits';
    final data = await _get(endpoint);

    if (data != null && data['cast'] != null) {
      final List<dynamic> castJson = data['cast'];
      return castJson
          .take(10) 
          .map((json) => Cast.fromJson(json))
          .toList();
    }
    return [];
  }
}