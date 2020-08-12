import 'package:flutter/material.dart';
import 'package:meta_app/utils/enums.dart';

String getPlatformImage({@required GamertagPlatform platform}) {
  if (platform == GamertagPlatform.Fortnite) {
    return 'images/fortnite_logo.png';
  } else if (platform == GamertagPlatform.LeagueOfLegends) {
    return 'images/league_logo.png';
  } else if (platform == GamertagPlatform.Mobile) {
    return 'images/mobile_logo.png';
  } else if (platform == GamertagPlatform.ModernWarfare) {
    return 'images/cod_mw_logo.png';
  } else if (platform == GamertagPlatform.PC) {
    return 'images/pc_logo.png';
  } else if (platform == GamertagPlatform.PS4) {
    return 'images/playstation_logo.png';
  } else if (platform == GamertagPlatform.Switch) {
    return 'images/switch_logo.png';
  } else if (platform == GamertagPlatform.Xbox) {
    return 'images/xbox_logo.png';
  } else if (platform == GamertagPlatform.Mac) {
    return 'images/mac_logo.png';
  } else {
    return '';
  }
}
