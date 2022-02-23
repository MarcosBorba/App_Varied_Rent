import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

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
  TextEditingController textController = TextEditingController();
  FocusNode answerFocusNode = FocusNode();
  bool buttonEditVisibility = true;

  QuestionsAndAnswerContainerState({
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
    this.userNameLocator,
  });

  @override
  void dispose() {
    textController.dispose();
    answerFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    questionsAnswers = CacheProvider.of(context).questionsAndAnswers;
    userNameLocator = CacheProvider.of(context).nameLocator;
    String emailLocator = CacheProvider.of(context).emailLocator;

    return Container(
      height: containerHeight == null ? screenHeight * 0.20 : containerHeight,
      width: screenWidth,
      child: questionsAnswers != null && questionsAnswers.length > 0
          ? ListView.builder(
              itemCount: questionsAnswers != null ? questionsAnswers.length : 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return QuestionAndAnswerItem(
                  textController: textController,
                  answerFocusNode: answerFocusNode,
                  buttonEditVisibity: buttonEditVisibility,
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
                  onSubmitted: (String value) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                    setState(() {
                      questionsAnswers[index].answer.answer == null &&
                              value.length > 1
                          ? {
                              questionsAnswers[index].answer = new Answer(
                                locator_name: userNameLocator,
                                locator_email: emailLocator,
                                answer_date_time: formattedDate,
                                answer: value,
                              ),
                              BlocProvider.of<MyAdProductPageBloc>(context).add(
                                MyAdProductPageUpdateQuestionAndEvaluation(
                                  questionsAnswers[index],
                                ),
                              ),
                              buttonEditVisibility = true,
                            }
                          : {
                              answerFocusNode.unfocus(),
                              buttonEditVisibility = false
                            };
                    });
                  },
                  onEditIconButtonPressed: () {
                    setState(() {
                      textController.text =
                          questionsAnswers[index].answer.answer;
                      questionsAnswers[index].answer.answer = null;
                      answerFocusNode.requestFocus();
                      buttonEditVisibility = false;
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
                  color: AppColors.adsProductIconNoQuestion,
                  size: AppSizes.size50,
                ),
                SizedBox(
                  height: AppSizes.size20,
                ),
                Text(
                  AppTexts().myAdsProductNoQuestions,
                  style: TextStyle(fontSize: AppFontSize.s18),
                ),
              ],
            ),
    );
  }
}
