import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class PostClip extends StatefulWidget {
  @override
  _PostClipState createState() => _PostClipState();
}

class _PostClipState extends State<PostClip>
    with SingleTickerProviderStateMixin {
  //Variables
  int selectedIndex;
  List<String> tagsList;
  Color submitButtonColor;
  TabController tabController;
  bool keyboardIsHidden;

  @override
  void initState() {
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
          indicatorColor: Colors.white,
          tabs: [
            Tab(
                icon: Text(
              'Youtube',
              style: GoogleFonts.openSans(
                  fontSize: 14, fontWeight: FontWeight.w600),
            )),
            Tab(
                icon: Text('Twitch',
                    style: GoogleFonts.openSans(
                        fontSize: 14, fontWeight: FontWeight.w600))),
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
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: youtubeRed,
                        borderRadius: BorderRadius.circular(5)),
                    child: Image.asset(
                      'images/youtube_logo.png',
                      scale: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
                child: Text(
                  'Youtube url',
                  style: textFeidTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  onSubmitted: (value) {},
                  // focusNode: usernameNode,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  // controller: usernameController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'youtube.com/watch?v=8GbMaKOAT0g',
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                child: Text(
                  'Clip tags',
                  style: textFeidTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  onSubmitted: (value) {},
                  // focusNode: usernameNode,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  // controller: usernameController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'Seperate tags with space',
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
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        color: twitchPurple,
                        borderRadius: BorderRadius.circular(5)),
                    child: Image.asset(
                      'images/twitch_logo.png',
                      scale: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 24, 8, 12),
                child: Text(
                  'Twitch clip',
                  style: textFeidTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  onSubmitted: (value) {},
                  // focusNode: usernameNode,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  // controller: usernameController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText:
                        'https://clips.twitch.tv/BashfulHelpfulSalamanderPrimeMe',
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                child: Text(
                  'Clip tags',
                  style: textFeidTitleTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  onSubmitted: (value) {},
                  // focusNode: usernameNode,
                  textInputAction: TextInputAction.done,
                  cursorColor: metaGreen,
                  // controller: usernameController,
                  style: textFieldTextStyle,
                  decoration: InputDecoration(
                    hintStyle:
                        textFieldTextStyle.copyWith(color: Colors.white70),
                    hintText: 'Seperate tags with space',
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
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: keyboardIsHidden
          ? Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              child: FloatingActionButton.extended(
                backgroundColor: submitButtonColor,
                onPressed: () {},
                label: Container(
                  width: DeviceSize().getWidth(context) * 0.7,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Center(
                      child: Text(
                        'Post',
                        style: fabButtonTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
