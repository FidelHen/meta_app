import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/messages/messages_preview_tile.dart';
import 'package:meta_app/screens/messages/new_message.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class MessagesPreview extends StatefulWidget {
  @override
  _MessagesPreviewState createState() => _MessagesPreviewState();
}

class _MessagesPreviewState extends State<MessagesPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          'Messages',
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
              icon: Icon(EvaIcons.edit2Outline),
              onPressed: () {
                Navigation().segue(
                    page: NewMessage(), context: context, fullScreen: true);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          MessagesPreviewTile(
              message: Faker().lorem.sentence(),
              opened: false,
              profileImageUrl: 'https://source.unsplash.com/1600x900/?avatar',
              timestamp: 'now',
              username: Faker().internet.userName()),
          MessagesPreviewTile(
              message: Faker().lorem.sentence(),
              opened: false,
              profileImageUrl: 'https://source.unsplash.com/1600x900/?gamer',
              timestamp: '1 hr',
              username: Faker().internet.userName()),
          MessagesPreviewTile(
              message: Faker().lorem.sentence(),
              opened: true,
              profileImageUrl: 'https://source.unsplash.com/1600x900/?lady',
              timestamp: '3 d',
              username: Faker().internet.userName()),
        ],
      ),
    );
  }
}
