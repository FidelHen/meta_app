import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

void inviteModal({@required context}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: (DeviceSize().getHeight(context) * .42) +
              MediaQuery.of(context).viewInsets.bottom,
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
                top: 10,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(22, 12, 22, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            width: DeviceSize().getWidth(context),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.15),
                            ),
                            child: TextField(
                              autofocus: true,
                              style: textFieldTextStyle,
                              // controller: searchController,
                              // focusNode: searchNode,
                              onSubmitted: (value) {},
                              cursorColor: metaGreen,
                              decoration: InputDecoration(
                                hintText: 'Search friends',
                                hintStyle: textFieldTextStyle.copyWith(
                                    color: Colors.white70),
                                icon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                  child: Icon(
                                    EvaIcons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: GridView.builder(
                          itemCount: 6,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/4401993/pexels-photo-4401993.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    Faker().internet.userName(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
          ),
        );
      });
}
