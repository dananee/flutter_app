import 'package:flutter/material.dart';
import 'NavDrawer.dart';

class Recommadations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recommadations"),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text('Recommandations'),
        ),
        drawer: NavDrawer());
  }
}
