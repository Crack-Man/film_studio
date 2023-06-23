import 'package:film_studio/api/rating_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_studio/config/config.dart';

import 'genre_api.dart';

class FilmApi {
  final num id;
  final String name;
  final String description;
  final num year;
  final RatingApi rating;
  final String poster;
  final String logo;
  final List<GenreApi> genres;
  final num movieLength;
  final num ageRating;

  const FilmApi(
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

  factory FilmApi.fromJson(Map<String, dynamic> json) {
    return FilmApi(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      year: json['year'],
      rating: RatingApi.fromJson(json['rating']),
      poster: json["poster"]["url"],
      logo: json["logo"]["url"],
      genres: GenreApi.fromArray(json["genres"]),
      movieLength: json["movieLength"] ?? -1,
      ageRating: json["ageRating"] ?? -1,
    );
  }
}

class FilmService {
  Map<String, String> get requestHeaders =>
      {"Accept": "application/json", 'X-API-KEY': AppConfig.apiKey};

  Future<List<FilmApi>> getFilms(num limit,
      {List<String> genres = const []}) async {
    String genresQuery = "";
    for (var genre in genres) {
      genresQuery += "&genres.name=$genre";
    }
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=$limit$genresQuery"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<FilmApi> films = [];
      for (var i = 0; i < data['docs'].length; i++) {
        final entry = data['docs'][i];
        films.add(FilmApi.fromJson(entry));
      }
      return films;
    } else {
      throw Exception('HTTP Failed');
    }
  }

  Future<FilmApi> getFilmById(num id) async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie/$id"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return FilmApi.fromJson(data);
    } else {
      throw Exception('HTTP Failed');
    }
  }
}
