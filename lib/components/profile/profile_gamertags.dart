import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/gamertag_game_modal.dart';
import 'package:meta_app/components/modals/gamertag_modal.dart';
import 'package:meta_app/components/modals/gamertag_platform_modal.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/models/gamertag_model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:meta_app/utils/user.dart';
import 'package:overlay_support/overlay_support.dart';

class ProfileGamertags extends StatefulWidget {
  //Constructor
  ProfileGamertags({
    @required this.gamertagsList,
    @required this.isBlurred,
    @required this.isOwner,
  });

  //Varibles
  final List<GamertagModel> gamertagsList;
  final bool isBlurred;
  final bool isOwner;

  @override
  _ProfileGamertagsState createState() => _ProfileGamertagsState();
}

class _ProfileGamertagsState extends State<ProfileGamertags> {
  //Variables
  List<GamertagModel> currentGamertags = [];
  bool currentlyBlurred;

  @override
  void initState() {
    //Variables
    currentlyBlurred = widget.isBlurred ?? true;
    currentGamertags = widget.gamertagsList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return currentGamertags.length == 0
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Container(
                height: 80,
                child: Swiper(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    if (currentGamertags.length + 1 == index + 1) {
                      return GestureDetector(
                        onTap: () {
                          showGamertagGameModal(
                              context: context, callback: addGamertag);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: metaLightBlue,
                              borderRadius: BorderRadius.circular(5)),
                          width: DeviceSize().getWidth(context) / 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  EvaIcons.plus,
                                  color: Colors.white,
                                )
                              ]),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        showModal(
                            context: context,
                            index: index,
                            game: currentGamertags[index].game);
                      },
                      child: Container(
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
                                              currentGamertags[index].gamertag,
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
                                              platform:
                                                  currentGamertags[index].game),
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
                                              platform:
                                                  currentGamertags[index].game),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        currentGamertags[index].gamertag,
                                        style: profileGamertagTextStyle,
                                      ),
                                    ),
                                  ]),
                      ),
                    );
                  },
                  itemCount: widget.isOwner
                      ? currentGamertags.length + 1
                      : currentGamertags.length,
                  loop: false,
                  autoplay: true,
                  autoplayDisableOnInteraction: true,
                  fade: 0.1,
                  viewportFraction: 0.5,
                  scale: 0.9,
                )),
          );
  }

  //Functions
  void addGamertag(
      {@required GamertagPlatform game,
      @required String gamertag,
      @required GamertagPlatform platform}) async {
    //Variables
    final String uid = await User().getUid();
    int indexToDelete;

    //Set data
    await Firestore.instance
        .collection('users')
        .document(uid)
        .collection('gamertags')
        .document(game.toString())
        .setData({
      'gamertag': gamertag.trim(),
      'game': game.toString(),
      'platform': platform.toString(),
    });

    showOverlayNotification((context) {
      return SuccessToast(
        title: 'Added gamertag',
      );
    });

    currentGamertags.asMap().forEach((index, element) {
      if (element.game == game) {
        indexToDelete = index;
      }
    });

    //Update UI
    setState(() {
      currentGamertags.removeAt(indexToDelete);
      currentGamertags.add(
          GamertagModel(gamertag: gamertag, platform: platform, game: game));
    });
  }

  //Modal
  void showModal(
      {@required context,
      @required int index,
      @required GamertagPlatform game}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: metaLightBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                    right: DeviceSize().getWidth(context) * 0.02,
                    left: DeviceSize().getWidth(context) * 0.02,
                    top: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        color: metaLightBlue,
                        width: DeviceSize().getWidth(context),
                        child: FlatButton(
                          onPressed: () async {
                            Navigator.pop(context);

                            if (game == GamertagPlatform.ModernWarfare) {
                              showGamertagPlatformModal(
                                  context: context,
                                  game: GamertagPlatform.ModernWarfare,
                                  callback: addGamertag);
                            } else if (game ==
                                GamertagPlatform.LeagueOfLegends) {
                              showGamertagModal(
                                  context: context,
                                  game: GamertagPlatform.LeagueOfLegends,
                                  callback: addGamertag,
                                  platform: GamertagPlatform.LeagueOfLegends);
                            } else if (game == GamertagPlatform.Fortnite) {
                              showGamertagPlatformModal(
                                  context: context,
                                  game: GamertagPlatform.Fortnite,
                                  callback: addGamertag);
                            }
                          },
                          child: Container(
                              height: 65,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      EvaIcons.edit2Outline,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        color: metaLightBlue,
                        width: DeviceSize().getWidth(context),
                        child: FlatButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            final String uid = await User().getUid();

                            await Firestore.instance
                                .collection('users')
                                .document(uid)
                                .collection('gamertags')
                                .document(game.toString())
                                .delete();

                            showOverlayNotification((context) {
                              return SuccessToast(
                                title: 'Deleted gamertag',
                              );
                            });

                            setState(() {
                              currentGamertags.removeAt(index);
                            });
                          },
                          child: Container(
                              height: 65,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      EvaIcons.trash2Outline,
                                      color: metaRed,
                                    ),
                                  ),
                                  Text(
                                    'Delete',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
