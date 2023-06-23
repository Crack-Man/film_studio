import 'package:flutter/material.dart';

import 'package:film_studio/pages/search_page.dart';
import 'home_page.dart';
import 'recommend_page.dart';



class BtmNavBar extends StatefulWidget {
  BtmNavBar({Key? key}) : super(key: key);

  @override
  _BtmNavBarState createState() => _BtmNavBarState();
}

class _BtmNavBarState extends State<BtmNavBar> {
  int _selectedIndex = 0;

  final btmNavBarPages = [
    HomePage(),
    SearchScreen(),
    RecommendPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MovApp")),
      body: btmNavBarPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'PlaceHolder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend),
            label: 'PlaceHolder_2',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}