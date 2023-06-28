import 'package:film_studio/pages/recommend_got_film.dart';
import 'package:film_studio/pages/rercomendation.dart';
import 'package:flutter/material.dart';
import 'package:film_studio/pages/settings_page.dart';

import 'package:film_studio/pages/search_page.dart';
import 'package:page_transition/page_transition.dart';
import 'home_page.dart';
import 'recommend_page_start.dart';
import 'package:film_studio/api/rec_api.dart';

class BtmNavBar extends StatefulWidget {
  BtmNavBar({Key? key}) : super(key: key);

  @override
  _BtmNavBarState createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  int _selectedIndex = 0;

  final btmNavBarPages = [
    HomePage(),
    const SearchScreen(),
    SurveyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MovApp"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Настройки',
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.topToBottom,
                      child: const SettingsScreen()));
            },
          ),
        ],
      ),
      body: btmNavBarPages.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
