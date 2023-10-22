class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GenreList {
  final List<Genre> genres;

  GenreList({
    required this.genres,
  });

  factory GenreList.fromJson(List<dynamic> json) {
    List<Genre> genreList = json.map((genre) => Genre.fromJson(genre)).toList();
    return GenreList(genres: genreList);
  }

  Map<String, dynamic> toJson() {
    return {
      'genres': genres.map((genre) => genre.toJson()).toList(),
    };
  }
}
