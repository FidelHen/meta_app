import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/models/social_media_model.dart';
import 'package:meta_app/utils/enums.dart';

class User {
  Future<String> getUid() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;

    return uid;
  }

  Future<DocumentSnapshot> getProfileData({@required String uid}) {
    return Firestore.instance.collection('users').document(uid ?? '').get();
  }

  Future<bool> checkUsername(
      {@required String uid, @required String username}) async {
    final DocumentSnapshot document = await Firestore.instance
        .collection('usernames')
        .document(username)
        .get();
    return document.exists;
  }

  Future<List<SocialMediaModel>> getSocials({@required String uid}) async {
    //Variables
    List<SocialMediaModel> socials = [];

    //Get data from DB
    final QuerySnapshot snapshot = await Firestore.instance
        .collection('users')
        .document(uid ?? '')
        .collection('socials')
        .getDocuments();

    snapshot.documents.forEach((element) {
      socials.add(SocialMediaModel(
          platform: EnumToString.fromString(SocialMedia.values,
              element.data['platform'].toString().split('.')[1]),
          url: element.data['url']));
    });

    return socials;
  }

  Future<List<GamertagModel>> getGamertags({@required String uid}) async {
    //Variables
    List<GamertagModel> gamertags = [];

    //Get data from DB
    final QuerySnapshot snapshot = await Firestore.instance
        .collection('users')
        .document(uid ?? '')
        .collection('gamertags')
        .getDocuments();

    //Parse data
    snapshot.documents.forEach((element) {
      gamertags.add(GamertagModel(
        platform: EnumToString.fromString(GamertagPlatform.values,
            element.data['platform'].toString().split('.')[1]),
        gamertag: element.data['gamertag'],
        game: EnumToString.fromString(GamertagPlatform.values,
            element.data['game'].toString().split('.')[1]),
      ));
    });

    return gamertags;
  }
}
