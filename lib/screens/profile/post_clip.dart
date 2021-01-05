import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/components/FAB.dart';
import 'package:meta_app/components/modals/media_modal.dart';
import 'package:meta_app/components/textFields.dart';
import 'package:meta_app/components/toast/error_toast.dart';
import 'package:meta_app/components/toast/loading_toast.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/models/profile_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostClip extends StatefulWidget {
  //Constructor
  PostClip({@required this.profileData, @required this.callback});

  //Variables
  final ProfileModel profileData;
  final Function callback;

  @override
  _PostClipState createState() => _PostClipState();
}

class _PostClipState extends State<PostClip>
    with SingleTickerProviderStateMixin {
  //TextField controllers
  TextEditingController youtubeUrlController;
  TextEditingController youtubeTagsController;
  TextEditingController twitchUrlController;
  TextEditingController twitchTagsController;

  //Variables
  int selectedIndex;
  List<String> tagsList;
  Color submitButtonColor;
  TabController tabController;
  bool keyboardIsHidden;
  File twitchClipThumbnail;

  //Youtube
  String youtubeVideoId;
  YoutubePlayerController youtubeVideoController;
  List<String> youtubeTags = [];
  List<String> twitchTags = [];

  @override
  void initState() {
    //Textfield controllers
    youtubeUrlController = TextEditingController();
    youtubeTagsController = TextEditingController();
    twitchUrlController = TextEditingController();
    twitchTagsController = TextEditingController();

    //Variables
    selectedIndex = 0;
    submitButtonColor = youtubeRed;
    tagsList = List<String>();

    //Tab Controller
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      if (tabController.index == 0) {
        setState(() {
          submitButtonColor = youtubeRed;
        });
      } else if (tabController.index == 1) {
        setState(() {
          submitButtonColor = twitchPurple;
        });
      }
    });

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
  void dispose() {
    //Tab Controller
    tabController.dispose();

    if (youtubeVideoController != null) {
      youtubeVideoController.dispose();
    }

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
          'Post clip',
          style: appBarTextStyle,
        ),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle:
              GoogleFonts.robotoMono(fontWeight: FontWeight.w500),
          labelStyle: GoogleFonts.robotoMono(fontWeight: FontWeight.w600),
          indicatorColor: metaGreen,
          tabs: [
            Tab(
              text: 'Youtube',
            ),
            Tab(
              text: 'Twitch',
            ),
          ],
        ),
        backgroundColor: metaDarkBlue,
        elevation: 0,
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: DeviceSize().getWidth(context) / 16,
              left: DeviceSize().getWidth(context) / 16,
            ),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 8),
                child: youtubeVideoId != null
                    ? YoutubePlayer(
                        controller: youtubeVideoController,
                        showVideoProgressIndicator: true,
                        bottomActions: [],
                        progressColors: ProgressBarColors(
                            playedColor: metaRed,
                            handleColor: metaRed,
                            backgroundColor: Colors.white38),
                        topActions: [],
                      )
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: youtubeRed,
                          child: Image.asset(
                            'images/youtube_logo.png',
                            scale: 18,
                          ),
                        ),
                      ),
              ),
              textFieldTitle(title: 'Youtube video url'),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  onSubmitted: (value) {
                    getYoutubeVideo(url: value);
                  },
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  controller: youtubeUrlController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'youtube.com/watch?v=8GbMaKOAT0g',
                    enabledBorder: keyboardEnabledBorder,
                    focusedBorder: keyboardFocusedBorder,
                    errorBorder: keyboardErrorBorder,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                  ),
                ),
              ),
              textFieldTitle(title: 'Clip tags'),
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: TextField(
                  onChanged: (value) {
                    if (value == ' ') {
                      youtubeTagsController.clear();
                    }
                    if (value.split(' ')[1] != null && value != ' ') {
                      setState(() {
                        youtubeTags.add(value.toLowerCase());
                      });
                      youtubeTagsController.clear();
                    }
                  },
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  controller: youtubeTagsController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'Seperate tags with space',
                    enabledBorder: keyboardEnabledBorder,
                    focusedBorder: keyboardFocusedBorder,
                    errorBorder: keyboardErrorBorder,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: youtubeTagsEntry(),
              ),
            ]),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: DeviceSize().getWidth(context) / 16,
              left: DeviceSize().getWidth(context) / 16,
            ),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 24, 0, 8),
                child: GestureDetector(
                  onTap: () {
                    showMediaModal(
                        context: context, callback: getImageCallback);
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: twitchClipThumbnail != null
                        ? Image.file(
                            twitchClipThumbnail,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: twitchPurple,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/twitch_logo.png',
                                  scale: 18,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Upload clip thumbnail',
                                    style: smallButtonTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              textFieldTitle(title: 'Twitch clip url'),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: twitchUrlController,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'twitch.tv/shroud/video/713192463',
                    enabledBorder: keyboardEnabledBorder,
                    focusedBorder: keyboardFocusedBorder,
                    errorBorder: keyboardErrorBorder,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                  ),
                ),
              ),
              textFieldTitle(title: 'Clip tags'),
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: TextField(
                  onChanged: (value) {
                    if (value == ' ') {
                      twitchTagsController.clear();
                    }
                    if (value.split(' ')[1] != null && value != ' ') {
                      setState(() {
                        twitchTags.add(value.toLowerCase());
                      });
                      twitchTagsController.clear();
                    }
                  },
                  controller: twitchTagsController,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'Seperate tags with space',
                    enabledBorder: keyboardEnabledBorder,
                    focusedBorder: keyboardFocusedBorder,
                    errorBorder: keyboardErrorBorder,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.fromLTRB(12, 18, 12, 18),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 18.0),
                child: twtichTagsEntry(),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: keyboardIsHidden
          ? extendedFAB(
              context: context,
              title: 'Post',
              color: submitButtonColor,
              onPressed: () {
                validate();
              },
              isDark: true)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Functions
  Future<void> uploadData() async {
    //Variables
    final String uid = await User().getUid();
    final batch = Firestore.instance.batch();
    final userDocRef = Firestore.instance.collection('users').document(uid);
    final videoRef = Firestore.instance.collection('clips').document();

    //Conditionals
    if (tabController.index == 0) {
      showOverlayNotification((context) {
        return LoadingToast(
          title: 'Uploading clip',
        );
      });

      Navigator.pop(context);

      //Data
      final Map<String, dynamic> data = {
        'video_uid': videoRef.documentID,
        'video_url': youtubeUrlController.text ?? '',
        'username': widget.profileData.username,
        'date_added': DateTime.now().millisecondsSinceEpoch,
        'tags': youtubeTags,
        'platform': ClipPlatform.Youtube.toString(),
      };

      //Batch data
      batch.setData(
          userDocRef.collection('clips').document(videoRef.documentID), data);
      batch.setData(videoRef, data);

      //Upload to DB
      batch.commit().then((value) async {
        await Future.delayed(Duration(seconds: 3));
        showOverlayNotification((context) {
          return SuccessToast(
            title: 'Successfully uploaded clip',
          );
        });
        widget.callback();
      });
    } else if (tabController.index == 1) {
      showOverlayNotification((context) {
        return LoadingToast(
          title: 'Uploading clip',
        );
      });

      Navigator.pop(context);

      //Data
      final Map<String, dynamic> data = {
        'video_uid': videoRef.documentID,
        'video_url': twitchUrlController.text ?? '',
        'username': widget.profileData.username,
        'date_added': DateTime.now().millisecondsSinceEpoch,
        'tags': twitchTags,
        'platform': ClipPlatform.Twitch.toString(),
        'thumbnail_url': ''
      };

      if (twitchClipThumbnail != null) {
        final StorageReference storageRef = FirebaseStorage.instance
            .ref()
            .child('clips/${videoRef.documentID}/thumbnail.jpg');
        final StorageUploadTask uploadTask =
            storageRef.putFile(twitchClipThumbnail);
        final StorageTaskSnapshot completed = await uploadTask.onComplete;

        await completed.ref.getDownloadURL().then((url) {
          data['thumbnail_url'] = url;
        });
      }

      //Batch data
      batch.setData(
          userDocRef.collection('clips').document(videoRef.documentID), data);
      batch.setData(videoRef, data);

      //Upload to DB
      batch.commit().then((value) async {
        showOverlayNotification((context) {
          return SuccessToast(
            title: 'Successfully uploaded clip',
          );
        });
        widget.callback();
      });
    }
  }

  void validate() {
    if (tabController.index == 0 && youtubeUrlController.text.length != 0 ||
        tabController.index == 1 && twitchUrlController.text.length != 0) {
      uploadData();
    } else {
      showOverlayNotification((context) {
        return ErrorToast(
          title: 'Enter a valid url',
        );
      });
    }
  }

  void getYoutubeVideo({@required String url}) {
    //Variables
    youtubeVideoId = YoutubePlayer.convertUrlToId(url);

    //Youtube controller
    youtubeVideoController = YoutubePlayerController(
      initialVideoId: youtubeVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
      ),
    );
  }

  void getImageCallback({File image}) {
    setState(() {
      twitchClipThumbnail = image;
    });
  }

  //Widgets
  Widget youtubeTagsEntry() {
    return Tags(
      alignment: WrapAlignment.start,
      textField: null,
      itemCount: youtubeTags.length, // required
      itemBuilder: (int index) {
        final String item = youtubeTags[index];
        return ItemTags(
          key: Key(index.toString()),
          index: index, // required
          title: item,
          highlightColor: Colors.transparent,
          pressEnabled: false,
          borderRadius: BorderRadius.circular(50),
          activeColor: metaLightBlue,
          textStyle: clipTagsTextStyle,
          removeButton: ItemTagsRemoveButton(
            backgroundColor: Colors.white,
            color: Colors.black,
            onRemoved: () {
              // Remove the item from the data source.
              setState(() {
                // required
                youtubeTags.removeAt(index);
              });
              //required
              return true;
            },
          ), // OR null,
          onPressed: (item) => print(item),
          onLongPressed: (item) => print(item),
        );
      },
    );
  }

  Widget twtichTagsEntry() {
    return Tags(
      alignment: WrapAlignment.start,
      textField: null,
      itemCount: twitchTags.length, // required
      itemBuilder: (int index) {
        final String item = twitchTags[index];
        return ItemTags(
          key: Key(index.toString()),
          index: index, // required
          title: item,
          highlightColor: Colors.transparent,
          pressEnabled: false,
          borderRadius: BorderRadius.circular(50),
          activeColor: metaLightBlue,
          textStyle: clipTagsTextStyle,
          removeButton: ItemTagsRemoveButton(
            backgroundColor: Colors.white,
            color: Colors.black,
            onRemoved: () {
              // Remove the item from the data source.
              setState(() {
                // required
                twitchTags.removeAt(index);
              });
              //required
              return true;
            },
          ), // OR null,
          onPressed: (item) => print(item),
          onLongPressed: (item) => print(item),
        );
      },
    );
  }
}
