import 'package:film_studio/api/actor_api.dart';
import 'package:film_studio/pages/recommend_got_film.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

num best_actor = 0;

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  late Future<List<ActorApi>> futureActors;
  late Future<ActorApi> actor;

  @override
  void initState() {
    super.initState();
    futureActors = ActorService().getActors('Леонардо ди');
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

                  futureActors = ActorService().getActors(_searchText);
                });
              },
            ),
          ),
          Expanded(
            /*child:Text('wow'),*/
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
                          onTap: () {
                            best_actor = film.id;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetFilm()),
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
