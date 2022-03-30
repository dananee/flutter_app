import 'package:flutter_app/HomeScreen.dart';
import 'package:flutter_app/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Contacts.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return Contacts();
    } else {
      return LoginScreen();
    }
  }
}
