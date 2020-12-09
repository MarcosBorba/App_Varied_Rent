import 'package:flutter/material.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class LocatorInfoAdProduct extends StatelessWidget {
  final double heightContainer;
  final double sizeNameText;
  final double sizeLandlordTypeText;
  final double sizeTitleTelephonesText;
  final double sizeTelephonesText;
  final String textTitleTelephone;

  LocatorInfoAdProduct({
    Key key,
    this.heightContainer,
    this.sizeNameText,
    this.sizeLandlordTypeText,
    this.sizeTitleTelephonesText,
    this.sizeTelephonesText,
    this.textTitleTelephone = AppTexts.myAdsProductLocatorTelephones,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /* String nameLocator = CacheProvider.of(context).nameLocator;
    String landlordTypeLocator = CacheProvider.of(context).landlordTypeLocator;
    String telephone1 = CacheProvider.of(context).telephone1;
    String telephone2 = CacheProvider.of(context).telephone2; */
    String nameLocator = "NameLocator";
    String landlordTypeLocator = "Particulerio";
    String telephone1 = "ulallau";
    String telephone2 = "rashi no baki";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //TODO: nivel 1 - buscar forma de colocar imagem do usuario aqui
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(AppSizes.size12),
            child: ImageLogoApp(),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height:
                heightContainer == null ? screenHeight * 0.25 : heightContainer,
            width: screenWidth,
            margin: EdgeInsets.all(AppSizes.size12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  nameLocator.toString(),
                  style: TextStyle(
                    fontSize:
                        sizeNameText == null ? AppFontSize.s18 : sizeNameText,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.00500,
                    bottom: screenHeight * 0.00500,
                  ),
                  child: Divider(
                    indent: 10,
                    endIndent: 10,
                    thickness: 1,
                  ),
                ),
                Text(
                  landlordTypeLocator.toString(),
                  style: TextStyle(
                    fontSize: sizeLandlordTypeText == null
                        ? AppFontSize.s16
                        : sizeLandlordTypeText,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.00500,
                    bottom: screenHeight * 0.00500,
                  ),
                  child: Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 1,
                  ),
                ),
                Text(
                  textTitleTelephone,
                  style: TextStyle(
                    fontSize: sizeTitleTelephonesText == null
                        ? AppFontSize.s15
                        : sizeTitleTelephonesText,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  telephone1.toString() + "         " + telephone2.toString(),
                  style: TextStyle(
                    fontSize: sizeTelephonesText == null
                        ? AppFontSize.s13
                        : sizeTelephonesText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
