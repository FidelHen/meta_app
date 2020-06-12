import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/root/settings/settings.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          'Fidelhen',
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
          children: [
            Stack(
              alignment: Alignment(0, 0),
              children: [
                Center(
                  child: Container(
                      height: DeviceSize().getWidth(context) * 0.5,
                      child:
                          Image.asset('images/profile_image_background.png')),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                        height: DeviceSize().getWidth(context) * 0.25,
                        width: DeviceSize().getWidth(context) * 0.25,
                        color: Colors.grey,
                        child: Image.asset('images/temp_avatar.png')),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: DeviceSize().getWidth(context) / 10,
                  left: DeviceSize().getWidth(context) / 10,
                  top: 25),
              child: Center(
                child: Text(
                  'Stream every day on Twitch! Looking for aggro players on COD, DM me if you’re down!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: DeviceSize().getWidth(context) / 10,
                  left: DeviceSize().getWidth(context) / 10,
                  top: 24),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      fillColor: facebookBlue,
                      child: Container(
                          height: 20,
                          child: Image.asset(
                            'images/facebook_gaming_logo.png',
                          )),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      fillColor: Colors.red,
                      child: Container(
                          height: 20,
                          child: Image.asset(
                            'images/youtube_logo.png',
                          )),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      fillColor: twitchPurple,
                      child: Container(
                          height: 20,
                          child: Image.asset(
                            'images/twitch_logo.png',
                          )),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: RaisedButton(
                    elevation: 0,
                    color: metaLightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {},
                    child: Container(
                      height: 36,
                      width: DeviceSize().getWidth(context) / 3.5,
                      child: Center(
                        child: Text(
                          'Edit profile',
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
                OutlineButton(
                  onPressed: () {},
                  borderSide: BorderSide(color: metaGreen),
                  highlightedBorderColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Container(
                    height: 36,
                    width: DeviceSize().getWidth(context) / 3.5,
                    child: Center(
                      child: Text(
                        'My friends',
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                  height: 80,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: metaLightBlue,
                            borderRadius: BorderRadius.circular(5)),
                        width: DeviceSize().getWidth(context) / 2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 25,
                                  child: Image.asset(
                                    'images/playstation_logo.png',
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Fidelhen',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ]),
                      );
                    },
                    itemCount: 3,
                    loop: false,
                    autoplay: true,
                    autoplayDisableOnInteraction: true,
                    fade: 0.1,
                    viewportFraction: 0.5,
                    scale: 0.9,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://i.pinimg.com/originals/f4/4e/a3/f44ea3c617af231a1ac21eb02189162b.jpg'),
                                      fit: BoxFit.cover),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              trailing: GestureDetector(
                                onTap: () {},
                                child: Icon(EvaIcons.moreVertical,
                                    color: Colors.white),
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      AssetImage('images/temp_avatar.png')),
                              title: Text(
                                'Fidelhen',
                                style: GoogleFonts.sourceCodePro(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Container(
                                  height: 25,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 20,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Container(
                                          height: 25,
                                          constraints:
                                              BoxConstraints(minWidth: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: metaLightBlue),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 0, 8, 0),
                                            child: Center(
                                              child: Text(
                                                Faker().lorem.word(),
                                                style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
