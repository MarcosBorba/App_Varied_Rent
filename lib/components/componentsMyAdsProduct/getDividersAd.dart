import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class DividersAd extends StatelessWidget {
  final double spaceTop;
  final double spaceBottom;
  final String textTitleDivider;

  const DividersAd({
    Key key,
    this.spaceTop,
    this.spaceBottom,
    this.textTitleDivider,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: spaceTop == null ? screenHeight * 0.05 : spaceTop,
        bottom: spaceBottom == null ? screenHeight * 0.05 : spaceBottom,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Divider(
              endIndent: AppSizes.size10,
              indent: AppSizes.size10,
              thickness: AppSizes.size2,
            ),
          ),
          Text(textTitleDivider),
          Expanded(
            flex: 8,
            child: Divider(
              endIndent: AppSizes.size10,
              indent: AppSizes.size10,
              thickness: AppSizes.size2,
            ),
          ),
        ],
      ),
    );
  }
}
