import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/message_modal.dart';
import 'package:meta_app/root/profile/friend.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class ProfileListItem extends StatelessWidget {
  //Constructor
  ProfileListItem(
      {@required this.username,
      @required this.isPro,
      @required this.profileImageUrl,
      @required this.isOwner,
      this.isNewMessage});

  //Variables
  final String username;
  final bool isPro;
  final bool isOwner;
  final bool isNewMessage;
  final String profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isNewMessage) {
          showMessageModal(context: context, isNewMessage: true);
        } else {
          if (!isOwner) {
            Navigation()
                .segue(page: Friend(), context: context, fullScreen: false);
          }
        }
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
                    backgroundImage: NetworkImage(profileImageUrl ?? ''),
                  ),
                ),
                Column(
                  children: [usernameText()],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Widget
  Widget usernameText() {
    if (isPro) {
      return Shimmer.fromColors(
        baseColor: metaYellow,
        highlightColor: metaRed,
        child: Text(
          username ?? '',
          style: profileListItemTextStyle,
        ),
      );
    } else {
      return Text(
        username ?? '',
        style: profileListItemTextStyle,
      );
    }
  }
}
