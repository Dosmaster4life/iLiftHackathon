import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilift/Screens/navigationbottombar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HashSelectorFirstTime extends StatefulWidget {
  const HashSelectorFirstTime({Key? key}) : super(key: key);

  @override
  _HashSelectorFirstTimeState createState() => _HashSelectorFirstTimeState();
}

class _HashSelectorFirstTimeState extends State<HashSelectorFirstTime> {
  final hashT = TextEditingController();

  saveValue() async {
    if (hashT.text.contains("#")) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('hash', hashT.text.split("#"));
      print(prefs.get('hash').toString());
      Alert(
        context: context,
        title: "Preferences Saved!",
        buttons: [],
      ).show();
      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: NavigationBottomBar(hideB: false)));
    }else {
      Alert(
        context: context,
        title: "Please Enter Data to save Preferences(Type # to leave empty).",
        buttons: [],
      ).show();
    }

  }
  @override
  Widget build(BuildContext context) {
    List<String> HashTags;

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: Text(
                'Type any hashtags you would like to recieve post on!',
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),

            ),
          ),
          TextField(
              inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z#]")), ],
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: "#Love#Family#Stress#Memes"),
              maxLines: 4,
              controller: hashT,
              onChanged: (value) {
                setState(() {

                });
              }),
       Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(28.0),
    ),),
    onPressed: () {
      saveValue();

    }, child: Text("Save Preferences")),
    ),

        ],
      ),
    );
  }
}
