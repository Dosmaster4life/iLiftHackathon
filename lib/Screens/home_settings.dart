import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/signin.dart';
class home_settings extends StatefulWidget {
  const home_settings({Key? key}) : super(key: key);

  @override
  _home_settingsState createState() => _home_settingsState();
}

class _home_settingsState extends State<home_settings> {
  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Signs the User Out of Firebase
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignIn())); // Redirects user to Sign in Screen
    } catch (e) {}
  }
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
          ),
          onTap: () => {
            signOut(),
          },
          title: Text("Log Out"),
        )
      ],
    );
  }
}
