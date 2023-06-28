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
    String posterURL = "";
    String logoURL = "";
    String notFoundURL = "https://specialplantzundert.nl/wp-content/uploads/2020/06/not-found-image-15383864787lu.jpg";
    if (json["poster"] == null) {
      posterURL = notFoundURL;
    } else {
      posterURL = json["poster"]["url"] ?? notFoundURL;
    }
    if (json["logo"] == null) {
      logoURL = notFoundURL;
    } else {
      logoURL = json["logo"]["url"] ?? notFoundURL;
    }
    return FilmApi(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      year: json['year'],
      rating: RatingApi.fromJson(json['rating']),
      poster: posterURL,
      logo: logoURL,
      genres: GenreApi.fromArray(json["genres"]),
      movieLength: json["movieLength"] ?? -1,
      ageRating: json["ageRating"] ?? -1,
    );
  }
}

class FilmService {
  Map<String, String> get requestHeaders => {
    "Accept": "application/json",
    'X-API-KEY': AppConfig.apiKey
  };

  Future<List<FilmApi>> getFilms(num limit,
      {List<String> genres = const [], String name = ""}) async {
    Map<String, String> queryParameters = {
      "limit": limit.toString(),
      "page": 1.toString(),
    };
    if (genres.isNotEmpty) {
      queryParameters["genres"] = jsonEncode(genres);
    }
    if (name.isNotEmpty) {
      queryParameters["name"] = name;
    }
    String queryString = Uri(queryParameters: queryParameters).query;
    final response = await http.get(
        Uri.parse(
            "https://api.kinopoisk.dev/v1.3/movie?$queryString"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      final List<FilmApi> films = [];
      for (var i = 0; i < data['docs'].length; i++) {
        final entry = data['docs'][i];
        print(entry);
        films.add(FilmApi.fromJson(entry));
      }
      print(films.length);
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


  // для реков запрос
  Future<List<FilmApi>> getActors(String name) async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1/person?page=1&limit=10&name=$name"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<FilmApi> actors = [];

      final idx = data['total'] > 4 ? 4 : data['total'];

      for (var i = 0; i < idx; i++) {
        final entry = data['docs'][i];
        actors.add(FilmApi.fromJson(entry));
      }
      return actors;
    } else {
      throw Exception('HTTP Failed');
    }
  }

}
