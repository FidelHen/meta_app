import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/root/profile/friend.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

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
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 2) {
            return GestureDetector(
              onTap: () {
                Navigation()
                    .segue(page: Friend(), context: context, fullScreen: false);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: metaLightBlue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://source.unsplash.com/1600x900/?person'),
                          ),
                        ),
                        Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: metaYellow,
                              highlightColor: metaRed,
                              child: Text(
                                Faker().internet.userName(),
                                style: GoogleFonts.sourceCodePro(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                Navigation()
                    .segue(page: Friend(), context: context, fullScreen: false);
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: metaLightBlue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://source.unsplash.com/1600x900/?person'),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              Faker().internet.userName(),
                              style: GoogleFonts.sourceCodePro(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
