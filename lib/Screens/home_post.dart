import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/sendpost.dart';
class home_post extends StatefulWidget {
  const home_post({Key? key}) : super(key: key);

  @override
  _home_postState createState() => _home_postState();
}


class _home_postState extends State<home_post> {
  String postTitle = "";
  String postText = "";
  String Hashtag = "";
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      SendPost j = SendPost();
      j.postOnline(postTitle, postText,Hashtag);
    }, child: const Text("Post")  );


  }
}
