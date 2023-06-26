import 'package:flutter/material.dart';




class AmountOfDataStored extends StatefulWidget {
  const AmountOfDataStored({super.key});

  @override
  State<AmountOfDataStored> createState() => _AmountOfDataStored();
}

class _AmountOfDataStored extends State<AmountOfDataStored> {
  double _currentSliderPrimaryValue = 0.2;
  double _currentSliderSecondaryValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            value: _currentSliderPrimaryValue,
            secondaryTrackValue: _currentSliderSecondaryValue,
            label: _currentSliderPrimaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderPrimaryValue = value;
              });
            },
          ),
          Slider(
            value: _currentSliderSecondaryValue,
            label: _currentSliderSecondaryValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderSecondaryValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
