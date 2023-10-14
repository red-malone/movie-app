import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/utils/providers.dart';
import 'package:movies/widgets/moviecard.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: FutureBuilder(
        future: movieProvider.fetchTopRatedMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                ),
                itemCount: 6, 
                itemBuilder: (context, index) {
                  return  MovieCard(movie: Movie(
                    adult: false,
                    backdropPath: '',
                    genreIds: [],
                    id: 0,
                    originalLanguage: '',
                    originalTitle: '',
                    overview: '',
                    popularity: 0,
                    posterPath: '',
                    releaseDate: '',
                    title: '',
                    video: false,
                    voteAverage: 0,
                    voteCount: 0,
                  ));
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7 ,
                crossAxisCount: 2, 
              ),
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return MovieCard(movie: movie);
              },
            );
          }
        },
      ),
    );
  }
}
