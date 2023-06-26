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

  @override
  void initState() {
    super.initState();
    futureFilms = FilmService().getFilms(20);
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
                            film.description,
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
