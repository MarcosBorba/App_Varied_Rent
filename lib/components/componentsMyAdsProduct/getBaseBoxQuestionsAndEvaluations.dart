import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class BaseBoxQuestionsAndEvaluations extends StatelessWidget {
  final List<Widget> listComponents;

  BaseBoxQuestionsAndEvaluations({
    Key key,
    this.listComponents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      child: Container(
        height: screenHeight * 0.20,
        width: screenWidth * 0.80,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.adsProductBaseBoxQuestionsAndEvaluations,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: listComponents,
        ),
      ),
    );
  }
}
