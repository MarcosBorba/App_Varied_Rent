import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 4 - text e colors
class EvaluationsAd extends StatelessWidget {
  final List<Evaluation> evaluations;
  final double heightEvaluation;
  final ItemScrollController controllerItemRefreshListView;
  final double starSelected;

  EvaluationsAd({
    Key key,
    this.evaluations,
    this.heightEvaluation,
    this.controllerItemRefreshListView,
    this.starSelected,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                  color: Colors.yellow,
                  size: AppSizes.size50,
                ),
                SizedBox(
                  height: AppSizes.size20,
                ),
                Text(
                  "This ad has no rating yet!",
                  style: TextStyle(fontSize: AppFontSize.s18),
                ),
              ],
            ),
    );
  }
}
