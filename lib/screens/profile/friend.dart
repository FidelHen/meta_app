import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/loading_progress_indicator.dart';
import 'package:meta_app/components/modals/friend_modal.dart';
import 'package:meta_app/components/profile/profile_action_buttons.dart';
import 'package:meta_app/components/profile/profile_bio.dart';
import 'package:meta_app/components/profile/profile_gamertags.dart';
import 'package:meta_app/components/profile/profile_image.dart';
import 'package:meta_app/components/profile/profile_socials.dart';
import 'package:meta_app/components/video_clip.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/models/profile_model.dart';
import 'package:meta_app/models/social_media_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';

class Friend extends StatefulWidget {
  //Constructor
  Friend({@required this.uid, @required this.isPro, @required this.username});

  //Variables
  final String uid;
  final String username;
  final bool isPro;

  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  //Variables
  String username;
  String profileImageUrl;
  bool isLoading;
  ProfileModel profileData;

  @override
  void initState() {
    //Varaibles
    username = widget.username;
    isLoading = true;

    //Functions
    getData();
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
      body: isLoading
          ? Center(
              child: LoadingProgressIndicator(),
            )
          : profileData != null
              ? Container(
                  width: DeviceSize().getWidth(context),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: buildProfile(),
                  ),
                )
              : Container(
                  child: Text('Couldn\'t load user'),
                ),
    );
  }

  //Widget
  List<Widget> buildProfile() {
    return [
      ProfileImage(
        profileImageUrl: profileData.profileImageUrl,
      ),
      ProfileBio(
        bio: profileData.bio ?? '',
      ),
      ProfileSocials(
        socalMedias: profileData.socials,
      ),
      ProfileActionButtons(
        profileAction: ProfileActionOption.IsNotFriend,
        isViewerPro: false,
        profileData: profileData,
        profileUpdateCallback: getData,
      ),
      ProfileGamertags(
        gamertagsList: profileData.gamertags,
        isBlurred: false,
        isOwner: false,
      ),
      SizedBox(
        height: 24,
      ),
      profileData.videoClips.length != 0
          ? ListView.builder(
              itemCount: profileData.videoClips.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final videoData = profileData.videoClips[index];
                return VideoClip(
                  username: videoData.username,
                  profileImageUrl: videoData.profileImageUrl,
                  tags: videoData.tags,
                  thumbnailUrl: videoData.thumbnailUrl,
                  isOwner: videoData.isOwner,
                  clipPlatform: videoData.clipPlatform,
                  videoUid: videoData.videoUid,
                  videoUrl: videoData.videoUrl,
                  deleteCallback: () {
                    setState(() {
                      profileData.videoClips.removeAt(index);
                    });
                  },
                );
              })
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text(
                  'No clips added yet',
                  style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            )
    ];
  }

  //Functions
  void getData() async {
    //Update UI
    setState(() {
      isLoading = true;
    });

    //Variables & Getting data
    final String uid = widget.uid;
    final DocumentSnapshot document = await User().getProfileData(uid: uid);
    final List<GamertagModel> gamertags = await User().getGamertags(uid: uid);
    final List<SocialMediaModel> socials = await User().getSocials(uid: uid);
    List<VideoClip> clips = await User().getClips(
      uid: uid,
      profileImage: document.data['profile_image'],
    );
    // final List<VideoClip> clips =
    final data = document.data;

    //Set profile data
    profileData = ProfileModel(
        bio: data['bio'] ?? '',
        gamertags: [],
        profileImageUrl: data['profile_image'] ?? '',
        socials: [],
        uid: data['uid'],
        username: data['username'] ?? '',
        videoClips: clips);

    //Set gamertags
    gamertags.forEach((element) {
      profileData.gamertags.add(GamertagModel(
          platform: element.platform,
          gamertag: element.gamertag,
          game: element.game));
    });

    //Set socials
    socials.forEach((element) {
      profileData.socials
          .add(SocialMediaModel(platform: element.platform, url: element.url));
    });

    //Update UI
    setState(() {
      isLoading = false;
    });
  }
}
