import 'package:film_studio/api/actor_api.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late Future<List<ActorApi>> futureActors;
  late Future<ActorApi> actor;

  @override
  void initState() {
    super.initState();
    futureActors = ActorService().getActors('пол');
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

                  // futureActors = FilmService().getActors(_searchText);

                  // print(futureActors);
                });
              },
            ),
          ),
          Expanded(/*child:Text('wow'),*/
            child: FutureBuilder<List<ActorApi>>(
              future: futureActors,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        ActorApi film = snapshot.data?[index];
                        return InkWell(
                            child: ListTile(
                              title: Text(film.name),
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
