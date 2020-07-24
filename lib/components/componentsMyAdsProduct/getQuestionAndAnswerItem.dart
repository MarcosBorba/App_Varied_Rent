import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getAnswerRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getBaseBoxQuestionsAndEvaluations.dart';
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
      child: BaseBoxQuestionsAndEvaluations(
        listComponents: returnFormQuestionAndAnswer(false, 2, 2),
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
          ? TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(),
                labelText: "Response user",
                prefixIconConstraints: BoxConstraints(
                  minWidth: 30,
                ),
                prefixIcon: Icon(
                  FontAwesome.right,
                  color: Colors.black,
                  size: AppSizes.size20,
                ),
              ),
            )
          : QuestionAndAnswerTitle(
              userName: userNameAnswer,
              dayTime: dayTimeAnswer,
              textColorsItems: colorAnswerTitle,
            ),
      returna(showDialog, maxLinesAnswer),
    ];
  }

  Widget returna(bool showDialog, int maxLinesAnswer) {
    if (answer != null) {
      return showDialog
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
            );
    } else {
      return Padding(
        padding: EdgeInsets.all(0),
      );
    }
  }
}
