import 'package:hive/hive.dart';
import '../api/film_api.dart';
import 'film.dart';

Future<void> addFilm(FilmApi apiFilm) async {
  var hiveBox = await Hive.openBox('films');

  await hiveBox.add(Film.fromApi(apiFilm));
  await hiveBox.close();
}

Future<Film?> getFilmById(int id) async {
  var hiveBox = await Hive.openBox('films');

  for (var i = 0; i < hiveBox.length; i++) {
    var film = hiveBox.getAt(i);
    if (film?.id == id) {
      return film;
    }
  }

  var apiFilm = await FilmService().getFilmById(id);
  if (hiveBox.length < 20) {
    await hiveBox.close();
    await addFilm(apiFilm);
  }

  return Film.fromApi(apiFilm);
}

int countFilms() {
  var hiveBox = Hive.box<Film>('films');
  return hiveBox.length;
}