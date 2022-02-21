import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:varied_rent/utils/utils.dart';

class QuestionRow extends StatelessWidget {
  final String question;
  final int maxLines;

  const QuestionRow({
    Key key,
    @required this.question,
    this.maxLines,
  })  : assert(question != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          FontAwesome.left,
          size: AppSizes.size20,
        ),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        Flexible(
          flex: 1,
          child: Text(
            question,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: TextStyle(
              fontSize: AppFontSize.s14,
            ),
          ),
        )
      ],
    );
  }
}
