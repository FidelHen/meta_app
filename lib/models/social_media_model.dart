import 'package:flutter/material.dart';
import 'package:meta_app/utils/enums.dart';

class SocialMediaModel {
  //Constructor
  SocialMediaModel({@required this.platform, @required this.url});

  //Variables
  final String url;
  final SocialMedia platform;
}
