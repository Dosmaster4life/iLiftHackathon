import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HashSelector extends StatefulWidget {
  const HashSelector({Key? key}) : super(key: key);

  @override
  _HashSelectorState createState() => _HashSelectorState();
}

class _HashSelectorState extends State<HashSelector> {

  final hashT = TextEditingController();
  void initState() {
    loadData();
    super.initState();
  }
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    hashT.text = (prefs.get('hash').toString().replaceAll('[', '#')).replaceAll(']', '').replaceAll(',', '').replaceAll(' ', '');
  }
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
      Navigator.pop(context);
    }else {
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