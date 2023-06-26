import 'package:film_studio/api/film_api.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'film_details_page.dart';
import 'home_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late TextEditingController _controller;
  late Future<List<FilmApi>> _futureFilms;

  @override
  void initState() {
    super.initState();
    _futureFilms = Future(() => []);
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void updateData(String value) {
    setState(() {
      _futureFilms = FilmService().getFilms(20, name: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Поиск',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Set the desired border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Set the desired focused border color
                  ),
                ),
              ),
              style: const TextStyle(
                color: Colors.white, // Set the desired text color
              ),
              onSubmitted: (String value) async {
                print(value);
                updateData(value);
              },
            )),
        Expanded(
            child: FutureBuilder<List<FilmApi>>(
          future: _futureFilms,
          builder: (context, AsyncSnapshot snapshot) {
            print("object!!!!!!!!!!!");
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            } else if (snapshot.data == null || !snapshot.data.isNotEmpty) {
              return const Text("");
            }
            print(snapshot.data);
            return ListView.separated(
                itemBuilder: (context, index) {
                  print(snapshot.data);
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
          },
        )),
      ]),
    );
  }
}
