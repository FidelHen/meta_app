import 'package:flutter/material.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/models/social_media_model.dart';

class ProfileModel {
  //Constructor
  ProfileModel({
    @required this.bio,
    @required this.gamertags,
    @required this.profileImageUrl,
    @required this.socials,
    @required this.uid,
    @required this.username,
    @required this.videoUids,
  });

  //Variables
  final String uid;
  final String profileImageUrl;
  final String username;
  final String bio;
  final List<SocialMediaModel> socials;
  final List<GamertagModel> gamertags;
  final List<String> videoUids;
}
