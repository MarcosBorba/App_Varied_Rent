import 'dart:async';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPageForm extends StatefulWidget {
  List<Ad> listAds = [];
  MyAdsPageForm({Key key, this.listAds}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAdsPageFormState(listAds: listAds);
}

class MyAdsPageFormState extends State<MyAdsPageForm> {
  List<Ad> listAds = [];
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;

  MyAdsPageFormState({this.listAds});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAdProductBloc, MyAdProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            child: state is LoadingMyAdProduct
                ? Center(child: CircularProgressIndicator())
                : state is FailureMyAdProduct
                    ? returnBodyOnFailure()
                    : state is ShowMyAdProduct
                        ? state.ads.length > 0
                            ? ListView.builder(
                                itemCount: state.ads.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: heightBodyScaffold * 0.30,
                                    width: screenWidth,
                                    margin:
                                        EdgeInsets.only(top: AppSizes.size8),
                                    child: AdsMaterialButton(
                                      listAds: state.ads,
                                      indexListAds: index,
                                      elevationButton: AppSizes.size4,
                                      onPressedAds: navigationToTheAdScreen,
                                      onPressedEditAds:
                                          navigationToTheEditAdScreen,
                                      onPressedDeleteAds: deleteTheAd,
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: AppSizes.size12,
                                    right: AppSizes.size12,
                                  ),
                                  child: Text(
                                    "You haven't created any ads yet!",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                        : returnBodyOnFailure(),
          ),
        );
      },
    );
  }

  Widget returnBodyOnFailure() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.size12,
        right: AppSizes.size12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: AppSizes.size50,
          ),
          Text(
            "Internal Server Error",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  navigationToTheAdScreen() {
    print("navigation to ad screen");
  }

  navigationToTheEditAdScreen() {
    print("navigation to edit ad screen");
  }

  deleteTheAd() {
    print("delete the ad e refresh the list");
  }
}
