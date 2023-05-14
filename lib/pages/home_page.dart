import 'dart:html';

import 'package:flutter/material.dart';
import 'package:film_studio/services/filmService.dart';

// fst - сниппет для создания StatefulWidget
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Film>> futureFilms;

  @override
  void initState() {
    super.initState();
    futureFilms = FilmService().getFilms();
  }

  loadFilms() async {
    final results = await FilmService().getFilms();
    print(results.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home page!!!")),
        body: Center(
          child: FutureBuilder<List<Film>>(
            future: futureFilms,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      Film film = snapshot.data?[index];
                      return ListTile(
                        title: Text(film.name),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(film.description, softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,),
                        ),
                        trailing: const Icon(Icons.chevron_right_outlined),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.black26);
                    },
                    itemCount: snapshot.data!.length
                );
              } else if (snapshot.hasError) {
                return Text('ERROR: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
