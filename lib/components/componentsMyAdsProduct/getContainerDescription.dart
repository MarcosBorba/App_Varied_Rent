import 'package:flutter/material.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class Description extends StatelessWidget {
  final int maxLines;
  final Color textDescriptionColor;

  Description({
    Key key,
    this.maxLines = 200,
    this.textDescriptionColor = AppColors.adsProducttextDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String textDescription = CacheProvider.of(context).descriptionAd;
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      child: TextField(
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          hintMaxLines: maxLines,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.size12,
            ),
            borderSide: BorderSide(
              width: 2,
              color: AppColors.adsProductBorderDescription,
            ),
          ),
          hintText: textDescription.toString(),
          hintStyle: TextStyle(
            color: textDescriptionColor,
          ),
        ),
      ),
    );
  }
}
