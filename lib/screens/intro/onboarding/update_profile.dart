import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/screens/intro/onboarding/creating_account.dart';
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
                        style: onboardingTitleTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          'What do we call you?',
                          style: onboardingDescriptionTextStyle,
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
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                  height: DeviceSize().getWidth(context) * 0.2,
                                  width: DeviceSize().getWidth(context) * 0.2,
                                  color: Colors.grey,
                                  child: Image.asset('images/temp_avatar.png')),
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: metaDarkBlue, width: 2)),
                              child: Icon(
                                EvaIcons.edit,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                      textFieldTitle(title: 'Display name'),
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
                            enabledBorder: keyboardEnabledBorder,
                            focusedBorder: keyboardFocusedBorder,
                            errorBorder: keyboardErrorBorder,
                            border: OutlineInputBorder(),
                            contentPadding: textFieldContentPadding,
                          ),
                        ),
                      ),
                      textFieldTitle(title: 'How do you game?'),
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
                            enabledBorder: keyboardEnabledBorder,
                            focusedBorder: keyboardFocusedBorder,
                            errorBorder: keyboardErrorBorder,
                            border: OutlineInputBorder(),
                            contentPadding: textFieldContentPadding,
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
            ? extendedFAB(
                context: context,
                title: 'Let\'s go!',
                color: Colors.white,
                onPressed: () {
                  Navigation().segueToRoot(
                      page: CreatingAccount(),
                      context: context,
                      fullScreen: true);
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
