import 'package:film_studio/settings/amount_of_data.dart';
import 'package:flutter/material.dart';

import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                title: const Text('Сбросить рекомендации'),
                onPressed: (context) => _showResetRecommendationsDialog(context),
              ),
              SettingsTile.navigation(
                title: const Text('Очистить кэш'),
                onPressed: (context) => _showResetCashDialog(context),
              ),
              SettingsTile.navigation(
                title: const Text('Установить количество хранимых данных'),
                onPressed: (context) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AmountOfDataStored()))
                },
              ),
            ],
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
