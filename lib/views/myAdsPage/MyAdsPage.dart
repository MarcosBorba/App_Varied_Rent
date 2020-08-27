import 'dart:async';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_api_client.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPagesState();
}

class MyAdsPagesState extends State<MyAdsPages> {
  List<Ad> listAds = [];
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;
  int navigationBarBottomIndex;
  bool selectedSearchButton;
  FocusNode searchTextFieldFocusNode = FocusNode();
  StreamSubscription<bool> listenKeyboardVisibleOrNot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MyAdProductBloc>(
        create: (_) {
          AdRepository adRepository = AdRepository(adApiClient: AdApiCLient());
          selectedSearchButton = false;
          listenKeyboardVisibleOrNot = KeyboardVisibility.onChange.listen(
            (bool showKeyboard) {
              if (mounted) {
                setState(
                  () {
                    showKeyboard == false
                        ? selectedSearchButton = false
                        : selectedSearchButton = true;
                  },
                );
              }
            },
          );
          return MyAdProductBloc(adRepository: adRepository)
            ..add(
              MyAdProducPageStarted(),
            );
        },
        child: BlocListener<MyAdProductBloc, MyAdProductState>(
          listener: (context, state) {
            if (state is ShowMyAdProduct) {
              setState(
                () {
                  listAds = state.ads;
                },
              );
            }
          },
          child: BlocBuilder<MyAdProductBloc, MyAdProductState>(
            builder: (context, state) {
              return Scaffold(
                body: Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: state is LoadingMyAdProduct
                      ? Center(child: CircularProgressIndicator())
                      : listAds.length > 0
                          ? ListView.builder(
                              itemCount: listAds.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: heightBodyScaffold * 0.30,
                                  width: screenWidth,
                                  margin: EdgeInsets.only(top: AppSizes.size10),
                                  child: AdsMaterialButton(
                                    listAds: listAds,
                                    indexListAds: index,
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
                            ),
                ),
                floatingActionButton: selectedSearchButton == true
                    ? returnFloatingTextFieldSearch(context)
                    : null,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: MyAccountPageFFNavigationBar(
                  selectedIndex: navigationBarBottomIndex,
                  onSelectTab: (index) {
                    setState(
                      () {
                        navigationBarBottomIndex = index;
                        index == 0
                            ? navigationToTheAddAdScreen()
                            : index == 1
                                ? setState(() {
                                    selectedSearchButton =
                                        !selectedSearchButton;
                                  })
                                : false;
                      },
                    );
                  },
                  bottomNavyBarItems: listBottomFFNavigationBarItems(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget returnFloatingTextFieldSearch(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            setState(() {
              selectedSearchButton = !selectedSearchButton;
            });
          },
          child: Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.size10,
          child: HomePageSearchTextsField(
            prefixIcon: Icons.search,
            hintText: AppTexts().hintTextSearch,
            focusNode: searchTextFieldFocusNode,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              searchTextFieldFocusNode.unfocus();
              selectedSearchButton = !selectedSearchButton;
              listenKeyboardVisibleOrNot.pause();
              searchAndNavigationFunctionForUserSearch(value);
            },
          ),
        ),
      ],
    );
  }

  searchAndNavigationFunctionForUserSearch(value) {
    print("pesquisa value");
    print("navega para tela de buscas e exibe resultados");
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: FontAwesome5.plus,
        label: "Inserir Ads",
      ),
      FFNavigationBarItem(
        iconData: Icons.search,
        label: "Search",
      ),
    ];
    return fFNavigationBarItem;
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

  navigationToTheAddAdScreen() {
    print("navigation to add ad screen");
  }

  @override
  void dispose() {
    listenKeyboardVisibleOrNot.cancel();
    super.dispose();
  }
}
