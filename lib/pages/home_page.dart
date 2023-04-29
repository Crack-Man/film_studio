import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home page!!!")),
        body: Center(
            child: Text(
              "Hello, JSON Placeholder!!!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3,
            )
        )
    );
  }

}