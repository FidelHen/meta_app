import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/intro/onboarding/creating_account.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  //TextFields
  TextEditingController usernameController;
  TextEditingController bioController;
  FocusNode usernameNode;
  FocusNode bioNode;

  //Variables
  bool keyboardIsHidden;

  @override
  void initState() {
    //TextFields
    usernameController = TextEditingController();
    bioController = TextEditingController();
    usernameNode = FocusNode();
    bioNode = FocusNode();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              EvaIcons.chevronLeft,
              color: Colors.white,
              size: 40,
            ),
          ),
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
                        'Update your profile',
                        style: GoogleFonts.sourceCodePro(
                            color: Colors.white,
                            fontSize: 22,
                            wordSpacing: -2,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          'What do we call you?',
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Image.asset(
                              'images/temp_avatar.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                        child: Text(
                          'Display name',
                          style: textFeidTitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          onSubmitted: (value) {
                            bioNode.requestFocus();
                          },
                          focusNode: usernameNode,
                          textInputAction: TextInputAction.next,
                          cursorColor: metaGreen,
                          controller: usernameController,
                          style: textFieldTextStyle,
                          maxLength: 25,
                          decoration: InputDecoration(
                            counterStyle:
                                GoogleFonts.openSans(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: metaLightBlue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: metaGreen, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: metaRed, width: 2),
                            ),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                        child: Text(
                          'How do you game?',
                          style: textFeidTitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          maxLines: 4,
                          onSubmitted: (value) {},
                          focusNode: bioNode,
                          controller: bioController,
                          textInputAction: TextInputAction.done,
                          cursorColor: metaGreen,
                          style: textFieldTextStyle,
                          maxLength: 150,
                          decoration: InputDecoration(
                            counterStyle:
                                GoogleFonts.openSans(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: metaLightBlue, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: metaGreen, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: metaRed, width: 2),
                            ),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                    Navigation().segueToRoot(
                        page: CreatingAccount(),
                        context: context,
                        fullScreen: true);
                  },
                  label: Container(
                    width: DeviceSize().getWidth(context) * 0.7,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Center(
                        child: Text(
                          'Let\'s go!',
                          style: fabButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
