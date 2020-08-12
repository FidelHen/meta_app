import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';

void showMediaModal({@required context, @required Function callback}) {
  final picker = ImagePicker();

  //Functions
  Future getImage({@required ImageSource source}) async {
    var image = await picker.getImage(source: source, imageQuality: 50);

    callback(image: File(image.path));
  }

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
                          await getImage(source: ImageSource.gallery);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    EvaIcons.image,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Library',
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
                          await getImage(source: ImageSource.camera);
                        },
                        child: Container(
                            height: 65,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 12.0),
                                  child: Icon(
                                    EvaIcons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Camera',
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
