import 'package:film_studio/api/rating_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:film_studio/config/config.dart';

import 'film_api.dart';
import 'genre_api.dart';
// im
class recsApi {
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

  const recsApi(
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

  factory recsApi.fromJson(Map<String, dynamic> json) {
    return recsApi(
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

// 1 по жанрам

// 2 по id

// 3 по актёру
// final List<recsApi> recs = [];

class recsService {
  Map<String, String> get requestHeaders => {
    "Accept": "application/json",
    'X-API-KEY': AppConfig.apiKey
  };

   // final List<recsApi> recs = [];

  Future<List<FilmApi>> MakeAllReq(List<String> genre, num id, List<num> ids) async {
    late Future<List<FilmApi>> futureFilms;


    late Future<List<FilmApi>> futureFilms1;

    late Future<List<FilmApi>> futureFilms2;

    late Future<List<FilmApi>> futureFilms3;

    // final List<recsApi> recs = [];

    futureFilms1 = getByGenre(genre);
    // futureFilms2 = getByGenre(genre);
    futureFilms2 = getFilmById(ids);
    // futureFilms = getFilmById(id);
    // print(ids);
    futureFilms3 = getFilmsByActorId(id);
    Future<List<FilmApi>> resultList = concatLists(futureFilms1, futureFilms2);
    Future<List<FilmApi>> resultList0 = concatLists(resultList, futureFilms3);

    // final mergedList = await Future.wait([futureFilms1,futureFilms2,futureFilms3]);

    // for (final FilmApi item in futureFilms1){
    //
    // }
    // print(recs.length);
    return resultList0;

  }


  Future<List<FilmApi>> concatLists(Future<List<FilmApi>> firstList, Future<List<FilmApi>> secondList) async {
    List<FilmApi> resultList = [];

    // Wait for the first list to resolve and add its elements to the result list
    await firstList.then((list) => resultList.addAll(list));

    // Wait for the second list to resolve and add its elements to the result list
    await secondList.then((list) => resultList.addAll(list));

    // Return the concatenated list
    return resultList;
  }


// ЖАНРЫ
  Future<List<FilmApi>> getByGenre(List<String> genre) async {
  // void getByGenre(List<String> genre) async {
    final List<FilmApi> recs = [];

    for (var item in genre){
      Map<String, String> queryParameters = {
        "genre": item,
      };
      String queryString = Uri(queryParameters: queryParameters).query;
      final response = await http.get(
          Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=10$queryString"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var i = 0; i < 5; i++) {
          final entry = data['docs'][i];
          recs.add(FilmApi.fromJson(entry));
        }
      } else {
        throw Exception('HTTP Failed');
      }
    }
    return recs;
  } //РАБОТАЕТ ПРАВИЛЬНО


// ПОХОЖИЕ ФИЛЬМЫ
  Future<List<FilmApi>> getFilmById(List<num> ids) async {
  // void getFilmById(List<num> ids) async {
    final List<FilmApi> recs = [];

    for (var id in ids){
      final response = await http.get(
        // Uri.parse("https://api.kinopoisk.dev/v1.3/movie?persons.id=$id"),
          Uri.parse("https://api.kinopoisk.dev/v1.3/movie/$id"),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recs.add(FilmApi.fromJson(data));
      } else {
        throw Exception('HTTP Failed');
      }
    }
    return recs;

  }

// АКТЁР
//   final List<recsApi> recs = [];


  Future<List<FilmApi>> getFilmsByActorId(num id) async {
  // void getFilmsByActorId(num id) async {
    final List<FilmApi> recs = [];

    final response = await http.get(
        Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=10&persons.id=$id"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final idx = data['total'] > 5 ? 5 : data['total'];
      print(idx);
      for (var i = 0; i < idx; i++) {
        print(i);

        final entry = data['docs'][i];
        recs.add(FilmApi.fromJson(entry));
      }
    } else {
      throw Exception('HTTP Failed');
    }
    return recs;
  }}

// // Future<List<recsApi>> getFilmsByActorId(num id) async {
// void getFilmsByActorId(num id) async {
//
//   final response = await http.get(
//       Uri.parse("https://api.kinopoisk.dev/v1.3/movie?persons.id=$id"),
//       headers: requestHeaders);
//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//
//     for (var i = 0; i < 2; i++) {
//       final entry = data['docs'][i];
//       recs.add(recsApi.fromJson(entry));
//     }
//   } else {
//     throw Exception('HTTP Failed');
//   }
//   // return recs;
// }}