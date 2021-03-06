import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class EvaluationsAd extends StatelessWidget {
  final double heightEvaluation;
  final ItemScrollController controllerItemRefreshListView;
  final double starSelected;

  EvaluationsAd({
    Key key,
    this.heightEvaluation,
    this.controllerItemRefreshListView,
    this.starSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Evaluation> evaluations = CacheProvider.of(context).evaluations;
    return Container(
      height: heightEvaluation == null ? screenHeight * 0.20 : heightEvaluation,
      width: screenWidth,
      margin: EdgeInsets.only(top: screenHeight * 0.05),
      child: evaluations != null && evaluations.length > 0
          ? ScrollablePositionedList.builder(
              itemScrollController: controllerItemRefreshListView,
              scrollDirection: Axis.horizontal,
              itemCount: evaluations.length,
              itemBuilder: (context, index) {
                return double.parse(evaluations[index].amount_stars) ==
                            starSelected ||
                        starSelected == null
                    ? EvaluationItem(
                        userNameEvaluator: evaluations[index].user_name,
                        dayTimeEvaluation: evaluations[index].evaluation_date,
                        amountStars:
                            double.parse(evaluations[index].amount_stars),
                        objectiveOpition: evaluations[index].objective_opition,
                        opinion: evaluations[index].opinion,
                      )
                    : Text("");
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sentiment_dissatisfied,
                  color: AppColors.adsProductIconNoEvaluation,
                  size: AppSizes.size50,
                ),
                SizedBox(
                  height: AppSizes.size20,
                ),
                Text(
                  AppTexts().myAdsProductNoEvaluations,
                  style: TextStyle(fontSize: AppFontSize.s18),
                ),
              ],
            ),
    );
  }
}
