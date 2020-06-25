import 'package:flutter/material.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_text_sizes.dart';

class FlatButtonLinkForScreenNavigation extends StatelessWidget {
  final Color splashColor;
  final Function onPressed;
  final String textButton;

  const FlatButtonLinkForScreenNavigation(
      {Key key, this.splashColor, this.onPressed, this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        splashColor: splashColor,
        onPressed: onPressed,
        child: Text(
          textButton,
          style: TextStyle(
              fontSize: AppFontSize.s14,
              color: AppColors().defaultSubtitleColor),
        ));
  }
}
