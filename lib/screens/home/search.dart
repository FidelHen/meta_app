import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:meta_app/components/loading_progress_indicator.dart';
import 'package:meta_app/components/profile/profile_list_item.dart';
import 'package:meta_app/models/searchable_user_,model.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
import 'package:meta_app/utils/text_style.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //Variables
  SearchViewState currentSearchState;
  List<SearchableUserModel> usersResulted;

  //TextFields
  TextEditingController searchController;
  FocusNode searchNode;

  @override
  void initState() {
    //Variables
    currentSearchState = SearchViewState.Searching;
    usersResulted = [];

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
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
                      onSubmitted: (value) {
                        getData(query: value);
                      },
                      cursorColor: metaGreen,
                      decoration: InputDecoration(
                        hintText: 'Search users & tags',
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
        body: searchResult(),
      ),
    );
  }

  //Widget
  Widget searchResult() {
    if (currentSearchState == SearchViewState.Searching) {
      return Container();
    } else if (currentSearchState == SearchViewState.Loading) {
      return Center(
        child: LoadingProgressIndicator(),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: ListView.builder(
          itemCount: usersResulted.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ProfileListItem(
                username: usersResulted[index].username,
                uid: usersResulted[index].uid,
                isPro: usersResulted[index].isPro,
                profileImageUrl: usersResulted[index].profileImage,
                isOwner: false);
          },
        ),
      );
    }
  }

  //Functions
  void getData({@required String query}) async {
    if (query.trim() != '') {
      setState(() {
        currentSearchState = SearchViewState.Loading;
      });

      await Firestore.instance
          .collection('usernames')
          .document(query.toLowerCase())
          .get()
          .then((value) {
        usersResulted.add(SearchableUserModel(
            isPro: value.data['is_pro'] ?? false,
            profileImage: value.data['profile_image'],
            uid: value.data['uid'],
            username: value.data['username']));
      });

      setState(() {
        currentSearchState = SearchViewState.Done;
      });
    }
  }
}
