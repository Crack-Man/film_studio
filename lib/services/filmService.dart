import 'package:http/http.dart' as http;
import 'dart:convert';

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

class Film {
  final int id;
  final String name;
  final String description;
  final int year;
  final Rating rating;
  final String poster;

  const Film(
      {required this.id,
      required this.name,
      required this.description,
      required this.year,
      required this.rating,
      required this.poster});

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        year: json['year'],
        rating: Rating.fromJson(json['rating']),
        poster: json["poster"]["url"]);
  }
}

class FilmService {
  Map<String, String> get requestHeaders => {
        "Accept": "application/json",
        'X-API-KEY': "FJEZN1X-0EFM88P-HG1F9KT-A32YK41"
      };

  Future<List<Film>> getFilms() async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=10"),
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
}
