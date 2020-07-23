import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class QuestionAndAnswerTitle extends StatelessWidget {
  final String userName;
  final String dayTime;
  final Color textColorsItems;

  const QuestionAndAnswerTitle({
    Key key,
    this.userName,
    this.dayTime,
    this.textColorsItems,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * 0.01),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppFontSize.s12,
                  color: textColorsItems,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              dayTime,
              style: TextStyle(
                fontSize: AppFontSize.s12,
                color: textColorsItems,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
