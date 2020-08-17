import 'package:flutter/material.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class ProfileBio extends StatelessWidget {
  //Constructor
  ProfileBio({@required this.bio});

  //Variables
  final String bio;

  @override
  Widget build(BuildContext context) {
    return bio.trim().length != 0
        ? Padding(
            padding: EdgeInsets.only(
                right: DeviceSize().getWidth(context) / 10,
                left: DeviceSize().getWidth(context) / 10,
                top: 25),
            child: Center(
              child: Text(
                bio ?? '',
                textAlign: TextAlign.center,
                style: profileBioTextStyle,
              ),
            ),
          )
        : Container();
  }
}
