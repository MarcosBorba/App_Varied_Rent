import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:varied_rent/views/myAdsPage/myAdsPageForm.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/blocs/blocs.dart';

//TODO: nivel 4 - depois de criar outras telas, adicionar rotas....
class MyAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageState();
}

class MyAdsPageState extends State<MyAdsPage> {
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
                MyAdsPageStarted(),
              );
          },
          child: BlocListener<MyAdProductBloc, MyAdProductState>(
            listener: (context, state) {
              if (state is FailureMyAdProduct) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  ),
                );
              } else if (state is DeleteMyAdProductSuccess) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ads success deleted!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
            child: MyAdsPageForm(),
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
            width: screenWidth * 0.90,
            height: AppSizes.size50,
            child: TextFieldDefaultAplication(
              hintText: AppTexts().myAdsHintTextSearch,
              textInputAction: TextInputAction.search,
              focusNode: searchTextFieldFocusNode,
              prefixIcon: Icons.search,
              onFieldSubmitted: (value) {
                searchTextFieldFocusNode.unfocus();
                listenKeyboardVisibleOrNots.pause();
                selectedSearchButton = !selectedSearchButton;
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
        label: AppTexts().myAdsOptionInsertAds,
      ),
      FFNavigationBarItem(
        iconData: Icons.search,
        label: AppTexts().myAdsOptionSearch,
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
