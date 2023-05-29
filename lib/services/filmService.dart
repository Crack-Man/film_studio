import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_studio/config/config.dart';

class Rating {
  final double kp;
  final double imdb;
  final double tmdb;

  const Rating({
    required this.kp,
    required this.imdb,
    required this.tmdb,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
        kp: json['kp'] ?? 0, imdb: json['imdb'] ?? 0, tmdb: json['tmdb'] ?? 0);
  }
}

class Genre {
  final String name;

  const Genre({required this.name});

  static List<Genre> fromArray(List<dynamic> array) {
    final List<Genre> genres = [];
    for (int i = 0; i < array.length; i++) {
      genres.add(Genre.fromJson(array[i]));
    }
    return genres;
  }

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(name: json['name']);
  }
}

class Film {
  final int id;
  final String name;
  final String description;
  final int year;
  final Rating rating;
  final String poster;
  final String logo;
  final List<Genre> genres;
  final int movieLength;
  final int ageRating;

  const Film(
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

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      year: json['year'],
      rating: Rating.fromJson(json['rating']),
      poster: json["poster"]["url"],
      logo: json["logo"]["url"],
      genres: Genre.fromArray(json["genres"]),
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

  Future<List<Film>> getFilms(int num) async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=$num"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Film> films = [];
      for (var i = 0; i < data['docs'].length; i++) {
        final entry = data['docs'][i];
        films.add(Film.fromJson(entry));
      }
      return films;
    } else {
      throw Exception('HTTP Failed');
    }
  }

  Future<Film> getFilmById(int id) async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie/$id"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Film.fromJson(data);
    } else {
      throw Exception('HTTP Failed');
    }
  }
}
