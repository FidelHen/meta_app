import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/loading_progress_indicator.dart';
import 'package:meta_app/components/profile/profile_action_buttons.dart';
import 'package:meta_app/components/profile/profile_bio.dart';
import 'package:meta_app/components/profile/profile_gamertags.dart';
import 'package:meta_app/components/profile/profile_image.dart';
import 'package:meta_app/components/profile/profile_socials.dart';
import 'package:meta_app/components/video_clip.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/models/profile_model.dart';
import 'package:meta_app/models/social_media_model.dart';
import 'package:meta_app/screens/profile/post_clip.dart';
import 'package:meta_app/screens/settings/settings.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';
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
  bool isLoading;
  String username;
  ProfileModel profileData;

  @override
  void initState() {
    //ScrollController
    listScrollController = ScrollController();

    //Varibles
    fabIsHidden = false;
    username = '';
    isLoading = true;

    //Functions
    scrollControllerListener();
    getData();

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
      body: isLoading
          ? Center(child: LoadingProgressIndicator())
          : Container(
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
                    page: PostClip(
                      profileData: profileData,
                      callback: getData,
                    ),
                    context: context,
                    fullScreen: true);
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
        profileImageUrl: profileData.profileImageUrl,
      ),
      ProfileBio(
        bio: profileData.bio ?? '',
      ),
      ProfileSocials(
        socalMedias: profileData.socials,
      ),
      ProfileActionButtons(
        profileAction: ProfileActionOption.IsOwner,
        isViewerPro: false,
        profileData: profileData,
        profileUpdateCallback: getData,
      ),
      ProfileGamertags(
        gamertagsList: profileData.gamertags,
        isBlurred: false,
        isOwner: true,
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
      username = '';
    });
    //Variables & Getting data
    final String uid = await User().getUid();
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
      username = profileData.username;
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
}
