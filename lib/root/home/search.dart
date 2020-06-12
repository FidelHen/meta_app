import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/text_style.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //TextFields
  TextEditingController searchController;
  FocusNode searchNode;

  @override
  void initState() {
    //TextFields
    searchController = TextEditingController();
    searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    //TextFields
    searchController.dispose();
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: metaDarkBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Container(
                  width: DeviceSize().getWidth(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: metaLightBlue,
                  ),
                  child: TextField(
                    autofocus: true,
                    style: textFieldTextStyle,
                    controller: searchController,
                    focusNode: searchNode,
                    onSubmitted: (value) {},
                    cursorColor: metaGreen,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle:
                          textFieldTextStyle.copyWith(color: Colors.white70),
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
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
          elevation: 0,
        ),
        backgroundColor: metaDarkBlue,
      ),
    );
  }
}
