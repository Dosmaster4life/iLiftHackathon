import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/signin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class home_settings extends StatefulWidget {
  const home_settings({Key? key}) : super(key: key);

  @override
  _home_settingsState createState() => _home_settingsState();
}

class _home_settingsState extends State<home_settings> {
  @override
  final ImagePicker _picker = ImagePicker();
  String imageFile = "";
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut(); // Signs the User Out of Firebase
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignIn())); // Redirects user to Sign in Screen
    } catch (e) {}
  }
  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/ProfilePicture.jpeg'; // 3

    return filePath;
  }

  Widget build(BuildContext context) {
    getFilePath();
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
        ),
      ],
    );
  }
}
