import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getAnswerRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionAndAnswerTitle.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getShowDialogQuestionAndAnswer.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel - 3 - definir colors, texts, sizes
class EvaluationItem extends StatelessWidget {
  final String userNameEvaluator;
  final String dayTimeEvaluation;
  final double amountStars;
  final String objectiveOpition;
  final String opinion;
  final Color colorAnswerTitle;

  const EvaluationItem({
    Key key,
    this.userNameEvaluator = "Marcos Flavio Ferreira Borba",
    this.dayTimeEvaluation = "25 Jul 20",
    this.amountStars = 2.5,
    this.objectiveOpition =
        "A casa é bem bonita mesmo, os quartos e a varanda são muito espaçosos, a garagem também, o local é muito bem cuidado e limpo, recomendo!",
    this.opinion = "Casa linda, espaçosa, limpa, curti!",
    this.colorAnswerTitle = Colors.blue,
  })  : assert(objectiveOpition != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    returnShowDialog() {
      print("olá");
    }

    return GestureDetector(
      onTap: () => returnShowDialog(),
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.05,
        ),
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.80,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSizes.size12,
              ),
            ),
          ),
          padding: EdgeInsets.only(
            left: screenWidth * 0.03,
            right: screenWidth * 0.03,
            top: screenHeight * 0.01,
            bottom: screenHeight * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: returnFormQuestionAndAnswer(false, 2, 2),
          ),
        ),
      ),
    );
  }

  List<Widget> returnFormQuestionAndAnswer(
      bool showDialog, int maxLinesQuestion, int maxLinesAnswer) {
    return [
      SmoothStarRating(
        rating: amountStars,
        isReadOnly: true,
        size: AppSizes.size20,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        defaultIconData: Icons.star_border,
        starCount: 5,
        allowHalfRating: true,
        color: Colors.yellow,
        borderColor: Colors.yellow,
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
              maxLines: 3,
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
              maxLines: 3,
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
