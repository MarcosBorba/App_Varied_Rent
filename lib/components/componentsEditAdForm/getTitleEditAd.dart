import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class TitleEditAd extends StatelessWidget {
  final double backgroundHeight;
  final Color titleBackgroundColor;
  final Color titleColor;
  final double sizeStars;
  final double titleSize;

  TitleEditAd({
    Key key,
    this.titleColor = AppColors.titleEditAd,
    this.titleBackgroundColor = AppColors.titleEditAdBackground,
    this.sizeStars,
    this.titleSize,
    this.backgroundHeight,
  });
  @override
  Widget build(BuildContext context) {
    String titleAd = AppTexts().titlePageEditAd;
    return new Material(
      elevation: 7,
      child: new Container(
        color: titleBackgroundColor,
        height: backgroundHeight == null ? AppSizes.size100 : backgroundHeight,
        width: screenWidth,
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              titleAd,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: titleSize == null ? AppFontSize.s25 : titleSize,
                color: titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: AppSizes.size20),
              child: Icon(
                Icons.edit,
                color: AppColors.iconEditPageAd,
                size: AppSizes.size30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
