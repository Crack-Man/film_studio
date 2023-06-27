import 'package:film_studio/pages/recommend_got_author.dart';
import 'package:flutter/material.dart';

class SurveyPage extends StatefulWidget {
  @override
  _SurveyPageState createState() => _SurveyPageState();
}

List<String> selectedOptions = [];


class _SurveyPageState extends State<SurveyPage> {
  List<String> _options = ['комедия', 'мультфильм', 'ужасы', 'фантастика', 'триллер', 'боевик', 'мелодрама',
                          'детектив', 'приключения', 'фэнтези', 'военный', 'семейный', 'аниме', 'история',
                          'драма', 'документальный', 'Детские', 'криминал', 'биография', 'вестерн'];
  List<bool> _selected = [false, false, false, false, false, false, false,
                          false, false, false, false, false, false, false,
                          false, false, false, false, false, false] ;

  int _maxSelected = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Выберите понравившиеся жанры:',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _options.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_options[index]),
                  value: _selected[index],
                  onChanged: (bool? value) {
                    setState(() {
                      {
                      if (value == true) {
                      // Проверяем, сколько уже выбрано элементов
                      int selectedCount = _selected.where((element) => element == true).length;

                      // Если не достигнут лимит, выбираем этот элемент
                      if (selectedCount < _maxSelected) {
                      _selected[index] = true;
                      }
                      } else {
                      // Снимаем выбор с элемента
                      _selected[index] = false;
                      }
                    }});
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('Далее'),
              onPressed: () {
                // List<String> selectedOptions = [];##########################################################################

                for (int i = 0; i < _options.length; i++) {
                  if (_selected[i]) {
                    selectedOptions.add(_options[i]);
                  }
                }

                // @override
                // createState() => SearchFilm();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
                // (context) => SearchFilm();
                // Do something with the selected options
                print('Selected options: $selectedOptions');

              },
            ),
          ),
        ],
      ),
    );
  }
}