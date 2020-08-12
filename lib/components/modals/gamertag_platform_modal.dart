import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/gamertag_modal.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/get_platform_image.dart';

void showGamertagPlatformModal(
    {@required context,
    @required GamertagPlatform game,
    @required Function callback}) {
  //Variables
  List<GamertagPlatform> platformImages = [];

  //Conditionals
  if (game == GamertagPlatform.ModernWarfare) {
    platformImages = [
      GamertagPlatform.PC,
      GamertagPlatform.PS4,
      GamertagPlatform.Xbox,
    ];
  } else if (game == GamertagPlatform.Fortnite) {
    platformImages = [
      GamertagPlatform.PC,
      GamertagPlatform.PS4,
      GamertagPlatform.Xbox,
      GamertagPlatform.Switch,
      GamertagPlatform.Mobile,
      GamertagPlatform.Mac
    ];
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
                      itemCount: platformImages.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 8,
                          ),
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              showGamertagModal(
                                  context: context,
                                  game: game,
                                  callback: callback,
                                  platform: platformImages[index]);
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
                                        platform: platformImages[index]),
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
