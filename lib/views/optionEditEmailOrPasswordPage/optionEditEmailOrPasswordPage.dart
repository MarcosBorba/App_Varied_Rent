import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editEmailOrPasswordPage/moldEditEmailOrPasswordPage.dart';

class OptionEditEmailOrPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OptionEditEmailOrPasswordPageState();
}

class OptionEditEmailOrPasswordPageState
    extends State<OptionEditEmailOrPasswordPage> {
  int navigationBarBottomIndex = 0;
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: screenHeight,
          width: screenWidth,
          color: AppColors.optionEditEmailOrPasswordPageColorBackground,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                EditOptionEmailOrPasswordPageMaterialButtonsOptions(
                  heightButton: heightBodyScaffold * 0.25,
                  widthButton: screenWidth,
                  icon: Icons.email,
                  title: AppTexts().navigationOptionTextToEditEmail,
                  subTitle: AppTexts().navigationOptionSubTextToEditEmail,
                  onPressed: () => navigatesToTheEditEmailOrPasswordScreen(
                      AppTexts.optionEditEmailOrPasswordPageTitlePageEmail,
                      AppTexts
                          .optionEditEmailOrPasswordPageDataThatWillEditEmail),
                ),
                EditOptionEmailOrPasswordPageMaterialButtonsOptions(
                  heightButton: heightBodyScaffold * 0.25,
                  widthButton: screenWidth,
                  icon: Icons.lock,
                  title: AppTexts().navigationOptionTextToEditPassword,
                  subTitle: AppTexts().navigationOptionSubTextToEditPassword,
                  onPressed: () => navigatesToTheEditEmailOrPasswordScreen(
                      AppTexts.optionEditEmailOrPasswordPageTitlePagePassword,
                      AppTexts
                          .optionEditEmailOrPasswordPageDataThatWillEditPassword),
                )
              ])),
      bottomNavigationBar:
          EditMyAccountOptionEmailOrPasswordPageFFNavigationBar(
        selectedIndex: navigationBarBottomIndex,
        onSelectTab: (index) {
          setState(() {
            navigationBarBottomIndex = index;
            index == 0
                ? navigatesToTheEditEmailOrPasswordScreen(
                    AppTexts.optionEditEmailOrPasswordPageTitlePageEmail,
                    AppTexts.optionEditEmailOrPasswordPageDataThatWillEditEmail)
                : index == 1
                    ? navigatesToTheEditEmailOrPasswordScreen(
                        AppTexts.optionEditEmailOrPasswordPageTitlePagePassword,
                        AppTexts
                            .optionEditEmailOrPasswordPageDataThatWillEditPassword)
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

  navigatesToTheEditEmailOrPasswordScreen(
      String titlePage, String dataThatWillEdit) {
    UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(),
    );
    AppRoutes.push(
        context,
        MoldEditEmailOrPassword(
          userRepository: userRepository,
          editEmailForm: "ConfirmUser",
          titlePage: titlePage,
          dataThatWillEdit: dataThatWillEdit,
        ));
  }
}
