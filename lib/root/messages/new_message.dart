import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/profile/profile_list_item.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.chevronDown,
            color: Colors.white,
            size: 40,
          ),
        ),
        title: Text(
          'New message',
          style: appBarTextStyle,
        ),
        backgroundColor: metaDarkBlue,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'To:',
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: textFieldTextStyle,
                    autofocus: true,
                    enableSuggestions: false,
                    decoration: new InputDecoration(
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                      hintText: 'Friend',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white70,
            height: 2,
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                if (index == 2) {
                  return ProfileListItem(
                      username: Faker().internet.userName(),
                      isPro: true,
                      profileImageUrl:
                          'https://source.unsplash.com/1600x900/?gamer',
                      isNewMessage: true,
                      isOwner: false);
                } else {
                  return ProfileListItem(
                      username: Faker().internet.userName(),
                      isPro: false,
                      isNewMessage: true,
                      profileImageUrl:
                          'https://source.unsplash.com/1600x900/?avatar',
                      isOwner: false);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
