import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/gamertag_modal.dart';
import 'package:meta_app/components/modals/gamertag_platform_modal.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';

void showGamertagGameModal({@required context, @required Function callback}) {
  //Variables
  List<GamertagPlatform> gameImages = [
    GamertagPlatform.ModernWarfare,
    GamertagPlatform.LeagueOfLegends,
    GamertagPlatform.Fortnite
  ];

  //Function
  void showAssignedPlatformModal({@required int index}) {
    Navigator.pop(context);
    if (index == 0) {
      showGamertagPlatformModal(
          context: context,
          game: GamertagPlatform.ModernWarfare,
          callback: callback);
    } else if (index == 1) {
      showGamertagModal(
          context: context,
          game: GamertagPlatform.LeagueOfLegends,
          callback: callback,
          platform: GamertagPlatform.LeagueOfLegends);
    } else if (index == 2) {
      showGamertagPlatformModal(
          context: context,
          game: GamertagPlatform.Fortnite,
          callback: callback);
    }
  }

  //Modals
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 100 + MediaQuery.of(context).viewInsets.bottom,
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
                top: 10,
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: RawMaterialButton(
                            onPressed: () {
                              showAssignedPlatformModal(index: index);
                            },
                            fillColor: Colors.white,
                            shape: CircleBorder(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  child: Image.asset(
                                    getPlatformImage(
                                        platform: gameImages[index]),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      });
}
