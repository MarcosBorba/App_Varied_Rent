import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel - 3 - definir colors, texts, sizes, otimizar codigo e depois aplicar bloc
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
  final TextEditingController textController;
  final Function onSubmitted;
  final int indexQuestion;
  String formatDate = DateFormat('d MMM yy').format(DateTime.now());
  final Function onEditIconButtonPressed;

  QuestionAndAnswerItem({
    Key key,
    @required this.question,
    this.answer,
    this.userNameQuestion = "Marcos Flavio Ferreira Borba",
    this.userNameAnswer,
    this.dayTimeQuestion,
    this.dayTimeAnswer,
    this.colorQuestionTitle = Colors.blue,
    this.colorAnswerTitle = Colors.green,
    this.textDefaultAnswerNull = "Nao há resposta ainda",
    this.textController,
    this.onSubmitted,
    this.indexQuestion,
    this.onEditIconButtonPressed,
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
              controller: textController,
              onSubmitted: onSubmitted,
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
      Row(
        children: <Widget>[
          returna(showDialog, maxLinesAnswer),
          dayTimeAnswer == formatDate
              ? Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: onEditIconButtonPressed,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(
                    0,
                  ),
                )
        ],
      ),
    ];
  }

  Widget returna(bool showDialog, int maxLinesAnswer) {
    if (answer != null) {
      return Flexible(
        flex: 1,
        child: AnswerRow(
          answer: answer == null ? textDefaultAnswerNull : answer,
          maxLines: maxLinesAnswer,
          dataTimeAnswer: dayTimeAnswer,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(0),
      );
    }
  }
}
