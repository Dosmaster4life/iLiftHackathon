import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/signin.dart';

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
                    "Create Account",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: userEmail,
                          password: userPassword,
                      );

                     // await userCredential.sendEmailVerification();
                    //  return user.uid;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const NavigationBottomBar()));
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        errorCode = e.code;
                      });
                    }
                  }),
            ),

          ]),
          ListTile(
              title: new Center(child: Text("Return to Login")),
              onTap: () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const SignIn())),
              })
        ],
        )
    );
  }
  Widget build(BuildContext context) {
    return settingsList();
  }
}
