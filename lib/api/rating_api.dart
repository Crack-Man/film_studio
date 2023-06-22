class RatingApi {
  final double kp;
  final double imdb;
  final double tmdb;

  const RatingApi({
    required this.kp,
    required this.imdb,
    required this.tmdb,
  });

  factory RatingApi.fromJson(Map<String, dynamic> json) {
    return RatingApi(
        kp: json['kp'] ?? 0, imdb: json['imdb'] ?? 0, tmdb: json['tmdb'] ?? 0);
  }
}