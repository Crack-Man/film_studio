import 'package:hive/hive.dart';

import '../api/genre_api.dart';

part 'genre.g.dart';

@HiveType(typeId: 2)
class Genre {
  Genre({required this.name});

  factory Genre.fromApi(GenreApi genre) {
    return Genre(name: genre.name);
  }

  @HiveField(0)
  String name;
}
