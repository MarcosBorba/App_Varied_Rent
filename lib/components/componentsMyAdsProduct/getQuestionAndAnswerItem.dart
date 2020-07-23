import 'package:flutter/material.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getAnswerRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionAndAnswerTitle.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getShowDialogQuestionAndAnswer.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel - 3 - definir colors, texts, sizes
class QuestionAndAnswerItem extends StatelessWidget {
  final String question;
  final String answer;
  final String userNameQuestion;
  final String userNameAnswer;
  final String dayTimeQuestion;
  final String dayTimeAnswer;
  final Color colorQuestionTitle;
  final Color colorAnswerTitle;
  final String textDefaultAnswerNull;

  const QuestionAndAnswerItem({
    Key key,
    @required this.question,
    this.answer,
    this.userNameQuestion = "Joao Ferreira Borba borba do borba com borba",
    this.userNameAnswer = "Marcos Damaceno Vieira Comercios",
    this.dayTimeQuestion = "05 Jun 17",
    this.dayTimeAnswer = "05 Jun 17",
    this.colorQuestionTitle = Colors.blue,
    this.colorAnswerTitle = Colors.green,
    this.textDefaultAnswerNull = "Nao há resposta ainda",
  })  : assert(question != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    returnShowDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowDialogQuestionAndAnswer(
              questionAndAnswer: returnFormQuestionAndAnswer(true, 100, 100),
            );
          });
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
      QuestionAndAnswerTitle(
        userName: userNameQuestion,
        dayTime: dayTimeQuestion,
        textColorsItems: colorQuestionTitle,
      ),
      showDialog
          ? QuestionRow(
              question: question,
              maxLines: maxLinesQuestion,
            )
          : Flexible(
              flex: 1,
              child: QuestionRow(
                question: question,
                maxLines: maxLinesQuestion,
              ),
            ),
      SizedBox(
        height: screenHeight * 0.02,
      ),
      answer == null
          ? Text("")
          : QuestionAndAnswerTitle(
              userName: userNameAnswer,
              dayTime: dayTimeAnswer,
              textColorsItems: colorAnswerTitle,
            ),
      showDialog
          ? AnswerRow(
              answer: answer == null ? textDefaultAnswerNull : answer,
              maxLines: maxLinesAnswer,
            )
          : Flexible(
              flex: 1,
              child: AnswerRow(
                answer: answer == null ? textDefaultAnswerNull : answer,
                maxLines: maxLinesAnswer,
              ),
            ),
    ];
  }
}
