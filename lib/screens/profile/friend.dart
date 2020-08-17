import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/friend_modal.dart';
import 'package:meta_app/components/profile/profile_action_buttons.dart';
import 'package:meta_app/components/profile/profile_bio.dart';
import 'package:meta_app/components/profile/profile_gamertags.dart';
import 'package:meta_app/components/profile/profile_image.dart';
import 'package:meta_app/components/video_clip.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';

class Friend extends StatefulWidget {
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  //Variables
  String username;
  String profileImageUrl;

  @override
  void initState() {
    //Varaibles
    username = 'RedDot224';
    profileImageUrl =
        'https://images.pexels.com/photos/1049622/pexels-photo-1049622.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940';

    super.initState();
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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(EvaIcons.moreHorizotnal),
              onPressed: () {
                showFriendModal(context: context);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        width: DeviceSize().getWidth(context),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: buildProfile(),
        ),
      ),
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
            'Welcome to Day To Day with RedDot and I stream every day! Primarily focused on Pokemon, RPGs, and more.',
      ),
      ProfileActionButtons(
          profileAction: ProfileActionOption.IsNotFriend, isViewerPro: false),
      ProfileGamertags(
        gamertagsList: [
          GamertagModel(
              platform: GamertagPlatform.LeagueOfLegends,
              gamertag: 'RedDot224',
              game: GamertagPlatform.LeagueOfLegends)
        ],
        isBlurred: false,
      ),
      SizedBox(
        height: 24,
      ),
      VideoClip(
        username: username,
        profileImageUrl: profileImageUrl,
        tags: ['COD', 'Let\'s GO', 'EZ', 'Clip'],
        isOwner: false,
        previewImageUrl:
            'https://gamespot1.cbsistatic.com/uploads/screen_kubrick/1578/15789366/3581138-3566212-modern%20warfare%20slower%20movement.jpg',
        clipPlatform: ClipPlatform.Youtube,
        videoUrl: 'https://www.youtube.com/watch?v=Y-YY24c_97I',
        videoUid: '1',
      ),
    ];
  }
}
