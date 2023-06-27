// import 'package:film_studio/api/rating_api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:film_studio/config/config.dart';
//
// import 'genre_api.dart';
//
// class recsApi {
//   final num id;
//   final String name;
//   final String description;
//   final num year;
//   final RatingApi rating;
//   final String poster;
//   final String logo;
//   final List<GenreApi> genres;
//   final num movieLength;
//   final num ageRating;
//
//   const recsApi(
//       {required this.id,
//         required this.name,
//         required this.description,
//         required this.year,
//         required this.rating,
//         required this.poster,
//         required this.logo,
//         required this.genres,
//         required this.movieLength,
//         required this.ageRating});
//
//   factory recsApi.fromJson(Map<String, dynamic> json) {
//     return recsApi(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       year: json['year'],
//       rating: RatingApi.fromJson(json['rating']),
//       poster: json["poster"]["url"],
//       logo: json["logo"]["url"],
//       genres: GenreApi.fromArray(json["genres"]),
//       movieLength: json["movieLength"] ?? -1,
//       ageRating: json["ageRating"] ?? -1,
//     );
//   }
// }
//
// // 1 по жанрам
//
// // 2 по id
//
// // 3 по актёру
// // final List<recsApi> recs = [];
//
// class recsService {
//   Map<String, String> get requestHeaders => {
//     "Accept": "application/json",
//     'X-API-KEY': AppConfig.apiKey
//   };
//
//    final List<recsApi> recs = [];
//
//   // final <List<recsApi>> rec = [];
//   // late Future<List<recsApi>> recs;
//   // final Future<List<recsApi>> recoms;
//
// void MakeAllReq(List<String> genre, num id, List<num> ids) {
//   getByGenre(genre);
//   getFilmById(ids);
//   getFilmsByActorId(id);
//   // future List<recsApi> rec1 = getByGenre(genre);
//   // final List<recsApi> rec2 = [];
//   // final List<recsApi> rec3 = [];
//   //
//   // recoms.add(getByGenre());
// }
//   // Future<List<recsApi>> MakeAllReq(List<String> genre, num id, List<num> ids) {
//   //   recs.add(getByGenre(genre));
//   //
//   //   return recs;
//   // }
//
// // ЖАНРЫ
// //   Future<List<recsApi>> getByGenre(List<String> genre) async {
//   void getByGenre(List<String> genre) async {
//
//     for (var item in genre){
//       Map<String, String> queryParameters = {
//         "genre": item,
//       };
//       String queryString = Uri(queryParameters: queryParameters).query;
//       final response = await http.get(
//           Uri.parse("https://api.kinopoisk.dev/v1.3/movie?page=1&limit=10$queryString"),
//           headers: requestHeaders);
//
//       if (response.statusCode == 200) {
//
//         final data = jsonDecode(response.body);
//         // final List<recsApi> films = [];
//
//         for (var i = 0; i < 5; i++) {
//           final entry = data['docs'][i];
//           recs.add(recsApi.fromJson(entry));
//         }
//
//       } else {
//         throw Exception('HTTP Failed');
//       }
//
//     }
//     // return recs;
//   }
//
//
// // ПОХОЖИЕ ФИЛЬМЫ
// //   Future<List<recsApi>> getFilmById(List<num> ids) async {
//     void getFilmById(List<num> ids) async {
//
//   for (var id in ids){
//     final response = await http.get(
//         // Uri.parse("https://api.kinopoisk.dev/v1.3/movie?persons.id=$id"),
//         Uri.parse("https://api.kinopoisk.dev/v1.3/movie/$id"),
//         headers: requestHeaders);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       recs.add(recsApi.fromJson(data));
//     } else {
//       throw Exception('HTTP Failed');
//     }
//   }
//     // return recs;
//
// }
//
// // АКТЁР
//
//
//   // Future<List<recsApi>> getFilmsByActorId(num id) async {
//   void getFilmsByActorId(num id) async {
//
//       final response = await http.get(
//           Uri.parse("https://api.kinopoisk.dev/v1.3/movie?persons.id=$id"),
//           headers: requestHeaders);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         for (var i = 0; i < 2; i++) {
//           final entry = data['docs'][i];
//           recs.add(recsApi.fromJson(entry));
//         }
//       } else {
//         throw Exception('HTTP Failed');
//       }
//     // return recs;
//   }}