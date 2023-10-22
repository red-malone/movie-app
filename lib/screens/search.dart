import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/movie_detsscreen.dart';
import 'package:movies/utils/providers.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];

  void updateSearch(String value, MovieProvider movieProvider) {
    setState(() {
      searchResults = movieProvider.fullmovies
          .where((movie) =>
              movie.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                movieProvider.fetchSearchMovies(value);
                setState(() {
                  searchResults = movieProvider.search;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Movies',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (searchResults.isEmpty)
            const Center(
              child: Text("No results found.Search for a movie"),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetails(movie: searchResults[index]),
                      ),
                    );
                  
                  },
                  child: ListTile(
                    leading: Image.network(
                      "https://image.tmdb.org/t/p/original${searchResults[index].posterPath}",
                      fit: BoxFit.cover,
                      width: 100,
                    ),
                    title: Text(searchResults[index].title),
                    subtitle: Text(searchResults[index].overview),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
