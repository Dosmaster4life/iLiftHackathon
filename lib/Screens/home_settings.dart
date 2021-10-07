import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/hashselector.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'package:ilift/Screens/login_check.dart';
import 'package:ilift/Screens/signin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';
import 'dart:io';
import 'navigationbottombar.dart';
import 'package:ilift/main.dart';

import 'navigationbottombar.dart';
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
      Restart.restartApp();

    } catch (e) {}
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const HomeAppBar(index: 2),
      body: ListView(
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
          ListTile(
            leading: const Icon(
              Icons.room_preferences,
            ),
            onTap: () => {
              NavigationBottomBar(hideB: true),

            Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HashSelector())),
            },
            title: Text("Content Preferences"),
          ),
        ],
      ),
    );
  }
}
