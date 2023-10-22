import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/tvshows.dart';
import 'package:movies/widgets/moviecard.dart';
import 'package:movies/widgets/moviecard_list.dart';
//import 'package:movies/widgets/tvcard.dart';
import 'package:shimmer/shimmer.dart';

class MovieDisplay extends StatefulWidget {
  const MovieDisplay(
      {super.key,
      required this.movies,
      required this.popular,
      required this.tv});
  final List<Movie> movies;
  final List<Movie> popular;
  final List<TVShow> tv;
  @override
  State<MovieDisplay> createState() => _MovieDisplayState();
}

class _MovieDisplayState extends State<MovieDisplay> {
  final controller = ScrollController();
  bool _showShimmer = true;
  int _length = 5;
  bool _showEndOfList = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showShimmer = false;
      });
    });
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          _length += widget.popular.length;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Rated Movies',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: _showShimmer
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  period: const Duration(seconds: 1),
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return MovieCard(
                            movie: Movie(
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
                                voteCount: 0));
                      }),
                )
              : ListView.builder(
                  itemCount: widget.movies.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MovieCard(
                      movie: widget.movies[index],
                    );
                  }),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Popular Movies',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _showShimmer
            ? ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    period: const Duration(seconds: 1),
                    child: MovieCardList(
                      movie: Movie(
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
                      ),
                    ),
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: widget.popular.length,
                itemBuilder: (context, index) {
                 return MovieCardList(
                    movie: widget.popular[index],
                  );
                }),
        // const Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     'Popular TV Shows',
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // GridView.builder(
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         childAspectRatio: 0.7, crossAxisCount: 2),
        //     shrinkWrap: true,
        //     physics: const BouncingScrollPhysics(),
        //     itemCount: widget.tv.length,
        //     itemBuilder: (context, index) {
        //       return Shimmer.fromColors(
        //         baseColor: Colors.grey[300],
        //         highlightColor: Colors.grey[100],
        //         child: TVCard(
        //           tv: widget.tv[index],
        //         ),
        //         period: const Duration(seconds: 1),
        //       );
        //     }),
      ]),
    );
  }
}
 // if (index < widget.popular.length) {
                  //   return MovieCardList(
                  //     movie: widget.popular[index],
                  //   );
                  // } else {
                  //   Future.delayed(const Duration(seconds: 2)).then((value) {
                  //     setState(() {
                  //       _showEndOfList = true;
                  //     });
                  //   });

                  //   return _showEndOfList
                  //       ? const Center(
                  //           child: Text(
                  //             'End of the list',
                  //             style: TextStyle(
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         )
                  //       : const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  // }