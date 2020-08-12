import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/get_platform_image.dart';
import 'package:meta_app/utils/text_style.dart';

class ProfileGamertags extends StatefulWidget {
  //Constructor
  ProfileGamertags({@required this.gamertagsList, @required this.isBlurred});

  //Varibles
  final List<GamertagModel> gamertagsList;
  final bool isBlurred;

  @override
  _ProfileGamertagsState createState() => _ProfileGamertagsState();
}

class _ProfileGamertagsState extends State<ProfileGamertags> {
  //Variables
  List<GamertagModel> currentGamertags;
  bool currentlyBlurred;

  @override
  void initState() {
    //Variables
    currentlyBlurred = widget.isBlurred ?? true;

    //Functions
    checkGamertags();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gamertagsList != null) {
      if (widget.gamertagsList.length != 0) {
        return Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Container(
              height: 80,
              child: Swiper(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: metaLightBlue,
                        borderRadius: BorderRadius.circular(5)),
                    width: DeviceSize().getWidth(context) / 2,
                    child: currentlyBlurred
                        ? Column(
                            verticalDirection: VerticalDirection.up,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.gamertagsList[index].gamertag,
                                          style: profileGamertagTextStyle,
                                        ),
                                      ),
                                      BackdropFilter(
                                        filter: ui.ImageFilter.blur(
                                          sigmaX: 3.0,
                                          sigmaY: 3.0,
                                        ),
                                        child: Container(
                                          color: Colors.transparent,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 25,
                                    child: Image.asset(
                                      getPlatformImage(
                                          platform: widget
                                              .gamertagsList[index].platform),
                                    )),
                              ])
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Container(
                                    height: 25,
                                    child: Image.asset(
                                      getPlatformImage(
                                          platform: widget
                                              .gamertagsList[index].platform),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.gamertagsList[index].gamertag,
                                    style: profileGamertagTextStyle,
                                  ),
                                ),
                              ]),
                  );
                },
                itemCount: widget.gamertagsList.length,
                loop: false,
                autoplay: true,
                autoplayDisableOnInteraction: true,
                fade: 0.1,
                viewportFraction: 0.5,
                scale: 0.9,
              )),
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  //Functions
  void checkGamertags() {}
}
