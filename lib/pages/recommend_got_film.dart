import 'package:film_studio/api/actor_api.dart';
import 'package:film_studio/pages/recommend_got_author.dart';
import 'package:film_studio/pages/recommend_page_start.dart';
import 'package:film_studio/pages/rercomendation.dart';
import 'package:flutter/material.dart';
import 'package:film_studio/api/searc_film_api.dart';
import 'package:film_studio/api/rec_api.dart';

import '../api/simular_api.dart';

bool init_rec = false;

List<int> Simular = [];

class GetFilm extends StatefulWidget {
  @override
  _GetFilm createState() => _GetFilm();
}

class _GetFilm extends State<GetFilm> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late Future<List<Films>> futureActors;
  late Future<Films> actor;

  @override
  void initState() {
    super.initState();
    futureActors = FilmService().getFilm('Человек');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovApp'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                  futureActors = FilmService().getFilm(_searchText);
                });
              },
            ),
          ),
          Expanded(
            /*child:Text('wow'),*/
            child: FutureBuilder<List<Films>>(
              future: futureActors,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        Films film = snapshot.data?[index];
                        return InkWell(
                            child: ListTile(
                          title: Text(film.name),
                          onTap: () {
                            for (var item in film.simulars) {
                              Simular.add(item.id);
                            }
                            film.simulars.map((e) => Simular.add(e.id));

                            init_rec = true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecsPage()),
                            );
                          },
                        ));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(color: Colors.black26);
                      },
                      itemCount: snapshot.data!.length);
                } else if (snapshot.hasError) {
                  return Text('ERROR: ${snapshot.error}');
                }
                return const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
