import 'package:flutter/material.dart';
import 'package:movies/screens/movie_detsscreen.dart';
import 'package:movies/utils/providers.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool _val = true;
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          if (movieProvider.favourites.isEmpty)
            const Center(
              child: Text("No favourites yet"),
            )
          else
            ListView.builder(
                shrinkWrap: true,
                itemCount: movieProvider.favourites.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (builder)=>MovieDetails(movie: movieProvider.favourites[index],)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          "https://image.tmdb.org/t/p/original${movieProvider.favourites[index].posterPath}",
                          fit: BoxFit.cover,
                        ),
                        title: Text(movieProvider.favourites[index].title),
                      ),
                    ),
                  );
                })
        ],
      ),
    );
  }
}
