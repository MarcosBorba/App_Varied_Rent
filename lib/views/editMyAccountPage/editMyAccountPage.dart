import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/components/componentsEditMyAccountPage/getEditMyAccountPageFFBottomNavigationBar.dart';
import 'package:varied_rent/components/componentsEditMyAccountPage/getEditMyAccountPageMaterialButtonsOptions.dart';
import 'package:varied_rent/utils/app_routes.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/utils/app_texts.dart';
import 'package:varied_rent/views/editMyAccountEmailOrPasswordPage/editMyAccountEmailOrPasswordPage.dart';

class EditMyAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditMyAccountPageState();
}
//TODO: nivel 4 - depois de criar outras telas, adicionar a navegacao de cada uma
//account
//profile
//address

class EditMyAccountPageState extends State<EditMyAccountPage> {
  int navigationBarBottomIndex = 0;
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: heightBodyScaffold,
          width: screenWidth,
          child:
              returnListButtonsOptions(heightBodyScaffold * 0.25, screenWidth),
        ),
      ),
      bottomNavigationBar: EditMyAccountPageFFNavigationBar(
        selectedIndex: navigationBarBottomIndex,
        onSelectTab: (index) {
          setState(() {
            navigationBarBottomIndex = index;
            index == 0
                ? navigatesToTheEditAccountDataScreen()
                : index == 1
                    ? navigatesToTheEditProfileDataScreen()
                    : index == 2
                        ? navigatesToTheEditAddressDataScreen()
                        : false;
          });
        },
        bottomNavyBarItems: listBottomFFNavigationBarItems(),
      ),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.alternate_email,
        label: AppTexts().editMyAccountNavigationOptionTextToEditAccountData,
      ),
      FFNavigationBarItem(
        iconData: FontAwesome5.user,
        label: AppTexts().editMyAccountNavigationOptionTextToEditAProfileData,
      ),
      FFNavigationBarItem(
        iconData: Entypo.location,
        label: AppTexts().editMyAccountNavigationOptionTextToEditAddressData,
      )
    ];
    return fFNavigationBarItem;
  }

  Widget returnListButtonsOptions(double heightButtons, double widthButtons) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        EditMyAccountPageMaterialButtonsOptions(
          heightButton: heightButtons,
          widthButton: widthButtons,
          icon: Icons.alternate_email,
          title: AppTexts().editMyAccountNavigationOptionTextToEditAccountData,
          subTitle: AppTexts()
              .editMyAccountNavigationOptionHelperTextToEditAccountData,
          onPressed: () => navigatesToTheEditAccountDataScreen(),
        ),
        EditMyAccountPageMaterialButtonsOptions(
          heightButton: heightButtons,
          widthButton: widthButtons,
          icon: FontAwesome5.user,
          title: AppTexts().editMyAccountNavigationOptionTextToEditAProfileData,
          subTitle: AppTexts()
              .editMyAccountNavigationOptionHelperTextToEditProfileData,
          onPressed: () => navigatesToTheEditProfileDataScreen(),
        ),
        EditMyAccountPageMaterialButtonsOptions(
          heightButton: heightButtons,
          widthButton: widthButtons,
          icon: Entypo.location,
          title: AppTexts().editMyAccountNavigationOptionTextToEditAddressData,
          subTitle: AppTexts()
              .editMyAccountNavigationOptionHelperTextToEditAddressData,
          onPressed: () => navigatesToTheEditAddressDataScreen(),
        )
      ],
    );
  }

  navigatesToTheEditAccountDataScreen() {
    print("navega para tela de editar email e senha");
    AppRoutes.push(context, EditMyAccountEmailOrPasswordPage());
  }

  navigatesToTheEditProfileDataScreen() {
    print("navega para tela de editar dados do perfil");
  }

  navigatesToTheEditAddressDataScreen() {
    print("navega para tela de editar dados do endereco");
  }
}
