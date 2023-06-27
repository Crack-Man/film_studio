import 'package:flutter/material.dart';
import 'package:film_studio/api/film_api.dart';
import 'package:page_transition/page_transition.dart';

import 'film_details_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FilmApi>> futureFilms;
  late Future<FilmApi> film;

<<<<<<<<< Temporary merge branch 1
=========
  void printActors() async {
    // var actors = await ActorService().getActors("Антон");
    // print(actors[0].name);
    // print(actors[0].movies);
  }

>>>>>>>>> Temporary merge branch 2
  @override
  void initState() {
    super.initState();
    futureFilms = FilmService().getFilms(20);
<<<<<<<<< Temporary merge branch 1
=========
    // printActors();
>>>>>>>>> Temporary merge branch 2
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<List<FilmApi>>(
        future: futureFilms,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  FilmApi film = snapshot.data?[index];
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: FilmDetailsPage(film.id)));
                      },
                      child: ListTile(
                        title: Text(film.name),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '${film.year} г. | Жанр: ${capitalize(film.genres[0].name)}',
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined,
                            color: Colors.white),
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: Image.network(film.poster, fit: BoxFit.cover),
                        ),
                      ));
                },
                separatorBuilder: (context, index) {
                  return const Divider(color: Colors.white);
                },
                itemCount: snapshot.data!.length);
          } else if (snapshot.hasError) {
            return Text('ERROR: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    ));
  }

  @override
  bool get wantkeepAlive => true;
}

String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " " && cap == true) {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
      cap = false;
    }
  }
  return result;
}
