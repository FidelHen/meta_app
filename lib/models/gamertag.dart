import 'package:flutter/material.dart';
import 'package:meta_app/utils/enums.dart';

class Gamertag {
  //Constructor
  Gamertag({@required this.platform, @required this.gamertag});

  //Variables
  final GamertagPlatform platform;
  final String gamertag;
}
