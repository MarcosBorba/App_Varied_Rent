import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editAdsPages/editAdsForm.dart';

class EditAdsPage extends StatefulWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String category;
  final String locator_fk;
  final List starsEvaluations;

  const EditAdsPage(
      {Key key,
      this.idAd,
      this.titleAd,
      this.descriptionAd,
      this.valueAd,
      this.imagesAd,
      this.category,
      this.locator_fk,
      this.starsEvaluations})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => EditAdsPageState(
        idAd: idAd,
        titleAd: titleAd,
        descriptionAd: descriptionAd,
        valueAd: valueAd,
        category: category,
        imagesAd: imagesAd,
        locator_fk: locator_fk,
        starsEvaluations: starsEvaluations,
      );
}

class EditAdsPageState extends State<EditAdsPage> {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String category;
  final String locator_fk;
  final List starsEvaluations;
  UniqueKey keyEditImages = new UniqueKey();

  EditAdsPageState({
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.category,
    this.imagesAd,
    this.locator_fk,
    this.starsEvaluations,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.editAdStatusBar,
        ),
        child: BlocProvider<EditAdsBloc>(
          create: (_) {
            AdRepository adRepository =
                AdRepository(adApiClient: AdApiCLient());
            return EditAdsBloc(adRepository: adRepository);
          },
          child: EditAdsForm(
            idAd: idAd,
            titleAd: titleAd,
            descriptionAd: descriptionAd,
            valueAd: valueAd,
            imagesAd: imagesAd,
            category: category,
            keyImages: keyEditImages,
            locator_fk: locator_fk,
            starsEvaluations: starsEvaluations,
          ),
        ),
      ),
    );
  }
}
