import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/profile/profile_list_item.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.chevronLeft,
            color: Colors.white,
            size: 40,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          'Friends',
          style: appBarTextStyle,
        ),
      ),
      backgroundColor: metaDarkBlue,
      body: ListView.builder(
        itemCount: 10,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 2) {
            return ProfileListItem(
                username: Faker().internet.userName(),
                isPro: true,
                profileImageUrl: 'https://source.unsplash.com/1600x900/?person',
                isOwner: false);
          } else {
            return ProfileListItem(
                username: Faker().internet.userName(),
                isPro: false,
                profileImageUrl: 'https://source.unsplash.com/1600x900/?person',
                isOwner: false);
          }
        },
      ),
    );
  }
}
