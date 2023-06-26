import 'package:hive/hive.dart';
import '../api/film_api.dart';
import 'film.dart';

Future<void> addFilm(FilmApi apiFilm) async {
  var box = await Hive.openBox('films');
  var films = box.get("filmsData", defaultValue: <Film>[]);
  films.add(Film.fromApi(apiFilm));
  await box.put("filmsData", films);
  await box.close();
}

Future<void> deleteFirstFilm() async {
  var box = await Hive.openBox<List<dynamic>>('films');
  var films = box.get("filmsData", defaultValue: <dynamic>[]);
  if (films != null && films.isNotEmpty) {
    var newFilms = films.sublist(1).cast<Film>();
    await box.put("filmsData", newFilms);
  }
  await box.close();
}



Future<Film?> getFilmById(num id) async {
  var box = await Hive.openBox('films');

  var films = box.get("filmsData", defaultValue: <Film>[]);
  if (films != null) {
    for (var i = 0; i < films.length; i++) {
      if (films[i].id == id) {
        return films[i];
      }
    }
  }

  var apiFilm = await FilmService().getFilmById(id);
  await box.close();
  if (films.length >= await getMaxNumberOfFilms()) {
    await deleteFirstFilm();
  }
  await addFilm(apiFilm);

  return Film.fromApi(apiFilm);
}

Future<void> setMaxNumberOfFilms(num number) async {
  var box = await Hive.openBox('films');
  await box.put("maxNumberOfFilms", number);
  await box.close();
}

Future<int> getMaxNumberOfFilms() async {
  var box = await Hive.openBox('films');
  int number = box.get("maxNumberOfFilms", defaultValue: 100);
  return number;
}

Future<num> getMaxNumberOfFilms() async {
  var box = await Hive.openBox('films');
  num number = box.get("maxNumberOfFilms", defaultValue: 100);
  await box.close();
  return number;
}

Future<void> clearFilms() async {
  var box = await Hive.openBox('films');
  await box.delete('filmsData');
  await box.close();
int countFilms() {
  var box = Hive.box<Film>('films');
  return box.length;
}