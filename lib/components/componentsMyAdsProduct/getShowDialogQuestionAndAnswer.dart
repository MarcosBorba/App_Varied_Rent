import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class ShowDialogQuestionAndAnswer extends StatelessWidget {
  final List<Widget> questionAndAnswer;

  const ShowDialogQuestionAndAnswer({
    Key key,
    this.questionAndAnswer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.size12,
        ),
      ),
      child: Container(
        height: screenHeight * 0.40,
        width: screenWidth,
        decoration: BoxDecoration(
          border: Border.all(
            width: AppSizes.size2,
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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: questionAndAnswer,
          ),
        ),
      ),
    );
  }
}
