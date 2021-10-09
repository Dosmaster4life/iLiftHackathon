import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/signin.dart';
import 'package:page_transition/page_transition.dart';
import 'navigationbottombar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String userEmail, userPassword, errorCode = "";
  final authenticate = FirebaseAuth.instance;
  @override
  Scaffold settingsList() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create Account'),
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
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          );

                          // await userCredential.sendEmailVerification();
                          //  return user.uid;
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //  builder: (context) => const NavigationBottomBar()));
                          Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: NavigationBottomBar(
                                    hideB: false,
                                  )));
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            errorCode = e.code;
                          });
                        }
                      }),
                ),
              ]),
            ],
          ),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Text(
                "OR",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: SignIn()));
                    //Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //    builder: (context) => const SignIn()));
                  },
                  child: const Text("    Return to Sign In    ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ))),
            ],
          ))
        ]));
  }

  Widget build(BuildContext context) {
    return settingsList();
  }
}
