import 'package:flutter/material.dart';
class LoginCheck extends StatefulWidget {
    const LoginCheck({Key? key}) : super(key: key);

    @override
    _LoginCheckState createState() => _LoginCheckState();
  }

  class _LoginCheckState extends State<LoginCheck> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          body: Text("Test"),
        ),
      );
    }
}
