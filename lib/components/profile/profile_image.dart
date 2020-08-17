import 'package:flutter/material.dart';
import 'package:meta_app/utils/device_size.dart';

class ProfileImage extends StatelessWidget {
  //Constructor
  ProfileImage({@required this.profileImageUrl});

  //Variables
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0, 0),
      children: [
        Center(
          child: Container(
              height: DeviceSize().getWidth(context) * 0.5,
              child: Image.asset('images/profile_image_background.png')),
        ),
        Hero(
          tag: 'profileImage',
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                  height: DeviceSize().getWidth(context) * 0.25,
                  width: DeviceSize().getWidth(context) * 0.25,
                  color: Colors.grey,
                  child: profileImageUrl.trim().length != 0
                      ? Image.network(
                          profileImageUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'images/temp_avatar.png',
                          fit: BoxFit.cover,
                        )),
            ),
          ),
        ),
      ],
    );
  }
}
