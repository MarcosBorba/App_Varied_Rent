import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class TitleInsertAd extends StatelessWidget {
  final double backgroundHeight;
  final Color titleBackgroundColor;
  final Color titleColor;
  final double sizeStars;
  final double titleSize;

  TitleInsertAd({
    Key key,
    this.titleColor = AppColors.titleAdsProduct,
    this.titleBackgroundColor = AppColors.titleAdsProductBackground,
    this.sizeStars,
    this.titleSize,
    this.backgroundHeight,
  });
  @override
  Widget build(BuildContext context) {
    String titleAd = "Inserindo Um Novo Anúncio";
    return new Material(
      elevation: 7,
      child: new Container(
        color: titleColor,
        height: backgroundHeight == null ? AppSizes.size100 : backgroundHeight,
        width: screenWidth,
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              titleAd,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: titleSize == null ? AppFontSize.s25 : titleSize,
                color: titleBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
