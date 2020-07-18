import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_stack/image_stack.dart';
import 'package:meta_app/components/modals/go_pro_modal.dart';
import 'package:meta_app/root/home/search.dart';
import 'package:meta_app/root/tag_view.dart';
import 'package:meta_app/root/tournaments/tournament_preview.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/navigation.dart';
import 'package:meta_app/utils/text_style.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //TabController
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: metaDarkBlue,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: metaDarkBlue,
        title: Text(
          'Home',
          style: appBarTextStyle,
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: IconButton(
            icon: Shimmer.fromColors(
                baseColor: metaYellow,
                highlightColor: metaRed,
                child: Icon(EvaIcons.globe2Outline)),
            onPressed: () {
              showGoProModal(context: context);
            },
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(EvaIcons.search),
              onPressed: () {
                Navigation()
                    .segue(page: Search(), context: context, fullScreen: false);
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView(physics: BouncingScrollPhysics(), children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: metaLightBlue,
                  child: Container(
                      height: 20,
                      child: Image.asset(
                        'images/league_logo.png',
                      )),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: metaLightBlue,
                  child: Container(
                      height: 20,
                      child: Image.asset(
                        'images/cod_mw_logo.png',
                      )),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {},
                  elevation: 0,
                  fillColor: metaLightBlue,
                  child: Container(
                      height: 20,
                      child: Image.asset(
                        'images/fortnite_logo.png',
                      )),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ]),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Reccomended',
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    Navigation().segue(
                        page: TournamentPreview(),
                        context: context,
                        fullScreen: false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.pushsquare.com/c6ada1aae17ca/call-of-duty-modern-warfare-ps4-playstation-4-1.original.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('images/cod_mw_logo.png', scale: 25),
                              ImageStack(
                                imageList: [
                                  'https://images.pexels.com/photos/194511/pexels-photo-194511.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                  'https://images.pexels.com/photos/3165335/pexels-photo-3165335.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                                  'https://images.pexels.com/photos/735911/pexels-photo-735911.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                                ],
                                imageRadius: 40,
                                imageCount: 3,
                                totalCount: 162,
                                backgroundColor: metaDarkBlue,
                                extraCountTextStyle: GoogleFonts.sourceCodePro(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                                imageBorderColor: metaGreen,
                                imageBorderWidth: 2,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54],
                              stops: [0.0, 0.7],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Highest Kills',
                                  style: GoogleFonts.sourceCodePro(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Joined',
                                      style: GoogleFonts.openSans(
                                          color: metaGreen,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      ' • ',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Starts in 5 mins',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Container(
                                    height: 25,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigation().segue(
                                                  page: Tag(),
                                                  context: context,
                                                  fullScreen: false);
                                            },
                                            child: Container(
                                              height: 25,
                                              constraints:
                                                  BoxConstraints(minWidth: 50),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8, 0, 8, 0),
                                                child: Center(
                                                  child: Text(
                                                    'Warzone',
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ),
                );
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Draven_3.jpg'),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('images/league_logo.png', scale: 25),
                          ImageStack(
                            imageList: [
                              'https://images.pexels.com/photos/194511/pexels-photo-194511.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                              'https://images.pexels.com/photos/3165335/pexels-photo-3165335.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                              'https://images.pexels.com/photos/735911/pexels-photo-735911.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                            ],
                            imageRadius: 40,
                            imageCount: 3,
                            totalCount: 90,
                            backgroundColor: metaDarkBlue,
                            extraCountTextStyle: GoogleFonts.sourceCodePro(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            imageBorderColor: metaGreen,
                            imageBorderWidth: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black54],
                          stops: [0.0, 0.7],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5v5',
                              style: GoogleFonts.sourceCodePro(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Solo/Team entry',
                                  style: GoogleFonts.openSans(
                                      color: metaYellow,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  ' • ',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Starts in 2 mins',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Container(
                                height: 25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Container(
                                        height: 25,
                                        constraints:
                                            BoxConstraints(minWidth: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(8, 0, 8, 0),
                                          child: Center(
                                            child: Text(
                                              'Bracket',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              );
            },
            itemCount: 2,
            itemWidth: DeviceSize().getWidth(context),
            itemHeight: DeviceSize().getHeight(context) / 2,
            layout: SwiperLayout.STACK,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Upcoming',
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Container(
                height: DeviceSize().getHeight(context) / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.pcgamesn.com/wp-content/uploads/2020/03/lol_fiddlesticks_new_update_2020.jpg'),
                      fit: BoxFit.cover),
                ),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    height: DeviceSize().getHeight(context) / 3,
                    width: DeviceSize().getWidth(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                        stops: [0.0, 0.8],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset('images/league_logo.png', scale: 25),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(EvaIcons.bellOutline),
                                  onPressed: () {},
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '5v5',
                                style: GoogleFonts.sourceCodePro(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Solo/Team entry',
                                    style: GoogleFonts.openSans(
                                        color: metaYellow,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    ' • ',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Starts in 2 mins',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Container(
                                  height: 25,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Container(
                                          height: 25,
                                          constraints:
                                              BoxConstraints(minWidth: 50),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(8, 0, 8, 0),
                                            child: Center(
                                              child: Text(
                                                'Warzone',
                                                style: GoogleFonts.openSans(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Winners',
            style: GoogleFonts.openSans(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: DeviceSize().getWidth(context),
            height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://static1.millenium.us.org/articles/2/54/42/@/59820-1137234-ahri-15-orig-1-article_m-2.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5)),
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  'https://source.unsplash.com/1600x900/?portrait'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                Faker().internet.userName(),
                                style: GoogleFonts.sourceCodePro(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
        )
      ]),
    );
  }
}
