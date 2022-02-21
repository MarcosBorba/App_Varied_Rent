import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

//TODO: nivel 4 -  texts, colors, sizes.....
class MaterialAdTitle extends StatelessWidget {
  final double backgroundHeight;
  final Color titleBackgroundColor;
  final Color titleColor;
  final double sizeStars;
  final double titleSize;

  MaterialAdTitle({
    Key key,
    this.titleColor = AppColors.titleAdsProduct,
    this.titleBackgroundColor = AppColors.titleAdsProductBackground,
    this.sizeStars,
    this.titleSize,
    this.backgroundHeight,
  });
  @override
  Widget build(BuildContext context) {
    int qtdEvaluations = 0;
    double adEvaluations = 0.0;
    String titleAd;
    qtdEvaluations = CacheProviderAdProduct.of(context).qtdEvaluations;
    adEvaluations = CacheProviderAdProduct.of(context).adEvaluation;
    titleAd = CacheProviderAdProduct.of(context).titleAd;
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
                fontSize: titleSize == null ? AppFontSize.s18 : titleSize,
                color: titleBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RatingBar(
                  initialRating: adEvaluations,
                  ignoreGestures: true,
                  itemSize: sizeStars == null ? AppSizes.size20 : sizeStars,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star,
                        color: AppColors.starsAdsProductBackground),
                    half: Icon(Icons.star_half,
                        color: AppColors.starsAdsProductBackground),
                    empty: Icon(Icons.star_border,
                        color: AppColors.starsAdsProductBackground),
                  ),
                  onRatingUpdate: null,
                ),
                new Text(
                  " ( " + qtdEvaluations.toString() + " )",
                  style: TextStyle(
                    color: AppColors.starsQtdAdsProductBackground,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
