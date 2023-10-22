import 'package:flutter/material.dart';
import 'package:movies/utils/providers.dart';
import 'package:movies/widgets/moviecard_list.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movieProvider.favourites.length,
              itemBuilder: (context, index) {
                return MovieCardList(
                  movie: movieProvider.favourites[index]
                  );
              },
            ),
        ],
      ),
    );
  }
}
