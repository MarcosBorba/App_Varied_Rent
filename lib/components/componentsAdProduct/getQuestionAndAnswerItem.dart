import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class QuestionAndAnswerItemAd extends StatelessWidget {
  final String question;
  final String answer;
  final String userNameQuestion;
  final String userNameAnswer;
  final String userEmailQuestion;
  final String dayTimeQuestion;
  final String dayTimeAnswer;
  final Color colorQuestionTitle;
  final Color colorAnswerTitle;
  final String textDefaultAnswerNull;
  final TextEditingController textController;
  final Function onSubmitted;
  final int indexQuestion;
  final Function onEditIconButtonPressed;
  String userLoggedEmail;
  String formatDate = DateFormat('y-M-d').format(DateTime.now());
  final GlobalKey<FormState> editQuestionFieldKey;
  final FocusNode focusTextField;

  QuestionAndAnswerItemAd({
    Key key,
    this.question,
    this.answer,
    this.userNameQuestion,
    this.userNameAnswer,
    this.userEmailQuestion,
    this.dayTimeQuestion,
    this.dayTimeAnswer,
    this.colorQuestionTitle = AppColors.adsProductQuestionTitle,
    this.colorAnswerTitle = AppColors.adsProductAnswerTitle,
    this.textDefaultAnswerNull = AppTexts.myAdsProductNoAnswer,
    this.textController,
    this.onSubmitted,
    this.indexQuestion,
    this.onEditIconButtonPressed,
    this.userLoggedEmail,
    this.editQuestionFieldKey,
    this.focusTextField,
  });
  @override
  Widget build(BuildContext context) {
    userLoggedEmail = CacheProviderAdProduct.of(context).userLoggedEmail;
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
      question == null
          ? Form(
              key: editQuestionFieldKey,
              child: TextFormField(
                controller: textController,
                onFieldSubmitted: onSubmitted,
                focusNode: focusTextField,
                autofocus: true,
                validator: FieldValidators().questionFormFieldValidator,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(),
                  hintText: "Edit Question User",
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 30,
                  ),
                  prefixIcon: Icon(
                    FontAwesome.right,
                    color: Colors.black,
                    size: AppSizes.size20,
                  ),
                ),
              ),
            )
          : Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: QuestionRow(
                    question: question,
                    maxLines: maxLinesQuestion,
                  ),
                ),
                answer == null &&
                        userEmailQuestion == userLoggedEmail &&
                        showDialog == false
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: AppColors.adsProductIconEditAnswer,
                          ),
                          onPressed: onEditIconButtonPressed,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(0),
                      )
              ],
            ),
      SizedBox(
        height: screenHeight * 0.02,
      ),
      answer == null
          ? Row(
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
            )
          : QuestionAndAnswerTitle(
              userName: userNameAnswer,
              dayTime: dayTimeAnswer,
              textColorsItems: colorAnswerTitle,
            ),
      returnAnswerToEdit(showDialog, maxLinesAnswer),
    ];
  }

  Widget returnAnswerToEdit(bool showDialog, int maxLinesAnswer) {
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
