import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User {
  Future<String> getUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    return uid;
  }

  Future<DocumentSnapshot> getProfileData({@required String uid}) {
    return Firestore.instance.collection('users').document(uid ?? '').get();
  }
}
