import 'package:hive/hive.dart';

import '../api/rating_api.dart';

part 'rating.g.dart';

@HiveType(typeId: 3)
class Rating {
  Rating({required this.kp, required this.imdb, required this.tmdb});

  factory Rating.fromApi(RatingApi apiRating) {
    return Rating(kp: apiRating.kp, imdb: apiRating.imdb, tmdb: apiRating.tmdb);
  }

  @HiveField(0)
  num kp;

  @HiveField(1)
  num imdb;

  @HiveField(2)
  num tmdb;
}
