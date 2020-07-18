import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

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
                      hintText: 'Player',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white70,
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 2) {
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                }),
          )
        ],
      ),
    );
  }
}
