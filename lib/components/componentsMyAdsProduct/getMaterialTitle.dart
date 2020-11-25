import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/models/evaluation.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 3 - definir cores,texts,sizes
class MaterialTitle extends StatelessWidget {
  final double backgroundHeight;
  final Color titleBackgroundColor;
  final Color titleColor;
  final String title;
  final double sizeStars;
  final double titleSize;
  final int qtdEvaluations;
  final double adEvaluations;

  MaterialTitle({
    Key key,
    this.titleColor = AppColors.tertiaryColor,
    this.title = "",
    this.titleBackgroundColor = Colors.white,
    this.sizeStars,
    this.titleSize,
    this.backgroundHeight,
    this.qtdEvaluations,
    this.adEvaluations,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      child: Container(
        color: titleColor,
        height: backgroundHeight == null ? AppSizes.size100 : backgroundHeight,
        width: screenWidth,
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: titleSize == null ? AppFontSize.s18 : titleSize,
                color: titleBackgroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new SmoothStarRating(
                  rating: adEvaluations,
                  isReadOnly: true,
                  size: sizeStars == null ? AppSizes.size20 : sizeStars,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  color: Colors.yellow,
                  borderColor: Colors.yellow,
                ),
                new Text(
                  " ( " + qtdEvaluations.toString() + " )",
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
