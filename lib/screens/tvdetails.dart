import 'package:flutter/material.dart';
import 'package:movies/models/tvshows.dart';

class TVDetails extends StatelessWidget {
  final TVShow tv;
  const TVDetails({super.key,required this.tv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tv.name),
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
              "https://image.tmdb.org/t/p/original${tv.posterPath}",
              fit: BoxFit.cover, 
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tv.overview),
            ),
          ],
        ),
      ),
    );
  }
}