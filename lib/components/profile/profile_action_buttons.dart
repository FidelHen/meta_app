import 'package:flutter/material.dart';
import 'package:meta_app/components/modals/message_modal.dart';
import 'package:meta_app/components/toast/success_toast.dart';
import 'package:meta_app/components/toast/warning_toast.dart';
import 'package:meta_app/models/profile_model.dart';
import 'package:meta_app/screens/profile/edit_profile.dart';
import 'package:meta_app/screens/profile/friends_list.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:overlay_support/overlay_support.dart';

class ProfileActionButtons extends StatefulWidget {
  //Constructor
  ProfileActionButtons(
      {@required this.profileAction,
      @required this.isViewerPro,
      @required this.profileUpdateCallback,
      @required this.profileData});

  //Variables
  final ProfileActionOption profileAction;
  final bool isViewerPro;
  final ProfileModel profileData;
  final Function profileUpdateCallback;

  @override
  _ProfileActionButtonsState createState() => _ProfileActionButtonsState();
}

class _ProfileActionButtonsState extends State<ProfileActionButtons> {
  //Variables
  ProfileActionOption currentProfileAction;

  @override
  void initState() {
    //Variables
    currentProfileAction = widget.profileAction;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [mainButton(), secondaryButton()]),
    );
  }

  //Widgets
  Widget mainButton() {
    //Variables
    String buttonText;

    //Conditionals
    if (widget.profileAction == ProfileActionOption.IsOwner) {
      buttonText = 'Edit profile';
    } else {
      buttonText = 'Message';
    }

    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: RaisedButton(
        elevation: 0,
        color: metaLightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () {
          if (widget.profileAction == ProfileActionOption.IsOwner) {
            Navigation().segue(
                page: EditProfile(
                  profileData: widget.profileData,
                  callback: widget.profileUpdateCallback,
                ),
                context: context,
                fullScreen: true);
          } else if (widget.profileAction == ProfileActionOption.IsFriend) {
            showMessageModal(context: context);
          } else {
            if (widget.isViewerPro) {
              showMessageModal(context: context);
            } else {
              showOverlayNotification((context) {
                return WarningToast(
                  title: 'Go pro or follow to message',
                );
              });
            }
          }
        },
        child: Container(
          height: 36,
          width: DeviceSize().getWidth(context) / 3.5,
          child: Center(
            child: Text(
              buttonText,
              style: profileActionButtonTextStlye,
            ),
          ),
        ),
      ),
    );
  }

  Widget secondaryButton() {
    //Variables
    String buttonText;
    Color borderColor;

    //Conditionals
    if (currentProfileAction == ProfileActionOption.IsOwner) {
      buttonText = 'My friends';
      borderColor = Colors.white;
    } else if (currentProfileAction == ProfileActionOption.IsFriend) {
      buttonText = 'Following';
      borderColor = metaGreen;
    } else if (currentProfileAction == ProfileActionOption.IsNotFriend) {
      buttonText = 'Follow';
      borderColor = metaYellow;
    } else if (currentProfileAction == ProfileActionOption.IsRequested) {
      buttonText = 'Requested';
      borderColor = Colors.white;
    }

    return OutlineButton(
      onPressed: () {
        if (currentProfileAction == ProfileActionOption.IsOwner) {
          Navigation()
              .segue(page: FriendsList(), context: context, fullScreen: false);
        } else if (currentProfileAction == ProfileActionOption.IsFriend) {
          showOverlayNotification((context) {
            return SuccessToast(
              title: 'Friend removed',
            );
          });
          setState(() {
            currentProfileAction = ProfileActionOption.IsNotFriend;
          });
        } else if (currentProfileAction == ProfileActionOption.IsNotFriend) {
          showOverlayNotification((context) {
            return SuccessToast(
              title: 'Friend request sent',
            );
          });
          setState(() {
            currentProfileAction = ProfileActionOption.IsRequested;
          });
        }
      },
      borderSide: BorderSide(color: borderColor),
      highlightedBorderColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: 36,
        width: DeviceSize().getWidth(context) / 3.5,
        child: Center(
          child: Text(
            buttonText,
            style: profileActionButtonTextStlye,
          ),
        ),
      ),
    );
  }
}
