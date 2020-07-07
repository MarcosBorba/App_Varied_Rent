import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:varied_rent/components/componentsEditMyAccountEmailOrPasswordPage/getEditMyAccountEmailOrPasswordPageFFBottomNavigationBar.dart';
import 'package:varied_rent/components/componentsEditMyAccountEmailOrPasswordPage/getEditMyAccountEmailOrPasswordPageMaterialButtonsOptions.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/app_routes.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/utils/app_texts.dart';
import 'package:varied_rent/views/editEmailPage/editEmailPage.dart';

class EditEmailOrPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EditEmailOrPasswordPageState();
}

//TODO: nivel 4 - definir rotas widgets
//email
//password
class EditEmailOrPasswordPageState extends State<EditEmailOrPasswordPage> {
  int navigationBarBottomIndex = 0;
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EditEmailOrPasswordPageMaterialButtonsOptions(
                  heightButton: heightBodyScaffold * 0.25,
                  widthButton: screenWidth,
                  icon: Icons.email,
                  title: AppTexts().navigationOptionTextToEditEmail,
                  subTitle: AppTexts().navigationOptionSubTextToEditEmail,
                  onPressed: () => navigatesToTheEditEmailScreen(),
                ),
                EditEmailOrPasswordPageMaterialButtonsOptions(
                  heightButton: heightBodyScaffold * 0.25,
                  widthButton: screenWidth,
                  icon: Icons.lock,
                  title: AppTexts().navigationOptionTextToEditPassword,
                  subTitle: AppTexts().navigationOptionSubTextToEditPassword,
                  onPressed: () => navigatesToTheEditPasswordScreen(),
                )
              ])),
      bottomNavigationBar: EditMyAccountEmailOrPasswordPageFFNavigationBar(
        selectedIndex: navigationBarBottomIndex,
        onSelectTab: (index) {
          setState(() {
            navigationBarBottomIndex = index;
            index == 0
                ? navigatesToTheEditEmailScreen()
                : index == 1 ? navigatesToTheEditPasswordScreen() : false;
          });
        },
        bottomNavyBarItems: listBottomFFNavigationBarItems(),
      ),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.email,
        label: AppTexts().navigationOptionTextToEditEmail,
      ),
      FFNavigationBarItem(
        iconData: Icons.lock,
        label: AppTexts().navigationOptionTextToEditPassword,
      )
    ];
    return fFNavigationBarItem;
  }

  navigatesToTheEditEmailScreen() {
    UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(),
    );
    AppRoutes.push(
        context,
        EditEmailPage(
          userRepository: userRepository,
          editEmailForm: 1,
        ));
  }

  navigatesToTheEditPasswordScreen() {
    print("navega para tela de editar senha");
  }
}
