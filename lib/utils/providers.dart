import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/tvshows.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  List<Movie> _popular = [];
  List<Movie> get popular => _popular;
  // List<TVShow> _tv = [];
  //List<TVShow> get tv => _tv;
  List<Movie> _fullmovies = [];
  List<Movie> get fullmovies => _fullmovies;
  List<Movie> _search = [];
  List<Movie> get search => _search;
  List<Movie> _favourites = [];
  List<Movie> get favourites => _favourites;



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
    _movies =
        result['results'].map<Movie>((movie) => Movie.fromJson(movie)).toList();
    Map next = await tmdbService.v3.movies.getPopular();
    _popular =
        next['results'].map<Movie>((movie) => Movie.fromJson(movie)).toList();
    //Map tv = await tmdbService.v3.tv.getPopular();
    // _tv = tv['results'].map<TVShow>((shows) => TVShow.fromJson(shows)).toList();
    _fullmovies=[..._movies, ..._popular];
    _search = _fullmovies;
  }

  Future<void> fetchSearchMovies(String query) async {
    final TMDB tmdbService = TMDB(
      ApiKeys(apiKey, accesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    Map result = await tmdbService.v3.search.queryMovies(query);
    List<Movie> movies =
        result['results'].map<Movie>((movie) => Movie.fromJson(movie)).toList();
    _search = movies;
  }

  bool toggleFavorite(Movie movie) {
    final existingIndex =
        _favourites.indexWhere((element) => element.id == movie.id);
    if (existingIndex >= 0) {
      _favourites.removeAt(existingIndex);
      return false;
    } else {
      _favourites.add(movie);
      return true;
    }
  }
  

}
