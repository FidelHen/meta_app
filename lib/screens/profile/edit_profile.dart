import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
    usernameController.text = 'Fidelhen';
    bioController = TextEditingController();
    bioController.text =
        'Stream every day on Twitch! Looking for aggro players on COD, DM me if you’re down!';
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
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.chevronDown,
            color: Colors.white,
            size: 40,
          ),
        ),
        title: Text(
          'Edit profile',
          style: appBarTextStyle,
        ),
        backgroundColor: metaDarkBlue,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: DeviceSize().getWidth(context) / 16,
          left: DeviceSize().getWidth(context) / 16,
        ),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Padding(
            padding: EdgeInsets.only(
              top: 24.0,
            ),
            child: Hero(
              tag: 'profileImage',
              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                          height: DeviceSize().getWidth(context) * 0.25,
                          width: DeviceSize().getWidth(context) * 0.25,
                          color: Colors.grey,
                          child: Image.asset('images/temp_avatar.png')),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: metaDarkBlue, width: 2)),
                      child: Icon(
                        EvaIcons.edit,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ),
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
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
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
                counterStyle: GoogleFonts.openSans(color: Colors.white),
                enabledBorder: keyboardEnabledBorder,
                focusedBorder: keyboardFocusedBorder,
                errorBorder: keyboardErrorBorder,
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
              ),
            ),
          ),
          textFieldTitle(title: 'Social links'),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.next,
                    cursorColor: metaGreen,
                    style: textFieldTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Twitch',
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: twitchPurple, shape: BoxShape.circle),
                            child: Image.asset('images/twitch_logo.png',
                                scale: 45)),
                      ),
                      enabledBorder: keyboardEnabledBorder,
                      focusedBorder: keyboardFocusedBorder,
                      errorBorder: keyboardErrorBorder,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.next,
                    cursorColor: metaGreen,
                    style: textFieldTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Facebook Gaming',
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: facebookBlue, shape: BoxShape.circle),
                            child: Image.asset(
                                'images/facebook_gaming_logo.png',
                                scale: 50)),
                      ),
                      enabledBorder: keyboardEnabledBorder,
                      focusedBorder: keyboardFocusedBorder,
                      errorBorder: keyboardErrorBorder,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.next,
                    cursorColor: metaGreen,
                    style: textFieldTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Youtube',
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: youtubeRed, shape: BoxShape.circle),
                            child: Image.asset('images/youtube_logo.png',
                                scale: 40)),
                      ),
                      enabledBorder: keyboardEnabledBorder,
                      focusedBorder: keyboardFocusedBorder,
                      errorBorder: keyboardErrorBorder,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {},
                    textInputAction: TextInputAction.next,
                    cursorColor: metaGreen,
                    style: textFieldTextStyle,
                    decoration: InputDecoration(
                      hintText: 'Twitter',
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: twitterBlue, shape: BoxShape.circle),
                            child: Image.asset('images/twitter_logo.png',
                                color: Colors.white, scale: 35)),
                      ),
                      enabledBorder: keyboardEnabledBorder,
                      focusedBorder: keyboardFocusedBorder,
                      errorBorder: keyboardErrorBorder,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50)
        ]),
      ),
      floatingActionButton: keyboardIsHidden
          ? extendedFAB(
              context: context,
              title: 'Save',
              color: Colors.white,
              onPressed: () {
                showOverlayNotification((context) {
                  return SuccessToast(
                    title: 'Successfully saved',
                  );
                });
                Navigator.pop(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
