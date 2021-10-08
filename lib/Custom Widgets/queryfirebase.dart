import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QueryFirebase {

  CollectionReference data = FirebaseFirestore.instance.collection('Post').doc('Approved').collection('Beta');
StreamBuilder<QuerySnapshot> buildStreamBuilder(String hTag)  {


  return StreamBuilder<QuerySnapshot>(
    stream: data.where('Hash',arrayContains: hTag).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        debugPrint("ERROR" + data.snapshots().toString());
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