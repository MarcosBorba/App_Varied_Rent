import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/main.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editMyAccountPages/editMyAccountPage.dart';
import 'package:varied_rent/views/homePages/myHomePage.dart';

class MyAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAccountPageState();
}
//TODO: nivel 4 - depois de criar outras telas, adicionar a navegacao de cada uma

//rotas a serem atualizadas depois de criar outras telas:
//Body => MyFavorite, MyAds
//chat
//meus anuncios
//favoritos

class MyAccountPageState extends State<MyAccountPage> {
  int navigationBarBottomIndex = 0;
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;
  SharedPref sharedPrefUser = SharedPref();
  String valueSharedPrefUser;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: funcaoVoltarHomePage,
      child: Scaffold(
          body: SafeArea(
            bottom: true,
            child: Container(
              color: AppColors.bodyColorBackground,
              height: heightBodyScaffold,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      height: heightBodyScaffold * 0.28,
                      width: screenWidth,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //TODO: nivel 1 - buscar forma de colocar imagem do usuario aqui
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.all(AppSizes.size12),
                                child: ImageLogoApp()),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(AppSizes.size12),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: FutureBuilder(
                                      future: getFutureDados(),
                                      initialData: AppTexts
                                          .myAccountTextToWaitForFutureBuilderDataToGetTheName,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Center(
                                            child: Text(
                                              AppTexts.myAccountFutureBuildersWelcomeTextToGetTheName +
                                                  "\n" +
                                                  snapshot.data,
                                              style: TextStyle(
                                                  fontSize: AppFontSize.s20),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: Text(AppTexts
                                                .myAccountTextToWaitForFutureBuilderDataToGetTheName),
                                          );
                                        }
                                      })),
                            ),
                          ),
                        ],
                      )),
                  Divider(
                    color: AppColors.myAccountPageDividerColorBody,
                    indent: AppSizes.size20,
                    endIndent: AppSizes.size20,
                    height: heightBodyScaffold * 0.10,
                    thickness: heightBodyScaffold * 0.001,
                  ),
                  Container(
                    height: heightBodyScaffold * 0.30,
                    width: screenWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: returnsNavigationButtonForMyFavorites()),
                        Expanded(child: returnsNavigationButtonForMyAds()),
                      ],
                    ),
                  ),
                  Container(
                    height: heightBodyScaffold * 0.30,
                    width: screenWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: returnsNavigationButtonToLogoutUser()),
                        Expanded(
                            child: returnsNavigationButtonForEditMyAccount()),
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
              setState(() {
                navigationBarBottomIndex = index;
                index == 0
                    ? showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) =>
                            openBottomDrawerMyAccountPage())
                    : index == 1 ? navigateToConversationScreen() : false;
              });
            },
            bottomNavyBarItems: listBottomFFNavigationBarItems(),
          )),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.menu,
        label: AppTexts().myAccountTextSubtitleMenuIconBottomNavigationBar,
      ),
      FFNavigationBarItem(
        iconData: Icons.chat,
        label: AppTexts().myAccountTextSubtitleChatIconBottomNavigationBar,
      )
    ];
    return fFNavigationBarItem;
  }

  Future<String> getFutureDados() async {
    await sharedPrefUser.read('name').then((value) {
      valueSharedPrefUser = value;
    });
    return valueSharedPrefUser;
  }

  Widget returnsNavigationButtonForMyFavorites() {
    return MyAccountPageMaterialButtonsCategories(
      onPressed: () =>
          searchAndNavigationFunctionForScreenWithUsersFavoriteAds(),
      icon: Icons.favorite,
      subTitle: AppTexts().myAccountOptionTextFavoritesOfBodyOptions,
    );
  }

  Widget returnsNavigationButtonForMyAds() {
    return MyAccountPageMaterialButtonsCategories(
      onPressed: () => searchAndNavigationFunctionForScreenWithUserCreatedAds(),
      icon: FontAwesome.tags,
      subTitle: AppTexts().myAccountOptionTextMyAdsOfBodyOptions,
    );
  }

  Widget returnsNavigationButtonToLogoutUser() {
    return MyAccountPageMaterialButtonsCategories(
      onPressed: () => logoutAndNavigationFunctionForTheLoginScreen(),
      icon: FontAwesome.logout,
      subTitle: AppTexts().myAccountOptionTextLogoutOfBodyOptions,
    );
  }

  Widget returnsNavigationButtonForEditMyAccount() {
    return MyAccountPageMaterialButtonsCategories(
      onPressed: () => navigationFunctionForUserDataEditingScreen(),
      icon: FontAwesome5.user_edit,
      subTitle: AppTexts().myAccountOptionTextMyAccountOfBodyOptions,
    );
  }

  searchAndNavigationFunctionForScreenWithUsersFavoriteAds() {
    print("pesquisa anuncios favoritos do usuario");
    print("navega para tela dos favoritos do usuario e exibe resultados");
  }

  searchAndNavigationFunctionForScreenWithUserCreatedAds() {
    print("pesquisa anuncios criados pelo usuario");
    print("navega para tela dos anuncios do usuario e exibe resultados");
  }

  logoutAndNavigationFunctionForTheLoginScreen() {
    print("desloga o usuario");
    print("navega para tela de login");
    logoutFunctionAndNavigationToTheLoginScreen();
  }

  navigationFunctionForUserDataEditingScreen() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => EditMyAccountPage()))
        .then((value) {
      setState(() {});
    });
  }

  Widget openBottomDrawerMyAccountPage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MyAccountPageMenuListTiles(
            icon: FontAwesome5.home,
            iconColor:
                AppColors.myAccountPageIconColorOptionHomeOfModalBottomSheet,
            title: Text(AppTexts().myAccountOptionTextHomeOfModalBottomSheet),
            onTap: navigationFunctionForTheHomePage),
        MyAccountPageMenuListTiles(
            icon: FontAwesome.tags,
            iconColor:
                AppColors.myAccountPageIconColorOptionMyAdsOfModalBottomSheet,
            title: Text(AppTexts().myAccountOptionTextMyAdsOfModalBottomSheet),
            onTap: navigationFunctionForMyAdsScreen),
        MyAccountPageMenuListTiles(
            icon: Icons.favorite,
            iconColor: AppColors
                .myAccountPageIconColorOptionFavoritesOfModalBottomSheet,
            title:
                Text(AppTexts().myAccountOptionTextFavoritesOfModalBottomSheet),
            onTap: navigationFunctionForFavoritesScreen),
        MyAccountPageMenuListTiles(
            icon: FontAwesome.logout,
            iconColor:
                AppColors.myAccountPageIconColorOptionLogoutOfModalBottomSheet,
            title: Text(AppTexts().myAccountOptionTextLogoutOfModalBottomSheet),
            onTap: logoutFunctionAndNavigationToTheLoginScreen),
      ],
    );
  }

  void navigationFunctionForTheHomePage() {
    AppRoutes.trioPop(context);
  }

  navigationFunctionForMyAdsScreen() {
    print("navega para tela de meus anuncios");
  }

  navigationFunctionForFavoritesScreen() {
    print("navega para tela de favoritos");
  }

  logoutFunctionAndNavigationToTheLoginScreen() {
    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(),
    );
    AppRoutes.makeFirst(context, App(userRepository: userRepository));
  }

  navigateToConversationScreen() {
    print("navega para tela de conversacao");
  }

  Future<bool> funcaoVoltarHomePage() async {
    AppRoutes.duoPop(context);
    return true;
  }
}
