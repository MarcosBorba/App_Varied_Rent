import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = const Color(0xff6af2f0);
  static const Color secondaryColor = const Color(0xff04d4f0);
  static const Color tertiaryColor = const Color(0xff059dc0);
  static const Color transparentBackground = const Color(0xff000000FF);
  static const Color iconColorDefault = const Color(0xffFFFFFF);
  static const Color textColorDefault = const Color(0xffFFFFFF);
  //Component colors
  Color get appBarColorDefault => tertiaryColor;
  Color get buttonColorDefault => secondaryColor;
  Color get buttonColorWhenClicking => tertiaryColor;
  Color get iconsColorDefault => iconColorDefault;
  Color get backgroundImage => secondaryColor;
  //Text colors
  Color get textsColorDefault => textColorDefault;
  Color get defaultTitleColor => const Color(0xDD000000);
  Color get defaultSubtitleColor => const Color(0x8A000000);
  //Border colors

  //Colors HomePage
  static const Color cursorColorSearchTextField = secondaryColor;
  static const Color hintTextColorSearchTextField = secondaryColor;
  static const Color prefixIconColorSearchTextField = tertiaryColor;
  static const Color defaultFormColorBorderSearchTextField = secondaryColor;
  static const Color focusedDefaultFormColorBorderSearchTextField =
      tertiaryColor;
  static const Color fillColorBorderSearchTextField = Colors.white;

  static const Color backgroundColorBottomNanigationBar =
      AppColors.tertiaryColor;
  static const Color selectedItemBorderColorBottomNanigationBar =
      AppColors.tertiaryColor;
  static const Color selectedItemBackgroundColorBottomNanigationBar =
      Colors.black38;
  static const Color selectedItemIconColorBottomNanigationBar = Colors.white;
  static const Color selectedItemLabelColorBottomNanigationBar = Colors.white;
  static const Color unselectedItemIconColorBottomNanigationBar = Colors.white;
  static const Color unselectedItemLabelColorBottomNanigationBar = Colors.white;

  static const Color borderColorForCategoryOptionsButton =
      AppColors.tertiaryColor;
  static const Color buttonColorForCategoryOptions = Colors.white;

  static const Color iconColorOptionDefaultOfModalBottomSheet = Colors.black;
  static const Color iconColorOptionBorderRightOfModalBottomSheet =
      Colors.black;
  static const Color iconColorOptionHomeOfModalBottomSheet =
      AppColors.secondaryColor;
  static const Color iconColorOptionMyAccountOfModalBottomSheet = Colors.black;
  static const Color iconColorOptionMyAdsOfModalBottomSheet = Colors.blue;
  static const Color iconColorOptionFavoritesOfModalBottomSheet = Colors.red;
  static const Color iconColorOptionLogoutOfModalBottomSheet = Colors.black;
  static const Color iconColorOptionLoginOrSigninOfModalBottomSheet =
      Colors.black;

  //Colors MyAccount Page
  static const Color bodyColorBackground = Colors.white;

  static const Color myAccountPageIconColorOptionHomeOfModalBottomSheet =
      AppColors.secondaryColor;
  static const Color myAccountPageIconColorOptionMyAccountOfModalBottomSheet =
      Colors.black;
  static const Color myAccountPageIconColorOptionMyAdsOfModalBottomSheet =
      Colors.blue;
  static const Color myAccountPageIconColorOptionFavoritesOfModalBottomSheet =
      Colors.red;
  static const Color myAccountPageIconColorOptionLogoutOfModalBottomSheet =
      Colors.black;

  static const Color myAccountPageDividerColorBody = Colors.black;
}
