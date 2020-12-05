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

  //Colors Components Default
  static const Color cursorTextFieldDefault = secondaryColor;
  static const Color hintTextTextFieldDefault = tertiaryColor;
  static const Color prefixIconTextFieldDefault = tertiaryColor;
  static const Color labelTextTextFieldDefault = tertiaryColor;
  static const Color defaultFormBorderTextFieldDefault = secondaryColor;
  static const Color focusedDefaultFormBorderTextFieldDefault = tertiaryColor;

  static const Color backgroundBottomNavigationBarDefault =
      AppColors.tertiaryColor;
  static const Color selectedItemBorderBottomNavigationBarDefault =
      AppColors.tertiaryColor;
  static const Color selectedItemBackgroundBottomNavigationBarDefault =
      Colors.black38;
  static const Color selectedItemIconBottomNavigationBarDefault = Colors.white;
  static const Color selectedItemLabelBottomNavigationBarDefault = Colors.white;
  static const Color unSelectedItemIconBottomNavigationBarDefault =
      Colors.white;
  static const Color unSelectedItemLabelBottomNavigationBarDefault =
      Colors.white;

  //Colors HomePage
  static const Color cursorColorSearchTextField = secondaryColor;
  static const Color hintTextColorSearchTextField = secondaryColor;
  static const Color prefixIconColorSearchTextField = tertiaryColor;
  static const Color defaultFormColorBorderSearchTextField = secondaryColor;
  static const Color focusedDefaultFormColorBorderSearchTextField =
      tertiaryColor;
  static const Color fillColorBorderSearchTextField = Colors.white;

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

  //Colors EditMyAccount Page
  static const Color editMyAccountPageMaterialButtonsOptionsBackgroundColor =
      Colors.white;
  static const Color editMyAccountPageMaterialButtonsOptionsBorderColor =
      AppColors.tertiaryColor;

  //Colors Edit Email or Password Page
  static const Color
      optionEditEmailOrPasswordPageButtonsOptionsBackgroundColor = Colors.white;
  static const Color optionEditEmailOrPasswordPageButtonsOptionsBorderColor =
      AppColors.tertiaryColor;
  static const Color optionEditEmailOrPasswordPageColorBackground =
      Colors.white;

  //Colors Mold Edit Email Or Password Page
  static const Color editEmailOrPasswordPageColorBackground = tertiaryColor;
  static const Color editEmailOrPasswordPageColorMainBackground = Colors.white;
  static const Color editEmailOrPasswordPageColorMainBorder = primaryColor;
  static const Color editEmailOrPasswordColorIconTitle = tertiaryColor;
  static const Color editEmailOrPasswordColorTitle = tertiaryColor;

  static const Color editEmailOrPasswordColorTextButtons = Colors.white;
  static const Color editEmailOrPasswordColorButtons = tertiaryColor;
  static const Color editEmailOrPasswordColorMainHelperText = Colors.black87;
  static const Color editEmailOrPasswordColorSufixIconPassword = tertiaryColor;
  static const Color editEmailOrPasswordColorCursorTextField = secondaryColor;
  static const Color editEmailOrPasswordColorHintTextField = secondaryColor;
  static const Color editEmailOrPasswordColorPrefixIconTextField =
      tertiaryColor;
  static const Color editEmailOrPasswordColorLabelTextField = tertiaryColor;
  static const Color editEmailOrPasswordColorBorderTextField = secondaryColor;
  static const Color editEmailOrPasswordColorBorderFocusedTextField =
      tertiaryColor;
  static const Color editEmailOrPasswordColorProgressIndicatorBackground =
      secondaryColor;
  static const Color editEmailOrPasswordColorProgressIndicatorSecondary =
      tertiaryColor;

  //Colors Edit My Profile Page
  static const Color editMyProfileBackground = tertiaryColor;
  static const Color editMyProfileBackgroundForm = Colors.white;
  static const Color editMyProfileBorderForm = primaryColor;
  static const Color editMyProfileIconTitle = tertiaryColor;
  static const Color editMyProfileTitle = tertiaryColor;

  static const Color editMyProfileButtonSubmit = tertiaryColor;
  static const Color editMyProfileLinearProgressBackground = secondaryColor;
  static const Color editMyProfileLinearProgressSecondary = tertiaryColor;

  //Colors Edit My Address Page
  static const Color editMyAddressBackground = tertiaryColor;
  static const Color editMyAddressBackgroundForm = Colors.white;
  static const Color editMyAddressBorderForm = primaryColor;
  static const Color editMyAddressIconTitle = tertiaryColor;
  static const Color editMyAddressTitle = tertiaryColor;

  static const Color editMyAddressButtonSubmit = tertiaryColor;
  static const Color editMyAddressLinearProgressBackground = secondaryColor;
  static const Color editMyAddressLinearProgressSecondary = tertiaryColor;

  //Colors Edit My Ads Page
  static const Color myAdsIconOnFailure = Colors.red;

  //Colors My Ads Product
  static const Color adsProductBackgroundPage = Colors.white;
  ////Material Title
  static const Color titleAdsProduct = tertiaryColor;
  static const Color titleAdsProductBackground = Colors.white;
  static const Color starsAdsProductBackground = Colors.yellow;
  static const Color starsQtdAdsProductBackground = Colors.yellow;
  ////Images Ad
  static const Color backgroundOpacityImages = tertiaryColor;
  ////Description
  static const Color adsProducttextDescription = Colors.black87;
  static Color adsProductBorderDescription = Colors.grey[300];
  ////Questions And Answers
  static const Color adsProductIconNoQuestion = AppColors.tertiaryColor;
  ////Select Evalutions
  static const Color adsProductIconStars = Colors.yellow;
  static const Color adsProductIconStarsBorder = Colors.yellow;
  ////Evaluations
  static const Color adsProductIconNoEvaluation = Colors.yellow;
  ////Item Evaluation
  static const Color adsProductIconTitleAnswer = Colors.blue;
  static const Color adsProductIconStarsItemEvaluation = Colors.yellow;
  static const Color adsProductIconStarsBorderItemEvaluation = Colors.yellow;
  ////BaseBoxQuestionsAndEvaluations
  static Color adsProductBaseBoxQuestionsAndEvaluations = Colors.grey[300];
  ////ShowDialogQuestionAndAnswer
  static Color adsProductShowDialogQuestionAndAnswerBackground = Colors.white;
  static Color adsProductShowDialogQuestionAndAnswerContainer =
      Colors.grey[300];
  ////QuestionAndAnswerItem
  static const Color adsProductQuestionTitle = Colors.blue;
  static const Color adsProductAnswerTitle = Colors.green;
  static const Color adsProductIconEditAnswer = Colors.black;
  //Insert new Ad Page
  static const Color insertAdStatusBar = AppColors.tertiaryColor;
  static const Color insertAdBackground = Colors.white;
  static const Color insertAdBigButtonAddImages = Colors.white;
  static const Color insertAdSmallButtonAddImages = Colors.white;
  static const Color insertAdSmallButtonAddImagesSplash =
      AppColors.secondaryColor;
  static const Color insertAdIconSmallButtonAddImages = AppColors.tertiaryColor;
  static const Color insertAdSubmitButton = AppColors.tertiaryColor;
  static const Color insertAdSubmitButtonLoadingPrimary =
      AppColors.secondaryColor;
  static const Color insertAdSubmitButtonLoadingSecondary =
      AppColors.tertiaryColor;
  static const Color titleInsertAd = Colors.white;
  static const Color titleInsertAdBackground = AppColors.tertiaryColor;
}
