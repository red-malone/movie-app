import 'package:flutter/material.dart';
import 'package:movies/screens/favourites.dart';
import 'package:movies/screens/moviesection.dart';
import 'package:movies/screens/search.dart';
import 'package:movies/utils/providers.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  int _currindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currindex == 0
              ? 'Movies'
              : _currindex == 1
                  ? 'Search'
                  : 'Favorites',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _currindex == 0
          ? const MoviesSection()
          : _currindex == 1
              ? const SearchScreen()
              : const FavouriteScreen()
      ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currindex,
        onTap: (index) {
          setState(() {
            _currindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
enum MovieSortCriterion { popularity, rating, year }


class MoviesSection extends StatelessWidget {
  const MoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return FutureBuilder(
        future: movieProvider.fetchTopRatedMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child:const MovieDisplay(movies: [], popular: [],tv: [],)
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}\nTurn on your net or restart the application'));
          } else {
            return MovieDisplay(
                movies: movieProvider.movies, popular: movieProvider.popular,tv:const [],
                );
          }
        },
      );
  }
}
