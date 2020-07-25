import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
//onSubmitted: () {

//a resposta envia pro banco só com o submit

//pega o controller text
//pega data
//pega nome locador

//muda para um estado de enviar resposta
//envia a resposta pro banco na questao x
//retorna se deu sucesso ou falha

//retorna um snack bar
//sucesso modifica a questao com a resposta
// },
//TODO: nivel 4 - definir texts,colors,sizes
class QuestionsAndAnswerContainer extends StatefulWidget {
  final List questionsAnswers;
  final Function onSubmitted;
  final Function onEditIconButtonPressed;
  final double containerHeight;
  final String userNameLocator;

  QuestionsAndAnswerContainer({
    Key key,
    this.questionsAnswers,
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
    this.userNameLocator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionsAndAnswerContainerState(
        questionsAnswers,
        onSubmitted,
        onEditIconButtonPressed,
        containerHeight,
        userNameLocator,
      );
}

class QuestionsAndAnswerContainerState
    extends State<QuestionsAndAnswerContainer> {
  final List questionsAnswers;
  final Function onSubmitted;
  final Function onEditIconButtonPressed;
  final double containerHeight;
  final String userNameLocator;

  QuestionsAndAnswerContainerState(
    this.questionsAnswers,
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
    this.userNameLocator,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight == null ? screenHeight * 0.20 : containerHeight,
      width: screenWidth,
      child: ListView.builder(
        itemCount: questionsAnswers.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context2, index) {
          return QuestionAndAnswerItem(
            userNameQuestion: questionsAnswers[index][0],
            dayTimeQuestion: questionsAnswers[index][1],
            question: questionsAnswers[index][2],
            userNameAnswer: questionsAnswers[index][3],
            dayTimeAnswer: questionsAnswers[index][4],
            answer: questionsAnswers[index][5],
            onSubmitted: (value) {
              String formattedDate =
                  DateFormat('d MMM yy').format(DateTime.now());
              setState(() {
                questionsAnswers[index][3] = userNameLocator;
                questionsAnswers[index][4] = formattedDate;
                questionsAnswers[index][5] = value;
              });
            },
            onEditIconButtonPressed: () {
              setState(() {
                questionsAnswers[index][3] = null;
                questionsAnswers[index][4] = null;
                questionsAnswers[index][5] = null;
              });
            },
          );
        },
      ),
    );
  }
}
