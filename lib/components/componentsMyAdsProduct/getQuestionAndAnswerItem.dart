import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

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
  final Function onEditIconButtonPressed;
  final FocusNode answerFocusNode;
  final bool buttonEditVisibity;
  String formatDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  QuestionAndAnswerItem({
    Key key,
    @required this.question,
    this.answer,
    this.userNameQuestion,
    this.userNameAnswer,
    this.dayTimeQuestion,
    this.dayTimeAnswer,
    this.colorQuestionTitle = AppColors.adsProductQuestionTitle,
    this.colorAnswerTitle = AppColors.adsProductAnswerTitle,
    this.textDefaultAnswerNull = AppTexts.myAdsProductNoAnswer,
    this.textController,
    this.onSubmitted,
    this.indexQuestion,
    this.onEditIconButtonPressed,
    this.answerFocusNode,
    this.buttonEditVisibity,
  })  : assert(question != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    returnShowDialog() {
      dismissKeyboard();
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

  void showKeyboard() {
    answerFocusNode.requestFocus();
  }

  void dismissKeyboard() {
    answerFocusNode.unfocus();
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
      answer != null
          ? QuestionAndAnswerTitle(
              userName: userNameAnswer,
              dayTime: dayTimeAnswer,
              textColorsItems: colorAnswerTitle,
            )
          : answer == null && showDialog == false
              ? TextField(
                  controller: textController,
                  onSubmitted: onSubmitted,
                  focusNode: answerFocusNode,
                  onTap: () => showKeyboard,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(),
                    labelText: AppTexts().myAdsProductResponseTitle,
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
              : Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right: 12,
                        left: 2,
                      ),
                      child: Icon(
                        FontAwesome.right,
                        color: Colors.black,
                        size: AppSizes.size20,
                      ),
                    ),
                    Text("No answer yet."),
                  ],
                ),
      Row(
        children: <Widget>[
          returnAnswerToEdit(maxLinesAnswer),
          dayTimeAnswer == formatDate && showDialog == false
              ? Visibility(
                  visible: buttonEditVisibity,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.adsProductIconEditAnswer,
                      ),
                      onPressed: onEditIconButtonPressed,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(0),
                )
        ],
      ),
    ];
  }

  Widget returnAnswerToEdit(int maxLinesAnswer) {
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
