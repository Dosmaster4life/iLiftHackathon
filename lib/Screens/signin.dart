import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/navigationbottombar.dart';
import 'package:ilift/Screens/signup.dart';
import 'package:ilift/Custom Widgets/hashtag.dart';
import 'package:page_transition/page_transition.dart';
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
        body: Stack(children: <Widget>[
          Column(
            children: [
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
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: const Text(
                        "         Login         ",
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
                          //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigationBottomBar()));
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: NavigationBottomBar(hideB: false)));

                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              errorCode = 'Incorrect Credentials';
                            });
                          }
                        }
                      }),
                ),
              ]),
              ListTile(
                  title: const Center(
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14))),
                  onTap: () => {
                        if (userEmail.isNotEmpty &&
                            userEmail.contains(".com") &&
                            userEmail.contains("@"))
                          {
                            // makes sure its an email address

                            setState(() {
                              passwordReset(userEmail);
                            }),
                            errorCode =
                                "If that email address exist, a reset link will be sent",
                          }
                        else
                          {
                            setState(() {
                              errorCode = "Please enter an email address first";
                            }),
                          }
                      }),
            ],
          ),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "OR",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                     //   builder: (context) => const SignUp()));
                    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: SignUp()));
                  },
                  child:
                      Text("        Create Account        ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18,
                          ))),
            ],
          ))
        ]));
  }
  Future<void> passwordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Widget build(BuildContext context) {
    return settingsList();
  }
}
