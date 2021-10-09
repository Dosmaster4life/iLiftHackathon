import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Custom%20Widgets/home_appbar.dart';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:ilift/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_feed extends StatefulWidget {
  const home_feed({Key? key}) : super(key: key);

  @override
  _home_feedState createState() => _home_feedState();
}

class _home_feedState extends State<home_feed> {
  @override
  List<String>? prefTags = [];
  Widget build(BuildContext context) {
    loadData();
    CollectionReference data = FirebaseFirestore.instance
        .collection('Post')
        .doc('Approved')
        .collection('Beta');
    return Scaffold(

        appBar: AppBar(
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(4),
                child: Container(
                  color: Colors.grey,
                  height: 1,
                )),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              "See",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: "Verdana"),
            ),
            leading: GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Icon(
                  Icons.refresh_sharp, color: Colors.blueAccent,
                  // add custom icons also
                ))),
        body: buildStreamBuilder(data));
  }

  Card cardReturn(DocumentSnapshot document) {
    try {
      if (document['Image'] == "") {
        throw 32;
      }
      final decodedBytes = base64Decode(document['Image']);
      Image pictureData = Image.memory(decodedBytes);
      return Card(
          child: Column(children: [
        ListTile(
          title: Text(
            document['Hash'],
            style: TextStyle(color: Colors.blue),
          ),
          subtitle: Text(
            document['Post'],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * .6,
            child: pictureData),
        shareRowPic(document)
      ]));
    } catch (e) {
      return Card(
          child: Column(children: [
        ListTile(
          title: Text(
            document['Hash'],
            style: TextStyle(color: Colors.blue),
          ),
          subtitle: Text(
            document['Post'],
          ),
        ),
        shareRow(document),
      ]));
    }
  }

  Row shareRowPic(DocumentSnapshot document) {
    return Row(
      children: [
        TextButton(
            onPressed: () async {
              Uint8List bytes = base64.decode(document['Image']);
              final Dir = await syspaths.getTemporaryDirectory();
              Io.File file = Io.File('${Dir.path}/data.jpg');
              file.writeAsBytes(bytes);
              Share.shareFiles([file.path],
                  text: "#" + document['Hash'] + "\n" + document['Post']);
            },
            child: const Icon(Icons.ios_share))
      ],
    );
  }

  Row shareRow(DocumentSnapshot document) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              Share.share("#" + document['Hash'] + "\n" + document['Post']);
            },
            child: const Icon(Icons.ios_share))
      ],
    );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder(Query users) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy('creationTime', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          debugPrint("ERROR" + users.snapshots().toString());
          return Container();
        }
        if (!snapshot.hasData) {
          return Text("");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        return ListView(
            children: snapshot.data!.docs.map((document) {
          try {
            if (prefTags!.contains(document['Hash'])) {
              return cardReturn(document);
            } else {
              return Container();
            }
          } catch (exception) {
            return cardReturn(document);
          }
        }).toList());
      },
    );
  }

  bool prefSelected = true;
  loadData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefTags = prefs.getStringList('hash');
      print(prefTags);
    } catch (exception) {
      prefTags = ['Null'];
      prefSelected = false;
    }
  }
}
