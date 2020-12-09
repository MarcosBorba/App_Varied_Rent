import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class SubTitleAdProduct extends StatelessWidget {
  final double sizeValueAd;
  final String typeValue;
  final double sizeTypeValue;

  SubTitleAdProduct({
    Key key,
    this.sizeValueAd,
    this.typeValue,
    this.sizeTypeValue,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String valueAd = CacheProviderAdProduct.of(context).valueAd;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            flex: 3,
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
          Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    print("object");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesome5.heart,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
