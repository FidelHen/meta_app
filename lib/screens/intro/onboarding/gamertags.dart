import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/modals/gamertag_modal.dart';
import 'package:meta_app/components/modals/gamertag_platform_modal.dart';
import 'package:meta_app/models/gamertag_model.dart';
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
  String codWarzoneGamertagString = '';
  String leagueGamertagString = '';
  String fortniteGamertagString = '';

  List<GamertagModel> gamertagList = [];
  GamertagModel leagueGamertag;
  GamertagModel codWarzoneGamertag;
  GamertagModel fortniteGamertag;

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
                        gameTile(game: GamertagPlatform.ModernWarfare),
                        SizedBox(
                          width: 5,
                        ),
                        gameTile(game: GamertagPlatform.LeagueOfLegends),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        gameTile(game: GamertagPlatform.Fortnite),
                        SizedBox(
                          width: 5,
                        ),
                        gameTile(game: GamertagPlatform.Other)
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
                onPressed: () async {
                  generateGamertagList();
                  Navigation().segue(
                      page: UpdateProfile(
                        gamertags: gamertagList ?? [],
                      ),
                      context: context,
                      fullScreen: false);
                },
              )
            : null,
      ),
    );
  }

  //Functions
  void generateGamertagList() {
    if (leagueGamertag != null) {
      gamertagList.add(leagueGamertag);
    }
    if (codWarzoneGamertag != null) {
      gamertagList.add(codWarzoneGamertag);
    }
    if (fortniteGamertag != null) {
      gamertagList.add(fortniteGamertag);
    }
  }

  void gamertagCallbackFunction(
      {@required GamertagPlatform game,
      @required String gamertag,
      @required GamertagPlatform platform}) {
    if (gamertag.trim().length != 0) {
      if (game == GamertagPlatform.LeagueOfLegends) {
        leagueGamertagString = gamertag;
        leagueGamertag =
            GamertagModel(gamertag: gamertag, platform: platform, game: game);
      } else if (game == GamertagPlatform.ModernWarfare) {
        codWarzoneGamertagString = gamertag;
        codWarzoneGamertag =
            GamertagModel(gamertag: gamertag, platform: platform, game: game);
      } else if (game == GamertagPlatform.Fortnite) {
        fortniteGamertagString = gamertag;
        fortniteGamertag =
            GamertagModel(gamertag: gamertag, platform: platform, game: game);
      }
    } else {
      if (game == GamertagPlatform.LeagueOfLegends) {
        leagueGamertagString = '';
        leagueGamertag = null;
      } else if (game == GamertagPlatform.ModernWarfare) {
        codWarzoneGamertagString = '';
        codWarzoneGamertag = null;
      } else if (game == GamertagPlatform.Fortnite) {
        fortniteGamertagString = '';
        fortniteGamertag = null;
      }
    }
  }

  //Widgets
  Widget gameTile({@required GamertagPlatform game}) {
    //Variables
    Widget icon;
    AssetImage backgroundImage;

    //Conditionals
    if (game == GamertagPlatform.ModernWarfare) {
      icon = codWarzoneGamertagString.trim().length != 0
          ? Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(codWarzoneGamertagString,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            )
          : Container(
              height: 40,
              width: 40,
              child: Image(
                image: AssetImage('images/cod_mw_logo.png'),
              ),
            );
      backgroundImage = AssetImage('images/mw_preview.jpg');
    } else if (game == GamertagPlatform.LeagueOfLegends) {
      icon = leagueGamertagString.trim().length != 0
          ? Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(leagueGamertagString,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            )
          : Container(
              height: 40,
              width: 40,
              child: Image(
                image: AssetImage('images/league_logo.png'),
              ),
            );

      backgroundImage = AssetImage('images/lol_preview.jpg');
    } else if (game == GamertagPlatform.Fortnite) {
      icon = fortniteGamertagString.trim().length != 0
          ? Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(fortniteGamertagString,
                  style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18)),
            )
          : Container(
              height: 40,
              width: 40,
              child: Image(
                image: AssetImage('images/fortnite_logo.png'),
              ),
            );
      backgroundImage = AssetImage('images/fortnite_preview.jpg');
    } else {
      icon = Text('Other',
          style: GoogleFonts.robotoMono(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25));
      backgroundImage = AssetImage('images/other_preview.png');
    }

    return GestureDetector(
      onTap: () {
        if (game != GamertagPlatform.Other &&
            game != GamertagPlatform.LeagueOfLegends) {
          showGamertagPlatformModal(
              context: context, game: game, callback: gamertagCallbackFunction);
        } else {
          if (game == GamertagPlatform.LeagueOfLegends) {
            showGamertagModal(
                context: context,
                game: game,
                callback: gamertagCallbackFunction,
                platform: GamertagPlatform.LeagueOfLegends);
          }
        }
      },
      child: ClipRRect(
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
                    child: icon ?? Container(),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
