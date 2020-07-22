import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:varied_rent/utils/utils.dart';

class AnswerRow extends StatelessWidget {
  final String answer;

  const AnswerRow({
    Key key,
    this.answer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          FontAwesome.right,
          size: AppSizes.size20,
        ),
        SizedBox(
          width: screenWidth * 0.03,
        ),
        Flexible(
          child: Text(
            answer,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
        )
      ],
    );
  }
}
