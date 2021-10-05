import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/signin.dart';
import 'google_signin.dart';
import 'navigationbottombar.dart';
import 'signin.dart';
class LoginCheck extends StatefulWidget { // currently just loads navigation bar, will check login later
    const LoginCheck({Key? key}) : super(key: key);

    @override
    _LoginCheckState createState() => _LoginCheckState();
  }
  int currentPage = 0;
  class _LoginCheckState extends State<LoginCheck> {

   Future<void> checkSignedIn() async {
     if (FirebaseAuth.instance.currentUser != null) {
     currentPage = 1;
     setState(() {

     });
     } else {

     }
   }
   List<Widget> screenList = <Widget>[ // Current Home Screens
     const SignIn(),
     const NavigationBottomBar(),
   ];
    Widget build(BuildContext context) {
      checkSignedIn();
      return  MaterialApp(
        home: screenList.elementAt(currentPage),
      );
    }
}
