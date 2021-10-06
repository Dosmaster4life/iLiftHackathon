import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:share/share.dart';
class home_feed extends StatefulWidget {
  const home_feed({Key? key}) : super(key: key);

  @override
  _home_feedState createState() => _home_feedState();
}

class _home_feedState extends State<home_feed> {
  @override
  Widget build(BuildContext context) {
   CollectionReference data = FirebaseFirestore.instance.collection('Post').doc('Approved').collection('Beta');
    return buildStreamBuilder(data);

  }
  Card cardReturn(DocumentSnapshot document) {

    try {
      if(document['Image'] == "") {
        throw 32;
      }
      final decodedBytes = base64Decode(document['Image']);
      Image pictureData = Image.memory(decodedBytes);
      return Card(
          child: Column( children: [
            ListTile(
              title: Text("#" + document['Hash']),
              subtitle: Text("#" + document['Post'],
              ),),
          pictureData,shareRow(document)]
          ));
    }catch(e) {
      return Card(
          child: Column( children: [
            ListTile(
              title: Text("#" + document['Hash']),
              subtitle: Text("#" + document['Post'],
              ),),
            shareRow(document),
          ]
          ));
    }


  }
  Row shareRow(DocumentSnapshot document) {
    return Row(
      children: [
        TextButton(onPressed: () {
          Share.share("#" + document['Hash'] + "\n" + document['Post']);
        }, child: const Icon(Icons.ios_share))
      ],
    );
  }
  StreamBuilder<QuerySnapshot> buildStreamBuilder(Query users) {
    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          debugPrint("ERROR" + users.snapshots().toString());
          return Container();
        }
        if (!snapshot.hasData) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        return ListView(
            children: snapshot.data!.docs.map((document) {
         return cardReturn(document);
        }).toList());
      },
    );
  }
}
