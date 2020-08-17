import 'package:flutter/material.dart';
import 'package:meta_app/models/social_media_model.dart';
import 'package:meta_app/screens/web_view.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';

class ProfileSocials extends StatefulWidget {
  //Constructor
  ProfileSocials({
    @required this.socalMedias,
  });

  //Variables
  final List<SocialMediaModel> socalMedias;

  @override
  _ProfileSocialsState createState() => _ProfileSocialsState();
}

class _ProfileSocialsState extends State<ProfileSocials> {
  //Variables
  List<SocialMediaModel> socials = [];
  @override
  void initState() {
    //Functions
    validateSocialLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (socials.length != 0) {
      return Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: socials.length,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return socialButton(
                        social: socials[index].platform,
                        url: socials[index].url);
                  }),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  //Functions
  void validateSocialLinks() {
    widget.socalMedias.forEach((element) {
      //Variables
      final SocialMedia platform = element.platform;
      final String url = element.url;

      //Conditionals
      if (platform == SocialMedia.Youtube && url != '') {
        socials.add(SocialMediaModel(platform: platform, url: url));
      } else if (platform == SocialMedia.FBGaming &&
          url != 'https://www.facebook.com/gaming/') {
        socials.add(SocialMediaModel(platform: platform, url: url));
      } else if (platform == SocialMedia.Twitch &&
          url != 'https://www.twitch.tv/') {
        socials.add(SocialMediaModel(platform: platform, url: url));
      } else if (platform == SocialMedia.Twitter &&
          url != 'https://twitter.com/') {
        socials.add(SocialMediaModel(platform: platform, url: url));
      }
    });
  }

  //Widgets
  Widget socialButton({@required String url, @required SocialMedia social}) {
    //Variables
    String title;
    String image;
    Color color;

    //Conditionals
    if (social == SocialMedia.Twitch) {
      title = 'Twitch';
      color = twitchPurple;
      image = 'images/twitch_logo.png';
    } else if (social == SocialMedia.Twitter) {
      title = 'Twitter';
      color = twitterBlue;
      image = 'images/twitter_logo.png';
    } else if (social == SocialMedia.Youtube) {
      title = 'Youtube';
      color = youtubeRed;
      image = 'images/youtube_logo.png';
    } else if (social == SocialMedia.FBGaming) {
      title = 'Facebook Gaming';
      color = facebookBlue;
      image = 'images/facebook_gaming_logo.png';
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        width: 50,
        child: RawMaterialButton(
          onPressed: () {
            Navigation().segue(
                page: WebView(
                  title: title ?? '',
                  url: url,
                ),
                context: context,
                fullScreen: false);
          },
          elevation: 0,
          fillColor: color ?? Colors.white,
          child: Container(
            height: 20,
            child: Image.asset(
              image ?? '',
            ),
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
