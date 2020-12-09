import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/adProduct_bloc/adProduct_bloc.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/adProductForm.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class AdProductPage extends StatelessWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String locatorFk;

  const AdProductPage({
    Key key,
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
    this.locatorFk,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.insertAdStatusBar,
        ),
        child: BlocProvider<AdProductPageBloc>(
          create: (_) {
            AdRepository adRepository =
                AdRepository(adApiClient: AdApiCLient());

            return AdProductPageBloc(
              adRepository: adRepository,
            )..add(
                AdProductPageGetInfoAd(
                  idAd,
                  locatorFk,
                ),
              );
          },
          child: BlocListener<AdProductPageBloc, AdProductPageState>(
            listener: (context, state) {
              if (state is FailureAdProductPage) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
            child: BlocBuilder<AdProductPageBloc, AdProductPageState>(
              builder: (context, state) {
                return CacheProviderAdProduct(
                  titleAd,
                  descriptionAd,
                  valueAd,
                  imagesAd,
                  AdProductForm(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
