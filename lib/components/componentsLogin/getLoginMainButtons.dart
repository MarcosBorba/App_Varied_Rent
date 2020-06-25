import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/utils/app_text_sizes.dart';

class LoginMainButtons extends StatelessWidget {
  final Color splashColor;
  final Color disabledColor;
  final Function onPressed;
  final Color color;
  final String textButton;
  final double minWidthButton;
  final double heightButton;

  const LoginMainButtons(
      {Key key,
      this.splashColor,
      this.disabledColor,
      this.onPressed,
      this.color,
      this.textButton,
      this.minWidthButton,
      this.heightButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidthButton,
      height: heightButton,
      splashColor: splashColor,
      disabledColor: disabledColor,
      onPressed: onPressed,
      color: color,
      elevation: AppSizes.size3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.size30),
      ),
      child: Text(
        textButton,
        style: TextStyle(
            fontSize: AppFontSize.s20, color: AppColors().textsColorDefault),
      ),
    );
  }
}
