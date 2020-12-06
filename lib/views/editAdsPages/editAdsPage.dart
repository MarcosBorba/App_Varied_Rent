import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editAdsPages/editAdsForm.dart';

class EditAdsPage extends StatefulWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String category;

  const EditAdsPage(
      {Key key,
      this.idAd,
      this.titleAd,
      this.descriptionAd,
      this.valueAd,
      this.imagesAd,
      this.category})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => EditAdsPageState(
        idAd: idAd,
        titleAd: titleAd,
        descriptionAd: descriptionAd,
        valueAd: valueAd,
        category: category,
        imagesAd: imagesAd,
      );
}

class EditAdsPageState extends State<EditAdsPage> {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String category;
  UniqueKey keyEditImages = new UniqueKey();

  EditAdsPageState({
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.category,
    this.imagesAd,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColors.insertAdStatusBar,
          ),
          child: EditAdsForm(
            idAd: idAd,
            titleAd: titleAd,
            descriptionAd: descriptionAd,
            valueAd: valueAd,
            imagesAd: imagesAd,
            category: category,
            keyImages: keyEditImages,
          )),
    );
  }
}
