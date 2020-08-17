import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/modals/media_modal.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/models/profile_model.dart';
import 'package:meta_app/utils/auth.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/service.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';
import 'package:overlay_support/overlay_support.dart';

class EditProfile extends StatefulWidget {
  //Constructor
  EditProfile({@required this.profileData, @required this.callback});

  //Variables
  final ProfileModel profileData;
  final Function callback;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //ScrollController
  ScrollController listScrollController;

  //TextFields
  TextEditingController usernameController;
  TextEditingController bioController;
  TextEditingController twitchController;
  TextEditingController fbGamingController;
  TextEditingController youtubeController;
  TextEditingController twitterController;
  bool fabIsHidden;
  bool isLoading;
  FocusNode usernameNode;
  FocusNode bioNode;

  //Variables
  bool keyboardIsHidden;
  File profileImage;
  String twitchUsername = '';
  String fbGamingUsername = '';
  String youtubeChannel = '';
  String twitterUsername = '';

  @override
  void initState() {
    //ScrollController
    listScrollController = ScrollController();

    //Varibles
    fabIsHidden = false;
    isLoading = false;

    //TextFields
    usernameController = TextEditingController();
    usernameController.text = widget.profileData.username;
    bioController = TextEditingController();
    bioController.text = widget.profileData.bio;
    twitchController = TextEditingController();
    fbGamingController = TextEditingController();
    youtubeController = TextEditingController();
    twitterController = TextEditingController();
    usernameNode = FocusNode();
    bioNode = FocusNode();

    //Keyboard
    keyboardIsHidden = true;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        keyboardIsHidden = !visible;
      },
    );

    //Functions
    scrollControllerListener();
    addSocialUsernames();

    super.initState();
  }

  @override
  void dispose() {
    //Disposing controllers
    usernameController.dispose();
    bioController.dispose();
    twitchController.dispose();
    fbGamingController.dispose();
    youtubeController.dispose();
    twitterController.dispose();

    super.dispose();
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
        child: ListView(
            controller: listScrollController,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Hero(
                  tag: 'profileImage',
                  child: GestureDetector(
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
                                height: DeviceSize().getWidth(context) * 0.25,
                                width: DeviceSize().getWidth(context) * 0.25,
                                color: Colors.grey,
                                child: profileImage != null
                                    ? Image.file(
                                        profileImage,
                                        fit: BoxFit.cover,
                                      )
                                    : widget.profileData.profileImageUrl
                                                .trim()
                                                .length !=
                                            0
                                        ? Image.network(
                                            widget.profileData.profileImageUrl,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'images/temp_avatar.png')),
                          ),
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: metaDarkBlue, width: 2)),
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
                        controller: twitchController,
                        onSubmitted: (value) {
                          twitchUsername = value;
                        },
                        cursorColor: metaGreen,
                        style: textFieldTextStyle,
                        decoration: InputDecoration(
                          hintText: 'username',
                          hintStyle: textFieldTextStyle.copyWith(
                              color: Colors.white70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: twitchPurple,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          'images/twitch_logo.png',
                                          scale: 40)),
                                ),
                                Text(
                                  'twitch.tv/',
                                  style: textFeidTitleTextStyle,
                                )
                              ],
                            ),
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
                        controller: fbGamingController,
                        onSubmitted: (value) {
                          fbGamingUsername = value;
                        },
                        cursorColor: metaGreen,
                        style: textFieldTextStyle,
                        decoration: InputDecoration(
                          hintText: 'username',
                          hintStyle: textFieldTextStyle.copyWith(
                              color: Colors.white70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: facebookBlue,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          'images/facebook_gaming_logo.png',
                                          scale: 45)),
                                ),
                                Text(
                                  'facebook.com/gaming/',
                                  style: textFeidTitleTextStyle,
                                )
                              ],
                            ),
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
                        controller: youtubeController,
                        onSubmitted: (value) {
                          youtubeChannel = value;
                        },
                        cursorColor: metaGreen,
                        style: textFieldTextStyle,
                        decoration: InputDecoration(
                          hintText: 'Youtube channel',
                          hintStyle: textFieldTextStyle.copyWith(
                              color: Colors.white70),
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
                        controller: twitterController,
                        onSubmitted: (value) {
                          twitterUsername = value;
                        },
                        cursorColor: metaGreen,
                        style: textFieldTextStyle,
                        decoration: InputDecoration(
                          hintText: 'username',
                          hintStyle: textFieldTextStyle.copyWith(
                              color: Colors.white70),
                          prefixIcon: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 2, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: twitterBlue,
                                          shape: BoxShape.circle),
                                      child: Image.asset(
                                          'images/twitter_logo.png',
                                          scale: 32)),
                                ),
                                Text(
                                  'twitter.com/',
                                  style: textFeidTitleTextStyle,
                                )
                              ],
                            ),
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
              SizedBox(height: 25)
            ]),
      ),
      floatingActionButton: !fabIsHidden
          ? keyboardIsHidden
              ? extendedFAB(
                  context: context,
                  title: 'Save',
                  color: Colors.white,
                  onPressed: () {
                    updateData();
                  },
                )
              : null
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Functions
  void updateData() async {
    //Variables
    String twitchUrl;
    String twitterUrl;
    String fbGamingUrl;
    String youtubeUrl;
    String uid = await User().getUid();
    final batch = Firestore.instance.batch();
    final socialsRef = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('socials');

    //Update profile image
    if (profileImage != null) {
      final StorageReference storageRef =
          FirebaseStorage.instance.ref().child('users/$uid/profile_image.jpg');
      final StorageUploadTask uploadTask = storageRef.putFile(profileImage);
      final StorageTaskSnapshot completed = await uploadTask.onComplete;

      await completed.ref.getDownloadURL().then((url) {
        batch.setData(Firestore.instance.collection('users').document(uid),
            {'profile_image': url},
            merge: true);
      });
    }

    //Update username
    if (widget.profileData.username != usernameController.text) {
      final String username = usernameController.text.trim();
      if (Service().usernameValidator(username: username)) {
        final usernameIsTaken =
            await Auth().usernameAlreadyInUse(username: username);
        if (!usernameIsTaken) {
          batch.delete(Firestore.instance
              .collection('usernames')
              .document(widget.profileData.username));
          batch.setData(
              Firestore.instance.collection('usernames').document(username), {
            'username': username,
            'uid': uid,
          });
          batch.setData(Firestore.instance.collection('users').document(uid),
              {'username': username},
              merge: true);
        } else {
          //Wrong username
          showOverlayNotification((context) {
            return ErrorToast(
              title: 'Username is already taken',
            );
          });
        }
      } else {
        //Wrong username
        showOverlayNotification((context) {
          return ErrorToast(
            title: 'Username has to be 3 characters long',
          );
        });
      }
    }

    //Update bio
    if (widget.profileData.bio != bioController.text) {
      batch.setData(Firestore.instance.collection('users').document(uid),
          {'bio': bioController.text.trim()},
          merge: true);
    }

    //Update socials
    widget.profileData.socials.forEach((element) {
      final platform = element.platform;
      if (platform == SocialMedia.Youtube) {
        youtubeUrl = element.url ?? '';
      } else if (platform == SocialMedia.Twitch) {
        twitchUrl = element.url ?? 'https://www.twitch.tv/';
      } else if (platform == SocialMedia.Twitter) {
        twitterUrl = element.url ?? 'https://twitter.com/';
      } else if (platform == SocialMedia.FBGaming) {
        fbGamingUrl = element.url ?? 'https://www.facebook.com/gaming/';
      }
    });

    //Youtube link
    if (youtubeUrl != youtubeChannel) {
      batch.setData(socialsRef.document('youtube'),
          {'url': youtubeChannel, 'platform': SocialMedia.Youtube.toString()});
    }

    //Facebook Gaming link
    final String newFbGamingUrl =
        'https://www.facebook.com/gaming/' + fbGamingUsername ?? '';
    //Matching then batch
    if (fbGamingUrl != newFbGamingUrl) {
      batch.setData(socialsRef.document('fb_gaming'), {
        'url': newFbGamingUrl,
        'username': fbGamingUsername,
        'platform': SocialMedia.FBGaming.toString()
      });
    }

    //Twtich url
    final String newTwitchUrl = 'https://www.twitch.tv/' + twitchUsername ?? '';
    //Matching then batch
    if (twitchUrl != newTwitchUrl) {
      batch.setData(socialsRef.document('twitch'), {
        'url': newTwitchUrl,
        'username': twitchUsername,
        'platform': SocialMedia.Twitch.toString()
      });

      //Twitter url
      final String newTwitterUrl =
          'https://twitter.com/' + twitterUsername ?? '';
      //Matching then batch
      if (twitterUrl != newTwitterUrl) {
        batch.setData(socialsRef.document('twitter'), {
          'url': newTwitterUrl,
          'username': twitterUsername,
          'platform': SocialMedia.Twitter.toString()
        });
      }
    }

    //Commit all of the data
    batch.commit().then((_) {
      //Overlay
      showOverlayNotification((context) {
        return SuccessToast(
          title: 'Successfully saved',
        );
      });

      //Update profile
      widget.callback();

      //Go back to screen
      Navigator.pop(context);
    });
  }

  void addSocialUsernames() {
    widget.profileData.socials.forEach((element) {
      //Variables
      final SocialMedia platform = element.platform;
      final String url = element.url;

      //Conditionals
      if (platform == SocialMedia.Youtube) {
        youtubeChannel = url;
        youtubeController.text = url;
      } else if (platform == SocialMedia.FBGaming) {
        fbGamingController.text =
            url.split('https://www.facebook.com/gaming/')[1] ?? '';
        fbGamingUsername =
            url.split('https://www.facebook.com/gaming/')[1] ?? '';
      } else if (platform == SocialMedia.Twitch) {
        twitchController.text = url.split('https://www.twitch.tv/')[1] ?? '';
        twitchUsername = url.split('https://www.twitch.tv/')[1] ?? '';
      } else if (platform == SocialMedia.Twitter) {
        twitterController.text = url.split('https://twitter.com/')[1] ?? '';
        twitterUsername = url.split('https://twitter.com/')[1] ?? '';
      }
    });
  }

  void scrollControllerListener() {
    listScrollController.addListener(() {
      if (listScrollController.position.maxScrollExtent ==
          listScrollController.position.pixels) {
        setState(() {
          fabIsHidden = true;
        });
      } else {
        setState(() {
          fabIsHidden = false;
        });
      }
    });
  }

  void getImageCallback({File image}) {
    setState(() {
      profileImage = image;
    });
  }
}
