import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta_app/components/modals/go_pro_modal.dart';
import 'package:meta_app/components/tournaments/recommended_tournament.dart';
import 'package:meta_app/components/tournaments/upcoming_tournament.dart';
import 'package:meta_app/screens/home/search.dart';
import 'package:meta_app/utils/colors.dart';
import 'package:meta_app/utils/device_size.dart';
import 'package:meta_app/utils/enums.dart';
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
    //TabController
    tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    //TabController
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
        title(title: 'Recommended'),
        Padding(
          padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Swiper(
            itemCount: 2,
            itemWidth: DeviceSize().getWidth(context) / 1.12,
            itemHeight: DeviceSize().getHeight(context) / 2,
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return RecommendedTournament(
                  game: GamertagPlatform.ModernWarfare,
                  hasJoined: true,
                  tournamentImageUrl:
                      'https://images.pushsquare.com/c6ada1aae17ca/call-of-duty-modern-warfare-ps4-playstation-4-1.original.jpg',
                  tags: ['Warzone', 'Leaderboard'],
                  timestamp: 'Starts in 5 mins',
                  title: 'Highest kills',
                  tournamentType: TournamentType.Leaderboard,
                );
              }
              return RecommendedTournament(
                game: GamertagPlatform.LeagueOfLegends,
                hasJoined: true,
                tournamentImageUrl:
                    'https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Draven_3.jpg',
                tags: ['League', 'Moba', 'Bracket'],
                timestamp: 'Starts in 5 mins',
                title: '5v5',
                tournamentType: TournamentType.Bracket,
              );
            },
          ),
        ),
        title(title: 'Upcoming'),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return UpcomingTournament(
              isNotified: false,
              game: GamertagPlatform.LeagueOfLegends,
              hasJoined: true,
              tournamentImageUrl:
                  'https://d2skuhm0vrry40.cloudfront.net/2020/articles/2020-08-05-12-27/news-call-of-duty-warzone-season-5-ist-da-und-das-ist-alles-neu-1596626824358.jpg/EG11/resize/1200x-1/news-call-of-duty-warzone-season-5-ist-da-und-das-ist-alles-neu-1596626824358.jpg',
              tags: ['Warzone', 'Solo', 'Leaderboard'],
              timestamp: 'Starts in 20 mins',
              title: '5v5',
              tournamentType: TournamentType.Leaderboard,
            );
          },
        ),
        title(title: 'Winners'),
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
                                style: GoogleFonts.robotoMono(
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

  //Widgets
  Widget title({@required String title}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title ?? '',
        style: GoogleFonts.openSans(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
      ),
    );
  }
}
