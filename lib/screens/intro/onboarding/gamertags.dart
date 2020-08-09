import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/screens/intro/onboarding/update_profile.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class Gamertags extends StatefulWidget {
  @override
  _GamertagsState createState() => _GamertagsState();
}

class _GamertagsState extends State<Gamertags> {
  //Variables
  bool keyboardIsHidden;

  @override
  void initState() {
    //Keyboard
    keyboardIsHidden = true;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardIsHidden = !visible;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: metaDarkBlue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: metaDarkBlue,
        ),
        body: SafeArea(
          child: Container(
            width: DeviceSize().getWidth(context),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      right: DeviceSize().getWidth(context) / 16,
                      left: DeviceSize().getWidth(context) / 16,
                      top: DeviceSize().getHeight(context) * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'What\'re your games?',
                        style: onboardingTitleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Let us do the hard work of finding you players and tournaments',
                          style: onboardingDescriptionTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gameTile(game: Games.ModernWarfare),
                        SizedBox(
                          width: 5,
                        ),
                        gameTile(game: Games.LeagueOfLegends),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gameTile(game: Games.Fortnite),
                        SizedBox(
                          width: 5,
                        ),
                        gameTile(game: Games.Other)
                      ],
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
        floatingActionButton: keyboardIsHidden
            ? rightFAB(
                title: 'Next',
                onPressed: () {
                  Navigation().segue(
                      page: UpdateProfile(),
                      context: context,
                      fullScreen: false);
                },
              )
            : null,
      ),
    );
  }

  //Widgets
  Widget gameTile({@required Games game}) {
    //Variables
    AssetImage icon;
    AssetImage backgroundImage;

    //Conditionals
    if (game == Games.ModernWarfare) {
      icon = AssetImage('images/cod_mw_logo.png');
      backgroundImage = AssetImage('images/mw_preview.jpg');
    } else if (game == Games.LeagueOfLegends) {
      icon = AssetImage('images/league_logo.png');
      backgroundImage = AssetImage('images/lol_preview.jpg');
    } else if (game == Games.Fortnite) {
      icon = AssetImage('images/fortnite_logo.png');
      backgroundImage = AssetImage('images/fortnite_preview.jpg');
    } else {
      backgroundImage = AssetImage('images/other_preview.png');
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: DeviceSize().getHeight(context) / 3.5,
        child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: backgroundImage, fit: BoxFit.cover)),
                ),
                Container(
                  color: Colors.black45,
                ),
                Center(
                  child: icon != null
                      ? Container(
                          height: 40,
                          width: 40,
                          child: Image(
                            image: icon,
                          ),
                        )
                      : Text('Other',
                          style: GoogleFonts.sourceCodePro(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 25)),
                )
              ],
            )),
      ),
    );
  }
}
