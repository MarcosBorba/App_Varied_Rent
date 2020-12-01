import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/utils/utils.dart';

class SelectStarsEvaluation extends StatefulWidget {
  final List<Widget> stars;
  final String hintText;
  final ItemScrollController controllerItemRefreshListView;
  final double starSelected;
  final Function onChanged;

  SelectStarsEvaluation({
    Key key,
    this.stars,
    this.hintText = AppTexts.myAdsProductSelectStars,
    this.controllerItemRefreshListView,
    this.starSelected,
    this.onChanged,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => SelectStarsEvaluationState(
        stars: stars,
        hintText: hintText,
        starSelected: starSelected,
        controllerItemRefreshListView: controllerItemRefreshListView,
        onChanged: onChanged,
      );
}

class SelectStarsEvaluationState extends State<SelectStarsEvaluation> {
  List<Widget> stars;
  final String hintText;
  final ItemScrollController controllerItemRefreshListView;
  double starSelected;
  Function onChanged;

  SelectStarsEvaluationState({
    this.onChanged,
    this.controllerItemRefreshListView,
    this.starSelected,
    this.hintText,
    this.stars,
  });

  @override
  void initState() {
    super.initState();
    stars = functionCreateStarsEvaluation();
  }

  List<Widget> functionCreateStarsEvaluation() {
    List<Widget> starsFunction = [];
    for (double i = 5.0; i > 0.0; i--) {
      starsFunction.add(
        SmoothStarRating(
          rating: i,
          isReadOnly: true,
          size: AppSizes.size20,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 5,
          allowHalfRating: true,
          color: AppColors.adsProductIconStars,
          borderColor: AppColors.adsProductIconStarsBorder,
        ),
      );
    }
    return starsFunction;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.06,
        right: screenWidth * 0.06,
      ),
      child: DropdownButtonFormField<SmoothStarRating>(
        items: stars.map((Widget dropDownStringItem) {
          return DropdownMenuItem<SmoothStarRating>(
            value: dropDownStringItem,
            child: dropDownStringItem,
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
        ),
        hint: Text(hintText),
        icon: Icon(
          Icons.arrow_drop_down,
          size: AppSizes.size30,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
