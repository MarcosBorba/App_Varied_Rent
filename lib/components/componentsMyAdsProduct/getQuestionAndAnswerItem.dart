import 'package:flutter/material.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getAnswerRow.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionRow.dart';
import 'package:varied_rent/utils/utils.dart';

class QuestionAndAnswerItem extends StatelessWidget {
  final String question;
  final String answer;

  const QuestionAndAnswerItem({
    Key key,
    @required this.question,
    this.answer,
  })  : assert(question != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    returnShowDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.red[100],
              child: Container(
                height: screenHeight * 0.35,
                width: screenWidth,
                child: Text("oláaááá"),
              ),
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
          width: screenWidth,
          decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            left: screenWidth * 0.03,
            right: screenWidth * 0.03,
          ),
          child: Column(
            children: <Widget>[
              QuestionRow(question: question),
              SizedBox(height: screenHeight * 0.02),
              AnswerRow(answer: answer)
            ],
          ),
        ),
      ),
    );
  }
}
