import 'package:film_studio/api/rating_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_studio/config/config.dart';

import 'genre_api.dart';

class ActorApi {
  final num id;
  final String name;
  final String movies;


  const ActorApi(
      {required this.id,
        required this.name,
        required this.movies});

  factory ActorApi.fromJson(Map<String, dynamic> json) {
    return ActorApi(
      id: json['id'],
      name: json['name'],
      movies: json['movies'],
    );
  }
}

class ActorService {
  Map<String, String> get requestHeaders => {
    "Accept": "application/json",
    'X-API-KEY': AppConfig.apiKey
  };

  // Future<List<ActorApi>> getFilms(num num) async {
  //   final response = await http.get(
  //       Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=$num"),
  //       headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final List<ActorApi> films = [];
  //     for (var i = 0; i < data['docs'].length; i++) {
  //       final entry = data['docs'][i];
  //       films.add(ActorApi.fromJson(entry));
  //     }
  //     return films;
  //   } else {
  //     throw Exception('HTTP Failed');
  //   }
  // }

  // Future<ActorApi> getFilmById(num id) async {
  //   final response = await http.get(
  //       Uri.parse("https://api.kinopoisk.dev/v1.3/movie/$id"),
  //       headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return ActorApi.fromJson(data);
  //   } else {
  //     throw Exception('HTTP Failed');
  //   }
  // }


  // для реков запрос
  Future<List<ActorApi>> getActors(String name) async {
    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1/person?page=1&limit=10&name=$name"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<ActorApi> actors = [];

      // final idx = data['total'] > 5 ? 5 : data['total'];

      for (var i = 0; i < 2; i++) {
        final entry = data['docs'][i];
        actors.add(ActorApi.fromJson(entry));
      }
      return actors;
    } else {
      throw Exception('HTTP Failed');
    }
  }

}
