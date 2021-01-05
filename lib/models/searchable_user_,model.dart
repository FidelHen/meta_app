import 'package:flutter/material.dart';

class SearchableUserModel {
  //Constructor
  SearchableUserModel(
      {@required this.isPro,
      @required this.profileImage,
      @required this.uid,
      @required this.username});

  final String uid;
  final String username;
  final String profileImage;
  final bool isPro;
}
