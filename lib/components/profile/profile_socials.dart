import 'package:flutter/material.dart';
import 'package:meta_app/models/social_button_model.dart';
import 'package:meta_app/root/web_view.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';

class ProfileSocials extends StatefulWidget {
  //Constructor
  ProfileSocials(
      {@required this.twitchUrl,
      @required this.fbGamingUrl,
      @required this.youtubeUrl,
      @required this.twitterUrl});

  //Variables
  final String twitchUrl;
  final String fbGamingUrl;
  final String youtubeUrl;
  final String twitterUrl;

  @override
  _ProfileSocialsState createState() => _ProfileSocialsState();
}

class _ProfileSocialsState extends State<ProfileSocials> {
  //Variables
  List<SocialButtonModel> socials = [];

  @override
  void initState() {
    //Functions
    checkSocials();

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
                        social: socials[index].social, url: socials[index].url);
                  }),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
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

  //Functions
  void checkSocials() {
    if (widget.fbGamingUrl != null) {
      socials.add(SocialButtonModel(
          social: SocialMedia.FBGaming, url: widget.fbGamingUrl));
    }
    if (widget.twitchUrl != null) {
      socials.add(
          SocialButtonModel(social: SocialMedia.Twitch, url: widget.twitchUrl));
    }
    if (widget.twitterUrl != null) {
      socials.add(SocialButtonModel(
          social: SocialMedia.Twitter, url: widget.twitterUrl));
    }
    if (widget.youtubeUrl != null) {
      socials.add(SocialButtonModel(
          social: SocialMedia.Youtube, url: widget.youtubeUrl));
    }
  }
}
