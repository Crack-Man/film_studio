import 'package:film_studio/api/film_api.dart';
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
    return Scaffold(
      appBar: AppBar(title: FutureBuilder<Film?>(
        future: filmFuture,
        builder: (context, AsyncSnapshot<Film?> snapshot) {
          if (snapshot.hasData) {
            Film film = snapshot.data!;
            return Text(film.name);
          } else if (snapshot.hasError) {
            return Text('ERROR: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}