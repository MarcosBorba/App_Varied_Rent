import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class EditEmailOrPasswordPageMaterialButtonsOptions extends StatelessWidget {
  final Color buttonColor;
  final Color borderColor;
  final double elevation;
  final Function onPressed;
  final double borderRadius;
  final double borderWidth;
  final IconData icon;
  final double iconSize;
  final String title;
  final String subTitle;
  final double heightButton;
  final double widthButton;

  const EditEmailOrPasswordPageMaterialButtonsOptions({
    Key key,
    this.buttonColor =
        AppColors.editEmailOrPasswordPageMaterialButtonsOptionsBackgroundColor,
    this.elevation,
    this.onPressed,
    this.borderRadius,
    this.borderColor =
        AppColors.editEmailOrPasswordPageMaterialButtonsOptionsBorderColor,
    this.borderWidth,
    this.icon,
    this.iconSize,
    this.subTitle,
    this.heightButton,
    this.widthButton,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightButton,
      width: widthButton,
      margin: EdgeInsets.only(
          left: AppSizes.size12,
          right: AppSizes.size12,
          bottom: AppSizes.size10),
      child: MaterialButton(
          color: buttonColor,
          elevation: elevation == null ? AppSizes.size10 : elevation,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius == null ? AppSizes.size18 : borderRadius),
              side: BorderSide(
                  color: borderColor,
                  width: borderWidth == null ? AppSizes.size2 : borderWidth)),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Icon(icon,
                      size: iconSize == null ? AppSizes.size100 : iconSize)),
              Expanded(
                  flex: 2,
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(subTitle),
                  ))
            ],
          )),
    );
  }
}
