import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EvaluationItem extends StatelessWidget {
  final String userNameEvaluator;
  final String dayTimeEvaluation;
  final double amountStars;
  final String objectiveOpition;
  final String opinion;
  final Color colorAnswerTitle;

  const EvaluationItem({
    Key key,
    this.userNameEvaluator,
    this.dayTimeEvaluation,
    this.amountStars,
    this.objectiveOpition,
    this.opinion,
    this.colorAnswerTitle = AppColors.adsProductIconTitleAnswer,
  })  : assert(objectiveOpition != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    returnShowDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowDialogQuestionAndAnswer(
                questionAndAnswer: returnFormQuestionAndAnswer(true, 100, 100));
          });
    }

    return GestureDetector(
      onTap: () => returnShowDialog(),
      child: BaseBoxQuestionsAndEvaluations(
        listComponents: returnFormQuestionAndAnswer(false, 2, 3),
      ),
    );
  }

  List<Widget> returnFormQuestionAndAnswer(
      bool showDialog, int maxLinesQuestion, int maxLinesAnswer) {
    return [
      Center(
        child: SmoothStarRating(
          rating: amountStars,
          isReadOnly: true,
          size: AppSizes.size20,
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 5,
          allowHalfRating: true,
          color: AppColors.adsProductIconStarsItemEvaluation,
          borderColor: AppColors.adsProductIconStarsBorderItemEvaluation,
        ),
      ),
      SizedBox(
        height: screenHeight * 0.01,
      ),
      QuestionAndAnswerTitle(
        userName: userNameEvaluator,
        dayTime: dayTimeEvaluation,
        textColorsItems: colorAnswerTitle,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              objectiveOpition,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLinesQuestion,
              style: TextStyle(
                fontSize: AppFontSize.s14,
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: screenHeight * 0.01,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              opinion,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: maxLinesAnswer,
              style: TextStyle(
                fontSize: AppFontSize.s14,
              ),
            ),
          )
        ],
      ),
    ];
  }
}
