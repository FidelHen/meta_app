import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:meta_app/utils/device_size.dart';

class ProfileImageChoice extends StatelessWidget {
  //Constructor
  ProfileImageChoice(
      {@required this.profileImageUrl, @required this.swiperController});

  //Variables
  final String profileImageUrl;
  final SwiperController swiperController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              swiperController.next();
            },
            child: Image.asset(
              'images/nay.png',
              height: DeviceSize().getWidth(context) * 0.2,
            ),
          ),
          Stack(
            alignment: Alignment(0, 0),
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                      height: DeviceSize().getWidth(context) * 0.25,
                      width: DeviceSize().getWidth(context) * 0.25,
                      color: Colors.grey,
                      child: profileImageUrl != null
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
            ],
          ),
          Image.asset(
            'images/yay.png',
            height: DeviceSize().getWidth(context) * 0.2,
          ),
        ],
      ),
    );
  }
}
