import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:meta_app/components/profile/profile_bio.dart';
import 'package:meta_app/components/profile/profile_gamertags.dart';
import 'package:meta_app/components/profile/profile_image_choice.dart';
import 'package:meta_app/components/profile/profile_socials.dart';
import 'package:meta_app/components/video_clip.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:shimmer/shimmer.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class FindFriends extends StatefulWidget {
  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  //Swiper
  SwiperController swiperController;

  //Variables
  String username;
  String profileImageUrl;

  @override
  void initState() {
    //Swiper
    swiperController = SwiperController();
    super.initState();

    //Variables
    username = 'Dead_Eye20';
    profileImageUrl = 'https://source.unsplash.com/1600x900/?gamer';
  }

  @override
  void dispose() {
    //Swiper
    swiperController.dispose();
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
      ),
      body: Swiper(
          onIndexChanged: (value) {
            // if (value == 0) {
            //   setState(() {
            //     text = 'Dead_Eye20';
            //   });
            // } else if (value == 1) {
            //   setState(() {
            //     text = 'RedDot10';
            //   });
            // }
          },
          itemCount: 2,
          scrollDirection: Axis.vertical,
          loop: false,
          controller: swiperController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: metaDarkBlue,
              width: DeviceSize().getWidth(context),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileImageChoice(
                    profileImageUrl: profileImageUrl,
                    swiperController: swiperController,
                  ),
                  ProfileBio(
                      bio:
                          'Stream every day on Twitch! Looking for aggro players on COD, DM me if you’re down!'),
                  ProfileSocials(
                    socalMedias: [],
                  ),
                  ProfileGamertags(
                    gamertagsList: [
                      GamertagModel(
                          platform: GamertagPlatform.LeagueOfLegends,
                          gamertag: 'Dead_Eye20',
                          game: GamertagPlatform.LeagueOfLegends)
                    ],
                    isBlurred: true,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  VideoClip(
                    username: username,
                    profileImageUrl: profileImageUrl,
                    videoUid: '1',
                    tags: ['League', 'Trolling', 'LOL'],
                    isOwner: false,
                    previewImageUrl:
                        'https://img.redbull.com/images/c_crop,x_225,y_0,h_958,w_1437/c_fill,w_1500,h_1000/q_auto,f_auto/redbullcom/2017/10/11/f64b8633-e848-4afa-9791-9da869f7bfd7/league-of-legends-champions',
                    clipPlatform: ClipPlatform.Youtube,
                    videoUrl: 'https://www.youtube.com/watch?v=6LpA7_-Srqg',
                  ),
                ],
              ),
            );
          }),
    );
  }
}
