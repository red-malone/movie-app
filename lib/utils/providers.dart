import 'package:flutter/material.dart';
import 'package:movies/models/genre.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/tvshows.dart';
import 'package:tmdb_api/tmdb_api.dart';

enum MovieSortCriterion { popularity, rating, year }

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
  final List<Movie> _favourites = [];
  List<Movie> get favourites => _favourites;
  List<Genre> _genre = [];
  List<Genre> get genres => _genre;
  //List<Movie> fixedmovie = [];
  //List<Movie> fixedpopular = [];
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
    //_fullmovies=[..._movies, ..._popular];
    //_search = _fullmovies;
    Map gen = await tmdbService.v3.genres.getMovieList();
    _genre =
        gen['genres'].map<Genre>((genre) => Genre.fromJson(genre)).toList();
    // fixedmovie = result['results']
    //     .map<Movie>((movie) => Movie.fromJson(movie))
    //     .toList();
    // fixedpopular = next['results']
    //     .map<Movie>((movie) => Movie.fromJson(movie))
    //     .toList();
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

  bool existing(Movie movie) {
    final existingIndex =
        _favourites.indexWhere((element) => element.id == movie.id);
    if (existingIndex >= 0) {
      return true;
    } else {
      return false;
    }
  }
  void sortMovies(MovieSortCriterion criterion) {
    switch (criterion) {
      case MovieSortCriterion.popularity:
        _movies.sort((a, b) => b.popularity.compareTo(a.popularity));
        break;
      case MovieSortCriterion.rating:
        _movies.sort((a, b) => b.voteAverage.compareTo(a.voteAverage));
        break;
      case MovieSortCriterion.year:
        _movies.sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
        break;
      default:
        break;
    }
    notifyListeners();
  }

  // void filterMoviesByGenres(List<int> genre) {
  //   if (genre.isNotEmpty) {
  //     _movies = _movies
  //         .where((movie) =>
  //             movie.genreIds.any((element) => genre.contains(element)))
  //         .toList();
  //     _popular = _popular
  //         .where((movie) =>
  //             movie.genreIds.any((element) => genre.contains(element)))
  //         .toList();
  //     notifyListeners();
  //   } else {
  //     fetchTopRatedMovies();
  //   }
  // }
}
