import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendPost{

  String getRandomNine() {
    int min = 100000000; //min and max values act as your 6 digit range
    int max = 999999999;
    var randomNum = new Random();
    return (min + randomNum.nextInt(max - min)).toString();
  }
  Future<void> postOnline(String postBody,String hashTags, String base64Image) async {
    CollectionReference createPost = FirebaseFirestore.instance.collection("Post").doc("Approved").collection("Beta");
    String User = FirebaseAuth.instance.currentUser!.uid;
    return createPost.doc(hashTags + "-" + User + getRandomNine()).set({
      'Post' : postBody,
      'Hash' : hashTags,
      'Score' : 0,
      'Image' : base64Image,
      'creationTime' : Timestamp.now(),
    },SetOptions(merge: true)).then((value) => print("Success"))
        .catchError((error) => print("Failed: $error"));
  }
}