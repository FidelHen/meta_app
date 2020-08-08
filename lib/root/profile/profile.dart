import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/profile/profile_action_buttons.dart';
import 'package:meta_app/components/profile/profile_bio.dart';
import 'package:meta_app/components/profile/profile_gamertags.dart';
import 'package:meta_app/components/profile/profile_image.dart';
import 'package:meta_app/components/profile/profile_socials.dart';
import 'package:meta_app/components/video_clip.dart';
import 'package:meta_app/models/gamertag.dart';
import 'package:meta_app/root/profile/post_clip.dart';
import 'package:meta_app/root/settings/settings.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //ScrollController
  ScrollController listScrollController;

  //Variables
  bool fabIsHidden;
  String username;
  String profileImageUrl;

  @override
  void initState() {
    //ScrollController
    listScrollController = ScrollController();

    //Varibles
    fabIsHidden = false;
    username = 'Fidelhen';
    profileImageUrl = null;

    //Functions
    scrollControllerListener();

    super.initState();
  }

  @override
  void dispose() {
    //ScrollController
    listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          username,
          style: appBarTextStyle,
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Shimmer.fromColors(
                baseColor: metaYellow,
                highlightColor: metaRed,
                child: Icon(EvaIcons.globe2Outline)),
            onPressed: () {},
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(EvaIcons.settingsOutline),
              onPressed: () {
                Navigation().segue(
                    page: Settings(), context: context, fullScreen: true);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: DeviceSize().getWidth(context),
        child: ListView(
          controller: listScrollController,
          physics: BouncingScrollPhysics(),
          children: buildProfile(),
        ),
      ),
      floatingActionButton: !fabIsHidden
          ? FloatingActionButton(
              onPressed: () {
                Navigation().segue(
                    page: PostClip(), context: context, fullScreen: true);
              },
              backgroundColor: metaYellow,
              child: Icon(EvaIcons.flash, color: Colors.white))
          : null,
    );
  }

  //Widget
  List<Widget> buildProfile() {
    return [
      ProfileImage(
        profileImageUrl: profileImageUrl,
      ),
      ProfileBio(
        bio:
            'Stream every day on Twitch! Looking for aggro players on COD, DM me if you’re down!',
      ),
      ProfileSocials(
          twitchUrl: 'https://www.twitch.tv/nickmercs',
          fbGamingUrl:
              'https://www.facebook.com/OfficialY8/videos/4228325127207583/',
          youtubeUrl: 'https://www.youtube.com/user/TheRealNICKMERCS',
          twitterUrl: 'https://twitter.com/NICKMERCS'),
      ProfileActionButtons(
        profileAction: ProfileActionOption.IsOwner,
        isViewerPro: false,
      ),
      ProfileGamertags(
        gamertagsList: [
          Gamertag(
              platform: GamertagPlatform.LeagueOfLegends,
              gamertag: 'Gainzville'),
          Gamertag(
              platform: GamertagPlatform.ModernWarfare, gamertag: 'HenFidel'),
          Gamertag(platform: GamertagPlatform.Fortnite, gamertag: 'FidelHen'),
          Gamertag(platform: GamertagPlatform.PS4, gamertag: 'HenFidel'),
          Gamertag(platform: GamertagPlatform.Switch, gamertag: 'Gainzville'),
        ],
        isBlurred: false,
      ),
      SizedBox(
        height: 24,
      ),
      VideoClip(
        username: 'Fidelhen',
        profileImageUrl: profileImageUrl,
        tags: ['League', 'Trolling', 'LOL'],
        isOwner: true,
        previewImageUrl:
            'https://img.redbull.com/images/c_crop,x_225,y_0,h_958,w_1437/c_fill,w_1500,h_1000/q_auto,f_auto/redbullcom/2017/10/11/f64b8633-e848-4afa-9791-9da869f7bfd7/league-of-legends-champions',
        clipPlatform: ClipPlatform.Youtube,
        videoUrl: 'https://www.youtube.com/watch?v=6LpA7_-Srqg',
      ),
    ];
  }

  //Functions
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
}
