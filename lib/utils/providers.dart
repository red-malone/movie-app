import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  final String apiKey = '69500ab119d495403b12c7e36334bccf';
  final String accesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTUwMGFiMTE5ZDQ5NTQwM2IxMmM3ZTM2MzM0YmNjZiIsInN1YiI6IjY1MmExMjA4MWYzZTYwMDBjNTg4ZTZjNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.f9v9ChAK4wSTnV9CjpICY4G2sDoFg8CMbGbGrkYO9ZU';

  Future<void> fetchTopRatedMovies() async {
    final TMDB tmdbService = TMDB(
      ApiKeys(apiKey, accesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map result = await tmdbService.v3.movies.getTopRated();
    _movies = result['results'].map<Movie>((movie) => Movie.fromJson(movie)).toList();
  }
}
