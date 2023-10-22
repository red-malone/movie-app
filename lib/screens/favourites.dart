import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/utils/providers.dart';
import 'package:movies/widgets/moviecard_list.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late List<Movie> favourites;

  Future refresh(MovieProvider provider) async{
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      favourites = provider.favourites;
    });
  }
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    setState(() {
      favourites = movieProvider.favourites;
    });
    return RefreshIndicator(
      onRefresh: () => refresh(movieProvider),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (favourites.isEmpty)
              const Center(
                child: Text("No favourites yet"),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  return MovieCardList(movie: favourites[index]);
                },
              ),
          ],
        ),
      ),
    );
  }
}
