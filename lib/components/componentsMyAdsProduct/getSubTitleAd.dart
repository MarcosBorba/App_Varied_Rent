import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';

//TODO: nivel 4 - definir text
class SubTitleAd extends StatelessWidget {
  final String valueAd;
  final double sizeValueAd;
  final String typeValue;
  final double sizeTypeValue;

  SubTitleAd({
    Key key,
    this.valueAd = "R\$ 2,00",
    this.sizeValueAd,
    this.typeValue = " / Hr",
    this.sizeTypeValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            valueAd,
            style: TextStyle(
              fontSize: sizeValueAd == null ? AppFontSize.s29 : sizeValueAd,
            ),
          ),
          Text(
            typeValue,
            style: TextStyle(
              fontSize: sizeTypeValue == null ? AppFontSize.s18 : sizeTypeValue,
            ),
          ),
        ],
      ),
    );
  }
}
