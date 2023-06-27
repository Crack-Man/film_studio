import 'package:film_studio/api/actor_api.dart';
import 'package:film_studio/pages/recommend_got_author.dart';
import 'package:film_studio/pages/recommend_page_start.dart';
import 'package:flutter/material.dart';
import 'package:film_studio/api/searc_film_api.dart';

import '../api/simular_api.dart';

List<SimularsApi> Simular = [];

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
        title: Text('Search Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
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
                  // futureActors = FilmService().getFilms(10);

                  futureActors = FilmService().getFilm(_searchText);

                  // print(futureActors);
                });
              },
            ),
          ),
          Expanded(/*child:Text('wow'),*/
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
                              onTap: (){
                                print(film.name);
                                print(film.simulars[0].id);
                                print('\n');
                                print(film.simulars[1].id);
                                Simular = film.simulars;



                                print(Simular);
                                print(best_actor);
                                print(selectedOptions);
                              },
                              // subtitle: Padding(
                              //   padding: const EdgeInsets.only(top: 8.0),
                              //   child: Text(
                              //     film.description,
                              //     softWrap: true,
                              //     maxLines: 1,
                              //     overflow: TextOverflow.ellipsis,
                              //   ),
                              // ),
                              // trailing: const Icon(Icons.chevron_right_outlined),
                              // leading: ConstrainedBox(
                              //   constraints: const BoxConstraints(
                              //     minWidth: 44,
                              //     minHeight: 44,
                              //     maxWidth: 64,
                              //     maxHeight: 64,
                              //   ),
                              //   child: Image.network(
                              //       film.poster, fit: BoxFit.cover),
                              // ),
                            )
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(color: Colors.black26);
                      },
                      itemCount: snapshot.data!.length);
                } else if (snapshot.hasError) {
                  return Text('ERROR: ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),

            // child: ListView.builder(
            //   // itemCount: _searchText == 'flutter' ? 5 : 0,
            //   itemCount: 5,
            //
            // itemBuilder: (context, index) {
            //     return ListTile(
            //         // FilmApi actor = snapshot.data?[index];
            //       title: Text(futureActors['name']),
            //     );
            //   },
            // ),
            // ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class Searchauthor extends StatelessWidget {
//   const Searchauthor({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: SearchBar(
//           ),
//         ),
//       ),
//     );
//   }
// }
