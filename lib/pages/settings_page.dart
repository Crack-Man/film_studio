import 'package:film_studio/models/database.dart';
import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  late Future<num> _currentSliderPrimaryValue = getMaxNumberOfFilms();
  // double _currentSliderSecondaryValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: Stack(
        children: [
          Container(height: double.infinity, color: Colors.black),
          FutureBuilder<num>(
            future: _currentSliderPrimaryValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                double? value = snapshot.data as double?;
                return SettingsList(
                  sections: [
                    SettingsSection(
                      tiles: <SettingsTile>[
                        SettingsTile.navigation(
                          title: const Text('Сбросить рекомендации'),
                          onPressed: (context) =>
                              _showResetRecommendationsDialog(context),
                        ),
                        SettingsTile.navigation(
                          title: const Text('Очистить кэш'),
                          onPressed: (context) => _showResetCashDialog(context),
                        ),
                        SettingsTile(
                          title: const Text('Установить количество хранимых данных'),
                          value: Text(
                              'Текущее количество хранимых данных ${value}'),
                        ),
                      ],
                    ),
                    CustomSettingsSection(
                      child: Slider(
                        value: value ?? 100,
                        max: 1000,
                        min: 10,
                        divisions: 99,
                        label: (snapshot.data ?? 0).round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            setMaxNumberOfFilms(value);
                            _currentSliderPrimaryValue = Future.value(value);
                          });
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Ошибка: ${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}

void _showResetRecommendationsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Внимание!', style: TextStyle(color: Colors.black)),
        content: const Text("Сбросить рекомендации? Это действие необратимо!", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton(
            child: const Text("Отмена", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Сбросить рекомендации", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showResetCashDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Внимание!", style: TextStyle(color: Colors.black)),
        content: const Text('Очистить кэш? Это действие необратимо!', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton(
            child: const Text("Отмена", style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Очистить кэш", style: TextStyle(color: Colors.black)),
            onPressed: () {
              clearFilms();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
