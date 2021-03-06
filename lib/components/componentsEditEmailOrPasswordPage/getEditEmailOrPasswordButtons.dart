import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/utils/app_text_sizes.dart';

class EditEmailOrPasswordButtons extends StatelessWidget {
  final Color splashColor;
  final Color disabledColor;
  final Color color;
  final Color colorText;
  final Function onPressed;
  final String textButton;
  final double minWidthButton;
  final double heightButton;

  const EditEmailOrPasswordButtons(
      {Key key,
      this.splashColor,
      this.disabledColor,
      this.onPressed,
      this.color = AppColors.editEmailOrPasswordColorButtons,
      this.textButton,
      this.minWidthButton,
      this.heightButton,
      this.colorText = AppColors.editEmailOrPasswordColorTextButtons})
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
          fontSize: AppFontSize.s20,
          color: colorText,
        ),
      ),
    );
  }
}
