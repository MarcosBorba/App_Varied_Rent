import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_sizes.dart';

class HomePageMaterialButtonsCategories extends StatelessWidget {
  final Color buttonColor;
  final double elevation;
  final Function onPressed;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final IconData icon;
  final double iconSize;
  final String subTitle;

  const HomePageMaterialButtonsCategories({
    Key key,
    this.buttonColor = AppColors.buttonColorForCategoryOptions,
    this.elevation,
    this.onPressed,
    this.borderRadius,
    this.borderColor = AppColors.borderColorForCategoryOptionsButton,
    this.borderWidth,
    this.icon,
    this.iconSize,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.size12),
      child: MaterialButton(
          color: buttonColor,
          elevation: elevation == null ? AppSizes.size5 : elevation,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  borderRadius == null ? AppSizes.size18 : borderRadius),
              side: BorderSide(
                  color: borderColor,
                  width: borderWidth == null ? AppSizes.size2 : borderWidth)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: iconSize == null ? AppSizes.size100 : iconSize),
              Text(subTitle)
            ],
          )),
    );
  }
}
