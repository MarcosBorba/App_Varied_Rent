import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:varied_rent/models/evaluation.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProduct.dart';

//TODO: nivel 3 - definir cores,texts,sizes
class MaterialTitle extends StatelessWidget {
  final double backgroundHeight;
  final Color titleBackgroundColor;
  final Color titleColor;
  final String titleAd;
  final double sizeStars;
  final double titleSize;

  MaterialTitle({
    Key key,
    this.titleColor = AppColors.tertiaryColor,
    this.titleAd = "No title",
    this.titleBackgroundColor = Colors.white,
    this.sizeStars,
    this.titleSize,
    this.backgroundHeight,
  });
  @override
  Widget build(BuildContext context) {
    int qtdEvaluations = 0;
    double adEvaluations = 0.0;
    qtdEvaluations = CacheProvider.of(context).qtdEvaluations;
    adEvaluations = CacheProvider.of(context).adEvaluation;
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
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_half, color: Colors.yellow),
                    empty: Icon(Icons.star_border, color: Colors.yellow),
                  ),
                  onRatingUpdate: null,
                ),
                new Text(
                  " ( " + qtdEvaluations.toString() + " )",
                  style: TextStyle(
                    color: Colors.yellow,
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
