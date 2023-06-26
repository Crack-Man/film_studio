import 'package:flutter/material.dart';

import '../models/database.dart';
import '../models/film.dart';

class FilmDetailsPage extends StatefulWidget {
  final num id;

  FilmDetailsPage(this.id, {Key? key}) : super(key: key);

  @override
  _FilmDetailsPageState createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  late Future<Film?> filmFuture;

  @override
  void initState() {
    super.initState();
    filmFuture = getFilmById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Film?>(
      future: filmFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Film? film = snapshot.data;
          const textStyle = TextStyle(
            color: Colors.black,
            fontSize: 28,
          );
          const textStyleHeader = TextStyle(
            color: Colors.black,
            fontSize: 48,
          );
          String genres = "";
          for (var i = 0; i < film!.genres.length; i++) {
            String genre = film.genres[i].name;
            if (i == 0) {
              genres += genre;
            } else {
              genres += ", ${genre}";
            }
          }
          if (film != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(film.name),
              ),
              body: Container(
                  margin: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(film.name, style: textStyleHeader)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(
                            film.poster,
                            fit: BoxFit.cover,
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(film.description, style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Год: ${film.year}", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Длительность: ${film.movieLength} минут", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Возрастной рейтинг: ${film.ageRating}+", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Жанр: ${genres}", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Жанр: ${genres}", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("KP: ${film.rating.kp}", style: textStyle)),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("IMDB: ${film.rating.imdb}", style: textStyle)),
                      if (film.rating.tmdb != 0)
                        Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text("TMDB: ${film.rating.tmdb}", style: textStyle)),
                    ],
                  )),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Произошла ошибка'),
              ),
              body: const Center(
                child: Text('Фильм не найден', style: textStyle),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget buildFilmDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: label != "" ? '$label: ' : '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}