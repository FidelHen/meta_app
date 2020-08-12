import 'package:flutter/material.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';

void showGamertagModal(
    {@required context,
    @required GamertagPlatform game,
    @required Function callback,
    @required GamertagPlatform platform}) {
  //Variables
  String gamertag = '';

  //Widgets
  Widget textFieldIcon() {
    if (game == GamertagPlatform.ModernWarfare) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image.asset(
          'images/cod_mw_logo.png',
          scale: 32,
        ),
      );
    } else if (game == GamertagPlatform.LeagueOfLegends) {
      return Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image.asset(
          'images/league_logo.png',
          scale: 38,
        ),
      );
    } else if (game == GamertagPlatform.Fortnite) {
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

  //Modals
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 150 + MediaQuery.of(context).viewInsets.bottom,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        callback(
                            game: game, gamertag: gamertag, platform: platform);
                      },
                      child: Text(
                        'Done',
                        style: smallButtonTextStyle.copyWith(color: metaGreen),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(22, 4, 22, 12),
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
                              onChanged: (value) {
                                gamertag = value;
                              },
                              onSubmitted: (value) {
                                Navigator.pop(context);
                                callback(
                                    game: game,
                                    gamertag: value,
                                    platform: platform);
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
