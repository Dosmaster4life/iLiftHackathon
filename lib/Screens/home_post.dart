
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'package:ilift/Custom%20Widgets/sendpost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import 'navigationbottombar.dart';
class home_post extends StatefulWidget {
  const home_post({Key? key}) : super(key: key);

  @override
  _home_postState createState() => _home_postState();
}

class _home_postState extends State<home_post> {
  final ImagePicker _picker = ImagePicker();
  String imageFile = "";
  String base64Image = "";
  String postText = "";
  String Hashtag = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(index: 1),
      body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: "Post"),
              maxLength: 100,
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  postText = value.trim();
                });
              }),
        ),
        buildHashtag(),Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),),
              onPressed: () async {
            final XFile? image = await _picker.pickImage(
                imageQuality: 50,
                source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                imageFile = image.path;
              });


            }
          }, child: Text("Upload Picture")),
        ),
        btnSubmit(),
        waitforPicture(),
      ],
      ),
    );

  }

  Padding buildHashtag() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: "#"),
          maxLength: 15,
          maxLines: 1,
          onChanged: (value) {
            setState(() {
              Hashtag = value.trim();
            });
          }),
    );
  }

  Padding btnSubmit() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),),
          onPressed: () {
        sendPost();
      showAlertDialog(context);
      }, child: Text("Submit Post")),
    );
  }
  Widget waitforPicture() {
    if(imageFile != "") {
      convertPicture();
      return Container (child : Image.file(Io.File(imageFile)));

    }
    return Container();
  }
  Future<void> convertPicture() async {
    final bytesData = Io.File(imageFile).readAsBytesSync();
    base64Image = base64Encode(bytesData);

  }
  void sendPost() {
    if(postText != "" && Hashtag != "") {
      SendPost j = SendPost();
      j.postOnline(postText,Hashtag,base64Image);
    }

  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
    }
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Post Submitted!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {

        return alert;
      },
    );
  }
}
