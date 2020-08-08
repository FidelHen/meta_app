import 'package:flutter/material.dart';
import 'package:meta_app/utils/enums.dart';

class SocialButtonModel {
  //Constructor
  SocialButtonModel({@required this.social, @required this.url});

  //Variables
  final String url;
  final SocialMedia social;
}
