import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

class LoadingMyAdsProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
