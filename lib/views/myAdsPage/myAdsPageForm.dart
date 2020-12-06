import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editAdsPages/editAdsPage.dart';
import 'package:varied_rent/views/editAdsPages/editAdsProductInheritedClass.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductPage.dart';

class MyAdsPageForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageFormState();
}

class MyAdsPageFormState extends State<MyAdsPageForm> {
  double heightBodyScaffold = screenHeight - AppSizes.size60 - statusBarHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAdProductBloc, MyAdProductState>(
      builder: (context, state) {
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: AppColors.transparentBackground,
            ),
            child: Container(
              height: screenHeight,
              width: screenWidth,
              child: state is LoadingMyAdProduct
                  ? Center(child: CircularProgressIndicator())
                  : state is FailureMyAdProduct
                      ? returnBodyOnFailure()
                      : state is ShowMyAdProduct
                          ? state.ads.length > 0
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    BlocProvider.of<MyAdProductBloc>(context)
                                        .add(MyAdsPageStarted());
                                  },
                                  child: ListView.builder(
                                    itemCount: state.ads.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        height: heightBodyScaffold * 0.30,
                                        width: screenWidth,
                                        margin: EdgeInsets.only(
                                            top: AppSizes.size8,
                                            bottom:
                                                (state.ads.length - 1) == index
                                                    ? AppSizes.size85
                                                    : 0),
                                        child: AdsMaterialButton(
                                          listAds: state.ads,
                                          indexListAds: index,
                                          elevationButton: AppSizes.size4,
                                          onPressedAds: () {
                                            navigationToTheAdScreen(
                                              state.ads[index].id,
                                              state.ads[index].title,
                                              state.ads[index].description,
                                              state.ads[index].value,
                                              state.ads[index].images,
                                            );
                                          },
                                          onPressedEditAds: () {
                                            navigationToTheEditAdScreen(
                                              state.ads[index].id,
                                              state.ads[index].title,
                                              state.ads[index].description,
                                              state.ads[index].value,
                                              state.ads[index].images,
                                              state.ads[index].category,
                                            );
                                          },
                                          onPressedDeleteAds: () {
                                            deleteTheAd(state.ads[index].id,
                                                state.ads, index);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: AppSizes.size12,
                                      right: AppSizes.size12,
                                    ),
                                    child: Text(
                                      AppTexts().myAdsNoAdsCreated,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                          : returnBodyOnFailure(),
            ),
          ),
        );
      },
    );
  }

  Widget returnBodyOnFailure() {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.size12,
        right: AppSizes.size12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: AppColors.myAdsIconOnFailure,
            size: AppSizes.size50,
          ),
          Text(
            AppTexts().myAdsErrorOnSearchAds,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  navigationToTheAdScreen(String id, String titleAd, String descriptionAd,
      String valueAd, List imagesAd) {
    AppRoutes.push(
        context,
        MyAdsProductPage(
          idAd: id,
          titleAd: titleAd,
          descriptionAd: descriptionAd,
          valueAd: valueAd,
          imagesAd: imagesAd,
        ));
  }

  navigationToTheEditAdScreen(String id, String titleAd, String descriptionAd,
      String valueAd, List imagesAd, String category) async {
    AppRoutes.push(
      context,
      EditAdsPage(
        idAd: id,
        titleAd: titleAd,
        descriptionAd: descriptionAd,
        valueAd: valueAd,
        imagesAd: imagesAd,
        category: category,
      ),
    );
  }

  deleteTheAd(String id, List<Ad> ads, int index) {
    showDialog(
      context: context,
      builder: (context) => returnAlertDialogOnDeleteAd(id, ads, index),
    );
  }

  Widget returnAlertDialogOnDeleteAd(String id, List<Ad> ads, int index) {
    return AlertDialog(
      title: Text(
        AppTexts().myAdsDeletingAds,
        textAlign: TextAlign.center,
      ),
      content: Text(
        AppTexts().myAdsDeletingAdsExplanation,
        textAlign: TextAlign.center,
      ),
      elevation: 24.0,
      actions: [
        FlatButton(
          child: Text(
            AppTexts().myAdsDeletingAdsNotConfirm,
          ),
          onPressed: () {
            AppRoutes.pop(context);
          },
        ),
        FlatButton(
          child: Text(AppTexts().myAdsDeletingAdsConfirm),
          color: Colors.red,
          onPressed: () {
            BlocProvider.of<MyAdProductBloc>(context).add(
              MyAdsPageDeleteAd(
                id,
                ads,
                index,
              ),
            );
            AppRoutes.pop(context);
          },
        ),
      ],
    );
  }
}
