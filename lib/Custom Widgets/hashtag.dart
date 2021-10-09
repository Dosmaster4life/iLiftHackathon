import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HashTag {
  bool isSelected = false;
  String text = "";
  Color c = Colors.blue;

  ElevatedButton getHashtag(String data) {
    text = data;

    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: c)))),
      onPressed: () {
        if (isSelected == true) {
          isSelected = false;
          c = Colors.blue;
        } else {
          c = Colors.black;
          isSelected = true;
        }
      },
      child: Text(
        data,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
