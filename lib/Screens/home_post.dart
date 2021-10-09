import 'dart:async';
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'package:ilift/Custom%20Widgets/notificationservice.dart';
import 'package:ilift/Custom%20Widgets/sendpost.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



import 'navigationbottombar.dart';
import 'dart:html';
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
                maxLength: 147,
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    postText = value.trim();
                  });
                }),
          ),
          buildHashtag(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                onPressed: () async {
                  if(kIsWeb) {
                    FilePicker();
                  }else {
                    final XFile? image = await _picker.pickImage(
                        imageQuality: 50, source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        imageFile = image.path;
                      });
                    }
                  }

                },
                child: Text("Upload Picture")),
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
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
          ],
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
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            sendPost();
            Alert(
              context: context,
              title: "Post Submitted!",
              buttons: [],
            ).show();
          },
          child: Text("Submit Post")),
    );
  }

  Widget waitforPicture() {
    if (imageFile != "") {
      convertPicture();
      return SizedBox(
          height: MediaQuery.of(context).size.height * .46,
          child: Image.file(Io.File(imageFile)));
    }else if(kIsWeb) {
      try {
        if(upImage != null) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .46,
            child: Image.memory(upImage),
          );
        }
      }catch(exception) {
        return Container();
      }


    }
    return Container();
  }

  Future<void> convertPicture() async {
    final bytesData = Io.File(imageFile).readAsBytesSync();
    base64Image = base64Encode(bytesData);
  }

  void sendPost() {
    if (postText != "" && Hashtag != "") {
      SendPost j = SendPost();
      j.postOnline(postText, Hashtag, base64Image);
    }
  }


//method to load image and update `upImage`

  late Uint8List upImage;
  FilePicker() async {

    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            upImage = reader.result as Uint8List;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }
}
