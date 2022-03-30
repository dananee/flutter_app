import 'package:flutter/material.dart';
import 'NavDrawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts Application"),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text('My Page!'),
        ),
        drawer: NavDrawer());
  }
}
