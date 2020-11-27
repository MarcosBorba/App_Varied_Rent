import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProduct.dart';
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
  final Function onSubmitted;
  final Function onEditIconButtonPressed;
  final double containerHeight;
  final String userNameLocator;

  QuestionsAndAnswerContainer({
    Key key,
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
    this.userNameLocator,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionsAndAnswerContainerState(
        onSubmitted: onSubmitted,
        onEditIconButtonPressed: onEditIconButtonPressed,
        containerHeight: containerHeight,
        userNameLocator: userNameLocator,
      );
}

class QuestionsAndAnswerContainerState
    extends State<QuestionsAndAnswerContainer> {
  List<QuestionAndAnswer> questionsAnswers;
  Function onSubmitted;
  Function onEditIconButtonPressed;
  double containerHeight;
  String userNameLocator;

  QuestionsAndAnswerContainerState({
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
    this.userNameLocator,
  });

  @override
  Widget build(BuildContext context) {
    questionsAnswers = CacheProvider.of(context).questionsAndAnswers;
    return Container(
      height: containerHeight == null ? screenHeight * 0.20 : containerHeight,
      width: screenWidth,
      child: questionsAnswers != null && questionsAnswers.length > 0
          ? ListView.builder(
              itemCount: questionsAnswers != null ? questionsAnswers.length : 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context2, index) {
                return QuestionAndAnswerItem(
                  userNameQuestion:
                      questionsAnswers[index].question.tenant_name,
                  dayTimeQuestion:
                      questionsAnswers[index].question.question_date_time,
                  question: questionsAnswers[index].question.question,
                  userNameAnswer: questionsAnswers[index].answer != null
                      ? questionsAnswers[index].answer.locator_name
                      : null,
                  dayTimeAnswer: questionsAnswers[index].answer != null
                      ? questionsAnswers[index].answer.answer_date_time
                      : null,
                  answer: questionsAnswers[index].answer != null
                      ? questionsAnswers[index].answer.answer
                      : null,
                  onSubmitted: (value) {
                    String formattedDate =
                        DateFormat('d MMM yy').format(DateTime.now());
                    setState(() {
                      questionsAnswers[index].answer.locator_email =
                          "mano@gmail.com";
                      questionsAnswers[index].answer.locator_name =
                          "Marcos Flavio Ferreira Borba";
                      questionsAnswers[index].answer.answer_date_time =
                          formattedDate;
                      questionsAnswers[index].answer.answer = value;
                    });
                  },
                  onEditIconButtonPressed: () {
                    setState(() {
                      questionsAnswers[index].answer.locator_name = null;
                      questionsAnswers[index].answer.answer_date_time = null;
                      questionsAnswers[index].answer.answer = null;
                    });
                  },
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.question_answer,
                  color: AppColors.tertiaryColor,
                  size: AppSizes.size50,
                ),
                SizedBox(
                  height: AppSizes.size20,
                ),
                Text(
                  "This ad has no questions yet!",
                  style: TextStyle(fontSize: AppFontSize.s18),
                ),
              ],
            ),
    );
  }
}
