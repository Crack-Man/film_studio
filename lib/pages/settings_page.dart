import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  double _currentSliderPrimaryValue = 0.2;
  double _currentSliderSecondaryValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home page")),
      body: SettingsList(
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
              ),
            ],
          ),
          CustomSettingsSection(
              child: Slider(
            value: _currentSliderPrimaryValue,
            secondaryTrackValue: _currentSliderSecondaryValue,
            label: _currentSliderPrimaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderPrimaryValue = value;
              });
            },
          ))
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
        title: const Text("Внимание!"),
        content: const Text("Очистить кэш? Это действие необратимо!"),
        actions: <Widget>[
          TextButton(
            child: const Text("Отмена"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Очистить кэш"),
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
        title: const Text("Внимание!"),
        content: const Text("Сбросить рекомендации? Это действие необратимо!"),
        actions: <Widget>[
          TextButton(
            child: const Text("Отмена"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Сбросить рекомендации"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
