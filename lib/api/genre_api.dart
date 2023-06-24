class GenreApi {
  final String name;

  const GenreApi({required this.name});

  static List<GenreApi> fromArray(List<dynamic> array) {
    final List<GenreApi> genres = [];
    for (var i = 0; i < array.length; i++) {
      genres.add(GenreApi.fromJson(array[i]));
    }
    return genres;
  }

  factory GenreApi.fromJson(Map<String, dynamic> json) {
    return GenreApi(name: json['name']);
  }
}