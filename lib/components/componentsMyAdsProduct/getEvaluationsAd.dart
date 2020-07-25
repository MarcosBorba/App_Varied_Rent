import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EvaluationsAd extends StatelessWidget {
  final List evaluations;
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
      child: ScrollablePositionedList.builder(
        itemScrollController: controllerItemRefreshListView,
        scrollDirection: Axis.horizontal,
        itemCount: evaluations.length,
        itemBuilder: (context, index) {
          return evaluations[index][2] == starSelected || starSelected == null
              ? EvaluationItem(
                  userNameEvaluator: evaluations[index][0],
                  dayTimeEvaluation: evaluations[index][1],
                  amountStars: evaluations[index][2],
                  objectiveOpition: evaluations[index][3],
                  opinion: evaluations[index][4],
                )
              : Text("");
        },
      ),
    );
  }
}
