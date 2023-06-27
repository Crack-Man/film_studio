import 'package:film_studio/api/simular_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_studio/config/config.dart';

import 'simular_api.dart';

class Films {
  final num id;
  // final num id;
  final String name;
  final List<SimularsApi> simulars;
  // final List<SimularsApi> simulars;


  const Films(
      {required this.id,
        required this.name,
        required this.simulars
      });

  factory Films.fromJson(Map<String, dynamic> json) {
    return Films(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        simulars: SimularsApi.fromArray(json["similarMovies"])

    );
  }
}

class FilmService {
  Map<String, String> get requestHeaders => {
    "Accept": "application/json",
    'X-API-KEY': AppConfig.apiKey
  };


  // для реков запрос




  Future<List<Films>> getFilm(String name) async {
    Map<String, String> queryParameters = {
      // "selectFields" : "similarMovies",
      "name": name,
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    final response = await http.get(
        // Uri.parse("https://api.kinopoisk.dev/v1.3/movie?$queryString"),
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie?selectFields=similarMovies&selectFields=name&selectFields=id&$queryString"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Films> films = [];

      // final idx = data['total'] > 5 ? 5 : data['total'];

      for (var i = 0; i < 2; i++) {
        final entry = data['docs'][i];
        films.add(Films.fromJson(entry));
      }
      return films;
    } else {
      throw Exception('HTTP Failed');
    }
  }



}
