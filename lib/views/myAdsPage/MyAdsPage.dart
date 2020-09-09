import 'dart:async';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdsPage/myAdsPageForm.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/blocs/blocs.dart';

class MyAdsPages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPagesState();
}

class MyAdsPagesState extends State<MyAdsPages> {
  List<Ad> listAds = [];
  int navigationBarBottomIndex = 0;
  bool selectedSearchButton;
  FocusNode searchTextFieldFocusNode = FocusNode();
  StreamSubscription<bool> listenKeyboardVisibleOrNots;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onReturnHomePage,
      child: Scaffold(
        body: BlocProvider<MyAdProductBloc>(
          create: (_) {
            selectedSearchButton = false;
            listenKeyboardVisibleOrNots = KeyboardVisibility.onChange.listen(
              (bool showKeyboard) {
                if (mounted) {
                  print(
                      "########################################### visibilyti");
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
            AdRepository adRepository =
                AdRepository(adApiClient: AdApiCLient());
            return MyAdProductBloc(adRepository: adRepository)
              ..add(
                MyAdProducPageStarted(),
              );
          },
          child: BlocListener<MyAdProductBloc, MyAdProductState>(
            listener: (context, state) {
              if (state is ShowMyAdProduct) {
                setState(() => listAds = state.ads);
              } else if (state is FailureMyAdProduct) {
                return Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
            child: MyAdsPageForm(
              listAds: listAds,
            ),
          ),
        ),
        floatingActionButton: selectedSearchButton == true
            ? returnFloatingTextFieldSearch(context)
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  searchAndNavigationFunctionForUserSearch(value) {
    print("pesquisa value");
    print("navega para tela de buscas e exibe resultados");
  }

  navigationToTheAddAdScreen() {
    print("navigation to add ad screen");
  }

  Future<bool> onReturnHomePage() async {
    AppRoutes.duoPop(context);
    return true;
  }

  @override
  void dispose() {
    searchTextFieldFocusNode.dispose();
    listenKeyboardVisibleOrNots.cancel();
    super.dispose();
  }
}
