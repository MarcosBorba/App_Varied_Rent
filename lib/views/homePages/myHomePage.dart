import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:fluttericon/linecons_icons.dart';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';

import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';
import 'package:varied_rent/components/components.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:varied_rent/main.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAccountPage/myAccountPage.dart';

//TODO: nivel - 4 depois de criar outras telas, adicionar a navegacao de cada uma

//rotas a serem atualizadas depois de criar outras telas:
//todas categorias
//chat
//buscas - colocar controller para pesquisa
//meus anuncios
//favoritos

//no logado:
//categorias devem continuar com suas rotas igual do visitante - ok
//chat deve ter rota disponivel - ok
//pesquisa deve continuar igual do visitante - ok
//menu deve ter opcoes de logado habilitadas e de visitante desabilitadas - ok

//no visitante:
//categorias devem continuar com suas rotas igual do logado - ok
//chat nao deve ser disponivel - ok
//pesquisa deve continuar igual do logado - ok
//menu deve ter opcoes de logado desabilitadas - ok

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int navigationBarBottomIndex = 0;
  bool selectedSearchButton;
  FocusNode searchTextFieldFocusNode = FocusNode();
  bool stateAuthentication;
  StreamSubscription<bool> listenKeyboardVisibleOrNot;

  @override
  void initState() {
    super.initState();
    selectedSearchButton = false;
    stateAuthentication =
        BlocProvider.of<AuthenticationBloc>(context).state.toString() ==
            "AuthenticationAuthenticated";
    listenKeyboardVisibleOrNot =
        KeyboardVisibility.onChange.listen((bool showKeyboard) {
      print(
          "###########################################################################passou visibility 1");
      if (mounted) {
        setState(() {
          print(
              "###########################################################################passou visibility 2");
          showKeyboard == false
              ? selectedSearchButton = false
              : selectedSearchButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            returnsNavigationButtonForAllCategories(),
            returnsNavigationButtonForVehicleCategory(),
            returnsNavigationButtonToCommunicationCategory(),
            returnsNavigationButtonForRealEstateCategory(),
            returnsNavigationButtonForMobileHomeCategory(),
            returnsNavigationButtonForAnimalsCategory(),
            returnsNavigationButtonForClothingCategory(),
            returnsNavigationButtonForServicesCategory(),
            returnsNavigationButtonForMachinesCategory(),
            returnsNavigationButtonForToysCategory(),
          ],
        ),
        floatingActionButton: selectedSearchButton == true
            ? returnFloatingTextFieldSearch(context)
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: HomePageFFNavigationBar(
          selectedIndex: navigationBarBottomIndex,
          onSelectTab: (index) {
            setState(() {
              navigationBarBottomIndex = index;
              index == 0
                  ? showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => openBottomDrawer())
                  : index == 1
                      ? setState(() {
                          selectedSearchButton = !selectedSearchButton;
                        })
                      : index == 2 ? navigateToConversationScreen() : false;
            });
          },
          bottomNavyBarItems: listBottomFFNavigationBarItems(),
        ));
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.menu,
        label: AppTexts().textSubtitleMenuIconBottomNavigationBar,
      ),
      FFNavigationBarItem(
        iconData: Icons.search,
        label: AppTexts().textSubtitleSearchIconBottomNavigationBar,
      ),
    ];
    stateAuthentication == true
        ? fFNavigationBarItem.add(FFNavigationBarItem(
            iconData: Icons.chat,
            label: AppTexts().textSubtitleChatIconBottomNavigationBar,
          ))
        : null;
    return fFNavigationBarItem;
  }

  Widget returnsNavigationButtonForAllCategories() {
    return HomePageMaterialButtonsCategories(
      onPressed: searchAndNavigationFunctionForScreenWithAdsFromAllCategories,
      icon: Icons.list,
      subTitle: AppTexts().categoryTextAllCategories,
    );
  }

  Widget returnsNavigationButtonForVehicleCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromTheVehiclesCategory(),
      icon: Icons.directions_car,
      subTitle: AppTexts().categoryTextVehicle,
    );
  }

  Widget returnsNavigationButtonToCommunicationCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromCommunicationCategory(),
      icon: FontAwesome5.mobile,
      subTitle: AppTexts().categoryTextCommunication,
    );
  }

  Widget returnsNavigationButtonForRealEstateCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromRealEstateCategory(),
      icon: Iconic.home,
      subTitle: AppTexts().categoryTextRealEstate,
    );
  }

  Widget returnsNavigationButtonForMobileHomeCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromFurnitureCategory(),
      icon: FontAwesome5.chair,
      subTitle: AppTexts().categoryTextHomeFurniture,
    );
  }

  Widget returnsNavigationButtonForAnimalsCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromAnimalsCategory(),
      icon: FontAwesome5.paw,
      subTitle: AppTexts().categoryTextAnimals,
    );
  }

  Widget returnsNavigationButtonForClothingCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromCLothingCategory(),
      icon: Linecons.t_shirt,
      subTitle: AppTexts().categoryTextClothing,
    );
  }

  Widget returnsNavigationButtonForServicesCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromServicesCategory(),
      icon: FontAwesome5.user_tie,
      subTitle: AppTexts().categoryTextServices,
    );
  }

  Widget returnsNavigationButtonForMachinesCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromMachineCategory(),
      icon: Elusive.cogs,
      subTitle: AppTexts().categoryTextMachine,
    );
  }

  Widget returnsNavigationButtonForToysCategory() {
    return HomePageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithAdsFromToysCategory(),
      icon: FontAwesome5.basketball_ball,
      subTitle: AppTexts().categoryTextToys,
    );
  }

  searchAndNavigationFunctionForScreenWithAdsFromAllCategories() {
    print("pesquisa anuncios de todas categorias");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromTheVehiclesCategory() {
    print("pesquisa anuncios da categoria veiculos");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromCommunicationCategory() {
    print("pesquisa anuncios da categoria comunicacao");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromRealEstateCategory() {
    print("pesquisa anuncios da categoria imovel");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromFurnitureCategory() {
    print("pesquisa anuncios da categoria mobilia");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromAnimalsCategory() {
    print("pesquisa anuncios da categoria animais");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromCLothingCategory() {
    print("pesquisa anuncios da categoria roupas");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromServicesCategory() {
    print("pesquisa anuncios da categoria servicos");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromMachineCategory() {
    print("pesquisa anuncios da categoria maquina");
    print("navega para tela de buscas e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithAdsFromToysCategory() {
    print("pesquisa anuncios da categoria brinquedos");
    print("navega para tela de buscas e exibe resultados");
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

  Widget openBottomDrawer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        HomePageMenuListTiles(
          icon: FontAwesome5.home,
          iconColor: AppColors.iconColorOptionHomeOfModalBottomSheet,
          title: Text(AppTexts().optionTextHomeOfModalBottomSheet),
          onTap: navigationFunctionForTheHomePage,
        ),
        stateAuthentication == true
            ? Column(
                children: <Widget>[
                  HomePageMenuListTiles(
                    icon: FontAwesome5.user,
                    iconColor:
                        AppColors.iconColorOptionMyAccountOfModalBottomSheet,
                    title:
                        Text(AppTexts().optionTextMyAccountOfModalBottomSheet),
                    onTap: navigationFunctionForMyAccountScreen,
                  ),
                  HomePageMenuListTiles(
                    icon: FontAwesome.tags,
                    iconColor: AppColors.iconColorOptionMyAdsOfModalBottomSheet,
                    title: Text(AppTexts().optionTextMyAdsOfModalBottomSheet),
                    onTap: navigationFunctionForMyAdsScreen,
                  ),
                  HomePageMenuListTiles(
                    icon: Icons.favorite,
                    iconColor:
                        AppColors.iconColorOptionFavoritesOfModalBottomSheet,
                    title:
                        Text(AppTexts().optionTextFavoritesOfModalBottomSheet),
                    onTap: navigationFunctionForFavoritesScreen,
                  ),
                  HomePageMenuListTiles(
                    icon: FontAwesome.logout,
                    iconColor:
                        AppColors.iconColorOptionLogoutOfModalBottomSheet,
                    title: Text(AppTexts().optionTextLogoutOfModalBottomSheet),
                    onTap: logoutFunctionAndNavigationToTheLoginScreen,
                  ),
                ],
              )
            : HomePageMenuListTiles(
                icon: FontAwesome.login,
                iconColor:
                    AppColors.iconColorOptionLoginOrSigninOfModalBottomSheet,
                title:
                    Text(AppTexts().optionTextLoginOrSigninOfModalBottomSheet),
                onTap: navigationFunctionForTheLoginScreen,
              ),
      ],
    );
  }

  navigationFunctionForTheHomePage() {
    AppRoutes.pop(context);
  }

  navigationFunctionForMyAccountScreen() {
    listenKeyboardVisibleOrNot.cancel();
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => MyAccountPage()));
  }

  navigationFunctionForMyAdsScreen() {
    print("navega para tela de meus anuncios");
  }

  navigationFunctionForFavoritesScreen() {
    print("navega para tela de favoritos");
  }

  logoutFunctionAndNavigationToTheLoginScreen() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    AppRoutes.pop(context);
  }

  navigationFunctionForTheLoginScreen() {
    final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(),
    );
    AppRoutes.makeFirst(context, App(userRepository: userRepository));
  }

  navigateToConversationScreen() {
    print("navega para tela de conversacao");
  }

  @override
  void dispose() {
    searchTextFieldFocusNode.dispose();
    listenKeyboardVisibleOrNot.cancel();
    super.dispose();
  }
}
