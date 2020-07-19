import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/modals/platform_modal.dart';
import 'package:meta_app/intro/onboarding/update_profile.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
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
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
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
                        style: GoogleFonts.sourceCodePro(
                            color: Colors.white,
                            wordSpacing: -2,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'Let us do the hard work of finding you players and tournaments',
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: DeviceSize().getWidth(context) / 16,
                    left: DeviceSize().getWidth(context) / 16,
                    top: 40,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      showPlatformModal(context: context);
                    },
                    color: metaLightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      height: 50,
                      width: DeviceSize().getWidth(context),
                      child: Center(
                        child: Text(
                          'Add gamertag',
                          style: GoogleFonts.openSans(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      right: DeviceSize().getWidth(context) / 16,
                      left: DeviceSize().getWidth(context) / 16,
                      top: 25,
                    ),
                    child: Column(
                      children: [
                        gamertagTextField(image: 'playstation_logo.png'),
                        gamertagTextField(image: 'xbox_logo.png'),
                        gamertagTextField(image: 'pc_logo.png'),
                        gamertagTextField(image: 'switch_logo.png'),
                        gamertagTextField(image: 'mobile_logo.png'),
                        gamertagTextField(image: 'league_logo.png'),
                        gamertagTextField(image: 'cod_mw_logo.png'),
                        gamertagTextField(image: 'fortnite_logo.png'),
                      ],
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: keyboardIsHidden
            ? Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigation().segue(
                        page: UpdateProfile(),
                        context: context,
                        fullScreen: false);
                  },
                  label: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        'Next',
                        style: fabButtonTextStyle,
                      ),
                    ),
                    Icon(
                      EvaIcons.chevronRight,
                      color: Colors.black,
                    ),
                  ]),
                ),
              )
            : null,
      ),
    );
  }

  Widget gamertagTextField({@required String image}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextField(
        onSubmitted: (value) {},
        textInputAction: TextInputAction.done,
        cursorColor: metaGreen,
        style: textFieldTextStyle,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.all(14.0),
            child: Image(
              image: AssetImage('images/$image'),
              height: 10,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: metaLightBlue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: metaGreen, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: metaRed, width: 2),
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
        ),
      ),
    );
  }
}
