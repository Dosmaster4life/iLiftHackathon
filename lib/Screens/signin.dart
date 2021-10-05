import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/navigationbottombar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late String userEmail, userPassword, errorCode = "";
  final authenticate = FirebaseAuth.instance;

  @override
  Scaffold settingsList() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
        ),
        body: Column(children: [
          Text(errorCode),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  setState(() {
                    userEmail = value.trim();
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  setState(() {
                    userPassword = value.trim();
                  });
                }),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * .82,
              height: MediaQuery.of(context).size.height * .07,
              child: RaisedButton(
                  color: Theme.of(context).colorScheme.secondary,
                  textColor: Colors.white,
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (userEmail == null) {
                    } else if (userPassword == null) {
                    } else {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                            email: userEmail, password: userPassword);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const NavigationBottomBar()));
                      } on FirebaseAuthException catch (e) {
                        setState(() {
                          errorCode = 'Incorrect Credentials';
                        });
                      }
                    }
                  }),
            )
          ])
        ]));
  }

  Widget build(BuildContext context) {
    return settingsList();
  }
}
