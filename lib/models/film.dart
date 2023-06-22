import 'package:film_studio/api/film_api.dart';
import 'package:film_studio/models/rating.dart';
import 'package:hive/hive.dart';

import 'genre.dart';

part 'film.g.dart';

@HiveType(typeId: 1)
class Film {
  Film(
      {required this.id,
      required this.name,
      required this.description,
      required this.year,
      required this.rating,
      required this.poster,
      required this.logo,
      required this.genres,
      required this.movieLength,
      required this.ageRating});

  factory Film.fromApi(FilmApi apiFilm) {
    List<Genre> genres = [];
    for (var i = 0; i < apiFilm.genres.length; i++) {
      genres.add(Genre.fromApi(apiFilm.genres[i]));
    }
    return Film(id: apiFilm.id, name: apiFilm.name, description: apiFilm.description, year: apiFilm.year, rating: Rating.fromApi(apiFilm.rating), poster: apiFilm.poster, logo: apiFilm.logo, genres: genres, movieLength: apiFilm.movieLength, ageRating: apiFilm.ageRating);
  }

  @HiveField(0)
  num id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  num year;

  @HiveField(4)
  Rating rating;

  @HiveField(5)
  String poster;

  @HiveField(6)
  String logo;

  @HiveField(7)
  List<Genre> genres;

  @HiveField(8)
  num movieLength;

  @HiveField(9)
  num ageRating;
}
