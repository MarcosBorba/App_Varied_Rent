import 'package:flutter/material.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class AdProductForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdProductFormState();
}

class AdProductFormState extends State<AdProductForm> {
  String title;
  String description;
  String value;
  List images;

  @override
  Widget build(BuildContext context) {
    description = CacheProviderAdProduct.of(context).descriptionAd;
    images = CacheProviderAdProduct.of(context).imagesAd;
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: SafeArea(
          child: ListView(
        children: <Widget>[
          returnHeaderProduct(),
          returnSubTitleProduct(),
          returnImagesAdProduct(),
          returnDivider(AppTexts().myAdsProductDescription),
          returnDescription(),
          returnDivider(AppTexts().myAdsProductQuestions),
          returnDivider(AppTexts().myAdsProductEvaluations),
          returnDivider(AppTexts().myAdsProductLocator),
          returnLocatorInfo(),
          Padding(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.05,
            ),
          )
        ],
      )),
    );
  }

  Widget returnHeaderProduct() {
    return new MaterialAdTitle();
  }

  Widget returnSubTitleProduct() {
    return SubTitleAdProduct();
  }

  Widget returnImagesAdProduct() {
    return ImagesAdProduct();
  }

  Widget returnDescription() {
    return DescriptionProduct();
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(
      textTitleDivider: textDivider,
    );
  }

  Widget returnLocatorInfo() {
    return LocatorInfoAdProduct();
  }
}
