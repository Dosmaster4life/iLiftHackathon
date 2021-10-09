import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ilift/Custom%20Widgets/notificationservice.dart';
import 'package:ilift/Screens/home_settings.dart';
import 'package:ilift/Screens/navigationbottombar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HashSelector extends StatefulWidget {
  const HashSelector({Key? key}) : super(key: key);

  @override
  _HashSelectorState createState() => _HashSelectorState();
}
CollectionReference data = FirebaseFirestore.instance
    .collection('Post')
    .doc('Approved')
    .collection('Beta');
class _HashSelectorState extends State<HashSelector> {
  final hashT = TextEditingController();
  bool isS = false;
  void initState() {
    loadData();
    super.initState();
  }
  Future<void> getDocuments() async {

    Random random = new Random();
    List<String> allTag = [];
    List<String> allPost = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String info =  (prefs.get('hash').toString())
        .replaceAll("[,", "#")
        .replaceAll(", ", "#")
        .replaceAll("]", "")
        .replaceAll(" ", "");

    data.get()
        .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      String test = doc["Hash"];
      String post = doc["Post"];

      if (info.contains(test) && test != null) {
        allTag.add(test);
        allPost.add(post);

      }
    }

    );
    if(allTag.length > 0)
    {
      int r = random.nextInt(allTag.length);
      print(r);
      NotificationService().ShowTimedNotification(0, allTag[r], allPost[r], 10);
     // NotificationService().ShowTimedNotification(0, allTag[r], allPost[r], 86400);
    }
    });


    //

  }
  Switch fSwitch() {
    return Switch(
      value: isS,
      onChanged: (value) {
        setState(() {

          isS = value;
          if(isS) {

           // NotificationService().showDailyNotification(0, title, body, seconds)
          }else {
            NotificationService().cancelAllNotifications();
          }
        });
      },
      activeTrackColor: Colors.blueAccent,
      activeColor: Colors.blue,
    );
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isS = prefs.getBool('notif')!;
      setState(() {});
    } catch (exception) {
      isS = false;
    }

    String info =  (prefs.get('hash').toString())
        .replaceAll("[,", "#")
        .replaceAll(", ", "#")
        .replaceAll("]", "")
        .replaceAll(" ", "");
    if (info != null && info != "null") {
      hashT.text = info;
    }
  }

  saveValue() async {
    if (hashT.text.contains("#")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('notif', isS);
      prefs.setStringList('hash', hashT.text.split("#"));


      Navigator.pop(context);
    } else {
      Alert(
        context: context,
        title: "Please Enter Data to save Preferences",
        buttons: [],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> HashTags;

    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
      ),
      body: ListView(
        children: [
          Center(
            child: Text(
              'Type any hashtags you would like to recieve post on!',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ),
          TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z#]")),
              ],
              keyboardType: TextInputType.text,
              decoration:
                  const InputDecoration(hintText: "#Love#Family#Stress#Memes"),
              maxLines: 4,
              controller: hashT,
              onChanged: (value) {
                setState(() {});
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Notifications"), fSwitch()],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                onPressed: () {
                  saveValue();
                  getDocuments();
                },
                child: Text("Save Preferences")),
          ),
        ],
      ),
    );
  }
}
