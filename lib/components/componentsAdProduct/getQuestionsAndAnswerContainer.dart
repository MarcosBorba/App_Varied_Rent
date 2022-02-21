import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class QuestionsAndAnswerAdContainer extends StatefulWidget {
  final Function onSubmitted;
  final Function onEditIconButtonPressed;
  final double containerHeight;

  QuestionsAndAnswerAdContainer({
    Key key,
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => QuestionsAndAnswerAdContainerState(
        onSubmitted: onSubmitted,
        onEditIconButtonPressed: onEditIconButtonPressed,
        containerHeight: containerHeight,
      );
}

class QuestionsAndAnswerAdContainerState
    extends State<QuestionsAndAnswerAdContainer> {
  List<QuestionAndAnswer> questionsAnswers;
  Function onSubmitted;
  Function onEditIconButtonPressed;
  double containerHeight;
  TextEditingController textControllerEditQuestion = TextEditingController();
  GlobalKey<FormState> _editQuestionFieldKey = GlobalKey();
  FocusNode focusTextField = FocusNode();

  QuestionsAndAnswerAdContainerState({
    this.onSubmitted,
    this.onEditIconButtonPressed,
    this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    questionsAnswers = CacheProviderAdProduct.of(context).questionsAndAnswers;
    return Container(
      height: containerHeight == null ? screenHeight * 0.20 : containerHeight,
      width: screenWidth,
      child: questionsAnswers != null && questionsAnswers.length > 0
          ? ListView.builder(
              itemCount: questionsAnswers != null ? questionsAnswers.length : 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return QuestionAndAnswerItemAd(
                  userNameQuestion:
                      questionsAnswers[index].question.tenant_name,
                  userEmailQuestion:
                      questionsAnswers[index].question.tenant_email,
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
                  textController: textControllerEditQuestion,
                  editQuestionFieldKey: _editQuestionFieldKey,
                  focusTextField: focusTextField,
                  onSubmitted: (value) {
                    _editQuestionFieldKey.currentState.validate()
                        ? {
                            focusTextField.unfocus(),
                            textControllerEditQuestion.clear(),
                            setState(() {
                              questionsAnswers[index].question.question = value;
                              BlocProvider.of<AdProductPageBloc>(context).add(
                                  AdProductPageEditQuestionAd(
                                      questionsAnswers[index]));
                            })
                          }
                        : FocusScope.of(context).requestFocus(focusTextField);
                  },
                  onEditIconButtonPressed: () {
                    setState(() {
                      textControllerEditQuestion.text =
                          questionsAnswers[index].question.question;
                      questionsAnswers[index].question.question = null;
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

  @override
  void dispose() {
    super.dispose();
    focusTextField.dispose();
    textControllerEditQuestion.dispose();
  }
}
