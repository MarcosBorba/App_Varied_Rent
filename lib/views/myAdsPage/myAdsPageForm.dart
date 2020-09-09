import 'dart:async';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageFormState();
}

class MyAdsPageFormState extends State<MyAdsPageForm> {
  List<Ad> listAds = [];
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;
  int navigationBarBottomIndex = 0;
  bool selectedSearchButton;
  FocusNode searchTextFieldFocusNode = FocusNode();
  StreamSubscription<bool> listenKeyboardVisibleOrNots;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAdProductBloc, MyAdProductState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: funcaoVoltarHomePage,
          child: Scaffold(
            body: Container(
              height: screenHeight,
              width: screenWidth,
              child: state is LoadingMyAdProduct
                  ? Center(child: CircularProgressIndicator())
                  : state is FailureMyAdProduct
                      ? Padding(
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
                        )
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
            bottomNavigationBar: BottomNavigationBarDefault(
              selectedIndex: navigationBarBottomIndex,
              onSelectTabItem: (index) {
                setState(
                  () {
                    navigationBarBottomIndex = index;
                    index == 0
                        ? navigationToTheAddAdScreen()
                        : index == 1
                            ? setState(() {
                                selectedSearchButton = !selectedSearchButton;
                              })
                            : false;
                  },
                );
              },
              bottomNavigationBarItems: listBottomFFNavigationBarItems(),
            ),
          ),
        );
      },
    );
  }

  Future<bool> funcaoVoltarHomePage() async {
    AppRoutes.duoPop(context);
    return true;
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
          child: Container(
            alignment: AlignmentDirectional.center,
            height: AppSizes.size50,
            width: screenWidth * 0.90,
            child: TextFieldDefaultAplication(
              prefixIcon: Icons.search,
              hintText: AppTexts().hintTextSearch,
              focusNode: searchTextFieldFocusNode,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (value) {
                searchTextFieldFocusNode.unfocus();
                selectedSearchButton = !selectedSearchButton;
                listenKeyboardVisibleOrNots.pause();
                searchAndNavigationFunctionForUserSearch(value);
              },
            ),
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
    searchTextFieldFocusNode.dispose();
    listenKeyboardVisibleOrNots.cancel();
    super.dispose();
  }
}
