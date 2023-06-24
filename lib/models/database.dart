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
  if (films.length < await getMaxNumberOfFilms()) {
    await box.close();
    await addFilm(apiFilm);
  }

  return Film.fromApi(apiFilm);
}

Future<void> setMaxNumberOfFilms(int number) async {
  var box = await Hive.openBox('films');
  await box.put("maxNumberOfFilms", number);
}

Future<int> getMaxNumberOfFilms() async {
  var box = await Hive.openBox('films');
  int number = box.get("maxNumberOfFilms", defaultValue: 100);
  return number;
}

int countFilms() {
  var box = Hive.box<Film>('films');
  return box.length;
}