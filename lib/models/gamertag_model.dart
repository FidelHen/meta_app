import 'package:flutter/material.dart';
import 'package:meta_app/utils/enums.dart';

class GamertagModel {
  //Constructor
  GamertagModel(
      {@required this.platform, @required this.gamertag, @required this.game});

  //Variables
  final GamertagPlatform platform;
  final String gamertag;
  final GamertagPlatform game;
}
