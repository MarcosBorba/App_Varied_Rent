import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

//TODO: nivel 4 - definir text
class SubTitleAd extends StatelessWidget {
  String valueAd;
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
    valueAd = CacheProvider.of(context).valueAd;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              "R\$ ",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize:
                    sizeTypeValue == null ? AppFontSize.s18 : sizeTypeValue,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              valueAd,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: sizeValueAd == null ? AppFontSize.s29 : sizeValueAd,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              typeValue,
              style: TextStyle(
                fontSize:
                    sizeTypeValue == null ? AppFontSize.s18 : sizeTypeValue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
