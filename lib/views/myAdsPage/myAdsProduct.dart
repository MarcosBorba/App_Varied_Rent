import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageState();
}

class MyAdsPageState extends State<MyAdsPage> {
  int navigationBarBottomIndex = 0;
  final List<String> images = [
    'https://cdn.pixabay.com/photo/2020/05/15/11/49/pet-5173354_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/07/01/16/59/cherries-5360265_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/07/09/10/31/sea-5386810_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/14/17/17/kyrgyzstan-4765706_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/03/06/22/10/zakynthos-4908247_960_720.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.04,
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                ),
                child: Text(
                  "Viagens para lua de mel - EUA, MEX, BRA, FRA, CHI",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppFontSize.s18,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.40,
                width: screenWidth,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                  itemCount: images.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: new SwiperPagination(),
                  layout: SwiperLayout.DEFAULT,
                  itemWidth: screenWidth,
                  itemHeight: screenHeight * 0.40,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.04,
                  bottom: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "\$\$\$\$",
                      style: TextStyle(
                        fontSize: AppFontSize.s29,
                      ),
                    ),
                    SmoothStarRating(
                      rating: 4.0,
                      isReadOnly: false,
                      size: 40,
                      filledIconData: Icons.star,
                      halfFilledIconData: Icons.star_half,
                      defaultIconData: Icons.star_border,
                      starCount: 5,
                      allowHalfRating: true,
                      spacing: 2.0,
                      color: Colors.yellow,
                      borderColor: Colors.black,
                      onRated: (value) {
                        print("rating value -> $value");
                        print("rating value dd -> ${value.truncate()}");
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyAccountPageFFNavigationBar(
        selectedIndex: navigationBarBottomIndex,
        onSelectTab: (index) {
          setState(
            () {
              navigationBarBottomIndex = index;
              index == 0
                  ? print("1")
                  : index == 1
                      ? print("2")
                      : index == 2
                          ? print("3")
                          : index == 3 ? print("4") : false;
            },
          );
        },
        bottomNavyBarItems: listBottomFFNavigationBarItems(),
      ),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.close,
        label: "option",
      ),
      FFNavigationBarItem(
        iconData: Icons.close,
        label: "option",
      ),
      FFNavigationBarItem(
        iconData: Icons.close,
        label: "option",
      ),
      FFNavigationBarItem(
        iconData: Icons.close,
        label: "option",
      ),
    ];
    return fFNavigationBarItem;
  }
}
