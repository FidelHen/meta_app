import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/modals/media_modal.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/screens/intro/onboarding/creating_account.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class UpdateProfile extends StatefulWidget {
  //Constructor
  UpdateProfile({@required this.gamertags});

  //Variables
  final List<GamertagModel> gamertags;

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
  File profileImage;

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
                      GestureDetector(
                        onTap: () {
                          showMediaModal(
                              context: context, callback: getImageCallback);
                        },
                        child: Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height:
                                        DeviceSize().getWidth(context) * 0.2,
                                    width: DeviceSize().getWidth(context) * 0.2,
                                    color: Colors.grey,
                                    child: profileImage != null
                                        ? Image.file(
                                            profileImage,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'images/temp_avatar.png',
                                            fit: BoxFit.cover,
                                          )),
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
                      textFieldTitle(title: 'How do you game? (bio)'),
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
                  if (validate() == true) {
                    Navigation().segueToRoot(
                        page: CreatingAccount(
                            bio: bioController.text ?? '',
                            gamertags: widget.gamertags,
                            profileImage: profileImage,
                            username: usernameController.text),
                        context: context,
                        fullScreen: true);
                  }
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  //Functions
  bool validate() {
    if (usernameController.text.trim().length < 3) {
      //Username == null
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Username must be atlest 3 characters',
        );
      });
      return false;
    } else {
      return true;
    }
  }

  void getImageCallback({File image}) {
    setState(() {
      profileImage = image;
    });
  }
}
