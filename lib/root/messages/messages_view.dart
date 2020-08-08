import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/messages/messages_tile.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';

class MessagesView extends StatefulWidget {
  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: metaDarkBlue,
        elevation: 0,
        title: Text(
          Faker().internet.userName(),
          style: appBarTextStyle,
        ),
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
      ),
      backgroundColor: metaDarkBlue,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              reverse: true,
              shrinkWrap: true,
              children: <Widget>[
                MessageTile(
                  message: Faker().lorem.sentence(),
                  isOwner: true,
                  previouslyMessaged: true,
                  profileImageUrl:
                      'https://source.unsplash.com/1600x900/?portrait',
                  timestamp: 'now',
                ),
                MessageTile(
                  message: Faker().lorem.sentence(),
                  isOwner: true,
                  previouslyMessaged: true,
                  profileImageUrl:
                      'https://source.unsplash.com/1600x900/?portrait',
                  timestamp: 'now',
                ),
                MessageTile(
                  message: Faker().lorem.sentence(),
                  isOwner: true,
                  previouslyMessaged: false,
                  profileImageUrl:
                      'https://source.unsplash.com/1600x900/?portrait',
                  timestamp: 'now',
                ),
                MessageTile(
                  message: Faker().lorem.sentence(),
                  isOwner: false,
                  previouslyMessaged: true,
                  profileImageUrl:
                      'https://source.unsplash.com/1600x900/?avatar',
                  timestamp: 'now',
                ),
                MessageTile(
                  message: Faker().lorem.sentence(),
                  isOwner: false,
                  previouslyMessaged: false,
                  profileImageUrl:
                      'https://source.unsplash.com/1600x900/?avatar',
                  timestamp: 'now',
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: metaLightBlue,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 10.0, left: 10.0, top: 0, bottom: 0),
                        child: TextField(
                          style: textFieldTextStyle,
                          onSubmitted: (value) {},
                          cursorColor: metaGreen,
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            hintStyle: textFieldTextStyle.copyWith(
                                color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      highlightColor: Colors.transparent,
                      icon: Icon(EvaIcons.paperPlaneOutline, color: metaGreen),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
