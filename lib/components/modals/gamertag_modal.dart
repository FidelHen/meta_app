import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';

void showGamertagModal({@required context, @required Games game}) {
  //Widgets
  Widget textFieldIcon() {
    if (game == Games.ModernWarfare) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image.asset(
          'images/cod_mw_logo.png',
          scale: 32,
        ),
      );
    } else if (game == Games.LeagueOfLegends) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image.asset(
          'images/league_logo.png',
          scale: 38,
        ),
      );
    } else if (game == Games.Fortnite) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image.asset(
          'images/fortnite_logo.png',
          scale: 38,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget platformOption() {
    //Variables
    List<GamertagPlatform> platformImages = [];

    //Conditionals
    if (game == Games.ModernWarfare) {
      platformImages = [
        GamertagPlatform.PC,
        GamertagPlatform.PS4,
        GamertagPlatform.Xbox,
      ];
    } else if (game == Games.Fortnite) {
      platformImages = [
        GamertagPlatform.PC,
        GamertagPlatform.PS4,
        GamertagPlatform.Xbox,
        GamertagPlatform.Switch,
        GamertagPlatform.Mobile,
      ];
    }

    //Widget
    if (game == Games.LeagueOfLegends) {
      return Container();
    } else {
      return Container(
        height: 70,
        child: ListView.builder(
          itemCount: platformImages.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8, right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: Image.asset(
                      getPlatformImage(platform: platformImages[index]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      platformImages[index].toString().split('.')[1],
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      );
    }
  }

  //Modals
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: game == Games.LeagueOfLegends
              ? 100 + MediaQuery.of(context).viewInsets.bottom
              : 170 + MediaQuery.of(context).viewInsets.bottom,
          decoration: BoxDecoration(
            color: metaLightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                right: DeviceSize().getWidth(context) * 0.02,
                left: DeviceSize().getWidth(context) * 0.02,
                top: 10,
              ),
              child: Column(
                children: [
                  platformOption(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: DeviceSize().getWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.15),
                            ),
                            child: TextField(
                              autofocus: true,
                              style: textFieldTextStyle,
                              onSubmitted: (value) {
                                User().getUserUid().then((uid) {
                                  print(uid);
                                });
                                Navigator.pop(context);
                              },
                              cursorColor: metaGreen,
                              decoration: InputDecoration(
                                hintText: 'Enter gamertag',
                                hintStyle: textFieldTextStyle.copyWith(
                                    color: Colors.white70),
                                icon: textFieldIcon(),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      });
}
