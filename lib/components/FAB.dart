import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

//Right FAB
Widget rightFAB(
    {@required String title, @required Function onPressed, String tag}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
    child: FloatingActionButton.extended(
      backgroundColor: Colors.white,
      heroTag: tag ?? 'default tag',
      onPressed: onPressed,
      label: Row(children: [
        Padding(
          padding: EdgeInsets.only(right: 4.0),
          child: Text(
            title,
            style: fabButtonTextStyle,
          ),
        ),
        Icon(
          EvaIcons.chevronRight,
          color: Colors.black,
        ),
      ]),
    ),
  );
}

//Extended FAB
Widget extendedFAB(
    {@required BuildContext context,
    @required String title,
    @required Color color,
    @required Function onPressed,
    bool isDark,
    String tag}) {
  TextStyle titleTextStyle;

  if (isDark != null) {
    if (isDark) {
      titleTextStyle = fabButtonTextStyle.copyWith(color: Colors.white);
    } else {
      titleTextStyle = fabButtonTextStyle;
    }
  } else {
    titleTextStyle = fabButtonTextStyle;
  }

  return Padding(
    padding: EdgeInsets.fromLTRB(8, 8, 8, 12),
    child: FloatingActionButton.extended(
      heroTag: tag ?? 'default tag',
      backgroundColor: color,
      onPressed: onPressed,
      label: Container(
        width: DeviceSize().getWidth(context) * 0.7,
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Center(
            child: Text(
              title,
              style: titleTextStyle,
            ),
          ),
        ),
      ),
    ),
  );
}
