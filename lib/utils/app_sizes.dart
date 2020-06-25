import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:varied_rent/utils/app_text_sizes.dart';

double statusBarHeight = 0;
double screenWidth = 0;
double screenHeight = 0;

class AppSizes {
  static double size0 = 0.0;
  static double size1 = 1.0;
  static double size2 = 2.0;
  static double size3 = 3.0;
  static double size4 = 4.0;
  static double size5 = 5.0;
  static double size6 = 6.0;
  static double size7 = 7.0;
  static double size8 = 8.0;
  static double size9 = 9.0;
  static double size10 = 10.0;
  static double size12 = 12.0;
  static double size14 = 14.0;
  static double size15 = 15.0;
  static double size16 = 16.0;
  static double size18 = 18.0;
  static double size20 = 20.0;
  static double size25 = 25.0;
  static double size30 = 30.0;
  static double size35 = 35.0;
  static double size40 = 40.0;
  static double size45 = 45.0;
  static double size50 = 50.0;
  static double size55 = 55.0;
  static double size60 = 60.0;
  static double size65 = 65.0;
  static double size70 = 70.0;
  static double size75 = 75.0;
  static double size80 = 80.0;
  static double size85 = 85.0;
  static double size90 = 90.0;
  static double size95 = 95.0;
  static double size100 = 100.0;
  static double size125 = 125.0;
  static double size150 = 150.0;
  static double size175 = 175.0;
  static double size200 = 200.0;
  static double size250 = 250.0;
  static double size300 = 300.0;
  static double size500 = 500.0;

  //Padding space default
  static EdgeInsets paddingDefault = EdgeInsets.all(size10);
  static EdgeInsets paddingFormLoginDefault = EdgeInsets.only(left: size15,right: size15);

  //Components

  //Sizedbox sizes to add spaces between widgets
  static double extraSmallSizedBoxHeight = 10.0;
  static double smallSizedBoxHeight = 15.0;
  static double normalSizedBoxHeight = 20.0;
  static double largeSizedBoxHeight = 25.0;
  static double extraLargeSizedBoxHeight = 30.0;
  static double extraSmallSizedBoxWidth = 10.0;
  static double smallSizedBoxWidth = 15.0;
  static double normalSizedBoxWidth = 20.0;
  static double largeSizedBoxWidth = 25.0;
  static double extraLargeSizedBoxWidth = 30.0;
  //Size of paddings and margins
  static double extraSmallSpace = 5.0;
  static double smallSpace = 10.0;
  static double normalSpace = 15.0;
  static double largeSpace = 20.0;
  static double extraLargeSpace = 25.0;
  //size of login screen buttons
  static double widgetButtonLogin = 335.0;
  static double heightButtonLogin = 60.0;


  static double heightLogin = 522.0;

  static Future setScreenAwareConstant(context) async {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    getSize() async {
      if (screenWidth == 0 || screenHeight == 0) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
        await Future.delayed(Duration(milliseconds: 300));
        await getSize();
      }
    }

    await getSize();
    print('========Device Screen Details==============='
        'screenWidth: $screenWidth'
        'screenHeight: $screenHeight');
    ScreenUtil.init(
      context,
      width: screenWidth,
      height: screenHeight,
      allowFontScaling: true,
    );

    AppFontSize.setScreenAwareFontSize(ScreenUtil());
    statusBarHeight = ScreenUtil.statusBarHeight;
    print('statusBarHeight: $statusBarHeight');
    size0 = ScreenUtil().setWidth(0.0);
    size1 = ScreenUtil().setWidth(1.0);
    size2 = ScreenUtil().setWidth(2.0);
    size3 = ScreenUtil().setWidth(3.0);
    size4 = ScreenUtil().setWidth(4.0);
    size5 = ScreenUtil().setWidth(5.0);
    size6 = ScreenUtil().setWidth(6.0);
    size7 = ScreenUtil().setWidth(7.0);
    size8 = ScreenUtil().setWidth(8.0);
    size9 = ScreenUtil().setWidth(9.0);
    size10 = ScreenUtil().setWidth(10.0);
    size12 = ScreenUtil().setWidth(12.0);
    size14 = ScreenUtil().setWidth(14.0);
    size15 = ScreenUtil().setWidth(15.0);
    size16 = ScreenUtil().setWidth(16.0);
    size18 = ScreenUtil().setWidth(18.0);
    size20 = ScreenUtil().setWidth(20.0);
    size25 = ScreenUtil().setWidth(25.0);
    size30 = ScreenUtil().setWidth(30.0);
    size35 = ScreenUtil().setWidth(35.0);
    size40 = ScreenUtil().setWidth(40.0);
    size45 = ScreenUtil().setWidth(45.0);
    size50 = ScreenUtil().setWidth(50.0);
    size55 = ScreenUtil().setWidth(55.0);
    size60 = ScreenUtil().setWidth(60.0);
    size65 = ScreenUtil().setWidth(65.0);
    size70 = ScreenUtil().setWidth(70.0);
    size75 = ScreenUtil().setWidth(75.0);
    size80 = ScreenUtil().setWidth(80.0);
    size85 = ScreenUtil().setWidth(85.0);
    size90 = ScreenUtil().setWidth(90.0);
    size95 = ScreenUtil().setWidth(95.0);
    size100 = ScreenUtil().setWidth(100.0);
    size125 = ScreenUtil().setWidth(125.0);
    size150 = ScreenUtil().setWidth(150.0);
    size175 = ScreenUtil().setWidth(175.0);
    size200 = ScreenUtil().setWidth(200.0);
    size250 = ScreenUtil().setWidth(250.0);
    size300 = ScreenUtil().setWidth(300.0);
    size500 = ScreenUtil().setWidth(500.0);

    //SizedBox sizes
    extraSmallSizedBoxHeight = ScreenUtil().setWidth(10.0);
    smallSizedBoxHeight = ScreenUtil().setWidth(15.0);
    normalSizedBoxHeight = ScreenUtil().setWidth(20.0);
    largeSizedBoxHeight = ScreenUtil().setWidth(25.0);
    extraLargeSizedBoxHeight = ScreenUtil().setWidth(30.0);
    extraSmallSizedBoxWidth = ScreenUtil().setWidth(10.0);
    smallSizedBoxWidth = ScreenUtil().setWidth(15.0);
    normalSizedBoxWidth = ScreenUtil().setWidth(20.0);
    largeSizedBoxWidth = ScreenUtil().setWidth(25.0);
    extraLargeSizedBoxWidth = ScreenUtil().setWidth(30.0);
    //Padding space default
    paddingDefault = EdgeInsets.all(size10);
    paddingFormLoginDefault = EdgeInsets.only(left: size15,right: size15);
    //Size of paddings and margins
    extraSmallSpace = ScreenUtil().setWidth(5.0);
    smallSpace = ScreenUtil().setWidth(10.0);
    normalSpace = ScreenUtil().setWidth(15.0);
    largeSpace = ScreenUtil().setWidth(20.0);
    extraLargeSpace = ScreenUtil().setWidth(25.0);
    //size of login screen buttons
    widgetButtonLogin = ScreenUtil().setWidth(335.0);
    heightButtonLogin = ScreenUtil().setWidth(60.0);

    heightLogin = ScreenUtil().setWidth(522.0);
  }
}
