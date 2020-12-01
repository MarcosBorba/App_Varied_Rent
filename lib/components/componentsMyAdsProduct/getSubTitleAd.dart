import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class SubTitleAd extends StatelessWidget {
  final double sizeValueAd;
  final String typeValue;
  final double sizeTypeValue;

  SubTitleAd({
    Key key,
    this.sizeValueAd,
    this.typeValue,
    this.sizeTypeValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String valueAd = CacheProvider.of(context).valueAd;
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
              AppTexts().myAdsProductTypeCoin,
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
              AppTexts().myAdsProductTypeValue,
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
