import 'package:flutter/material.dart';
import 'navigationbottombar.dart';
class LoginCheck extends StatefulWidget { // currently just loads navigation bar, will check login later
    const LoginCheck({Key? key}) : super(key: key);

    @override
    _LoginCheckState createState() => _LoginCheckState();
  }

  class _LoginCheckState extends State<LoginCheck> {
    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        home: NavigationBottomBar(), // Loads Navigation Bar
      );
    }
}
