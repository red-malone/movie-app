import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  const MovieDetails({super.key,required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/original${movie.posterPath}",
              fit: BoxFit.cover, 
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(movie.overview),
            ),
          ],
        ),
      ),
    );
  }
}