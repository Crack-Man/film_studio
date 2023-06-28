import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                body: Stack(
              children: [
                ..._buildBackground(context, film),
                Positioned(
                  bottom: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Text(
                        film.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${film.year} | ${genres} | ${film.movieLength} минут',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: film.rating.kp / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        unratedColor: Colors.white,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(film.description,
                          maxLines: 8,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.75, color: Colors.white))
                    ]),
                  ),
                )
              ],
            ));
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
}

List<Widget> _buildBackground(context, film) {
  return [
    Container(height: double.infinity, color: Colors.black),
    Image.network(
      film.poster,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      fit: BoxFit.cover,
    ),
    const Positioned.fill(
        child: DecoratedBox(
            decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 0.5]),
    )))
  ];
}
