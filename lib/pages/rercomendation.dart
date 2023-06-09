import 'package:film_studio/api/actor_api.dart';
import 'package:film_studio/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:film_studio/api/film_api.dart';

import 'film_details_page.dart';
import 'package:film_studio/api/rec_api.dart';

import 'home_page.dart';
import 'recommend_got_film.dart';
import 'recommend_got_author.dart';
import 'recommend_page_start.dart';

// import '';

class RecsPage extends StatefulWidget {
  RecsPage({Key? key}) : super(key: key);

  @override
  _RecsPage createState() => _RecsPage();
}

class _RecsPage extends State<RecsPage> {
  // late Future<List<FilmApi>> futureRec;
  // late Future<FilmApi> film;
  int _selectedIndex2 = 2;

  final btmNavBarPages2 = [
    HomePage(),
    SearchScreen(),
    RecommendBody(),
  ];

  void _onItemTapped2(int index) {
    setState(() {
      print(index);
      _selectedIndex2 = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MovApp")),
      body: btmNavBarPages2.elementAt(_selectedIndex2),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Популярные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'Рекомендуемое',
          ),
        ],
        currentIndex: _selectedIndex2,
        onTap: _onItemTapped2,
      ),
    );
  }
}

class RecommendBody extends StatefulWidget {
  RecommendBody({Key? key}) : super(key: key);

  @override
  _RecommendBody createState() => _RecommendBody();
}

class _RecommendBody extends State<RecommendBody> {
  late Future<List<FilmApi>> futureRec;
  late Future<FilmApi> film;

  @override
  void initState() {
    super.initState();

    futureRec = recsService().MakeAllReq(selectedOptions, best_actor, Simular);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<FilmApi>>(
          future: futureRec,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    FilmApi film = snapshot.data?[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FilmDetailsPage(film.id)));
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
                          trailing: const Icon(Icons.chevron_right_outlined),
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child:
                                Image.network(film.poster, fit: BoxFit.cover),
                          ),
                        ));
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
      ),
    );
  }
}
