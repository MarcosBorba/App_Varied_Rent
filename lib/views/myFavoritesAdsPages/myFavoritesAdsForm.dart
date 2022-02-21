import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/adProductPage.dart';
import 'package:varied_rent/views/myFavoritesAdsPages/myFavoritesAdsProductInheritedClass.dart';

class MyFavoritesAdsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFavoritesAdsFormState();
}

class MyFavoritesAdsFormState extends State<MyFavoritesAdsForm> {
  double heightBodyScaffold = screenHeight - statusBarHeight;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteAdsBloc, FavoriteAdsState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: screenHeight,
            width: screenWidth,
            color: Colors.white,
            child: state is FavoriteAdsLoading
                ? Center(child: CircularProgressIndicator())
                : state is FavoriteAdsFailure
                    ? returnBodyOnFailure()
                    : state is ShowFavoriteAdsPage
                        ? state.ads.length > 0
                            ? CacheProviderFavoriteAds(
                                state.ads,
                                RefreshIndicator(
                                  onRefresh: () async {
                                    return BlocProvider.of<FavoriteAdsBloc>(
                                            context)
                                        .add(FavoriteAdsPageStarted());
                                  },
                                  child: ListView.builder(
                                      itemCount: state.ads.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: heightBodyScaffold * 0.30,
                                          width: screenWidth,
                                          color: Colors.white,
                                          margin: EdgeInsets.only(
                                              top: AppSizes.size8,
                                              bottom: (state.ads.length - 1) ==
                                                      index
                                                  ? AppSizes.size85
                                                  : 0),
                                          child: FavoriteAdMaterialButton(
                                            indexListAds: index,
                                            elevationButton: AppSizes.size4,
                                            onPressedFavoriteAd: () async {
                                              await navigationToTheAdScreen(
                                                state.ads[index].id,
                                                state.ads[index].title,
                                                state.ads[index].description,
                                                state.ads[index].value,
                                                state.ads[index].images,
                                                state.ads[index].locator_fk,
                                              );
                                            },
                                            onPressedDeleteFavoriteAd:
                                                () async {
                                              await deleteTheFavoriteAd(
                                                  state.ads[index].id,
                                                  state.ads[index].locator_fk,
                                                  state.ads,
                                                  index);
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  return BlocProvider.of<FavoriteAdsBloc>(
                                          context)
                                      .add(FavoriteAdsPageStarted());
                                },
                                child: ListView(
                                  children: <Widget>[
                                    Container(
                                      height: heightBodyScaffold,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: AppSizes.size12,
                                          right: AppSizes.size12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              FontAwesome5.heart_broken,
                                              color: Colors.red,
                                              size: AppSizes.size50,
                                            ),
                                            SizedBox(
                                              height: AppSizes.size10,
                                            ),
                                            Text(
                                              "You don't have any favorites yet",
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : returnBodyOnFailure(),
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
      String valueAd, List imagesAd, String locatorFk) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdProductPage(
          idAd: id,
          titleAd: titleAd,
          descriptionAd: descriptionAd,
          valueAd: valueAd,
          imagesAd: imagesAd,
          locatorFk: locatorFk,
          comesFromTheFavoritePage: true,
        ),
      ),
    );
    if (result != null) BlocProvider.of<FavoriteAdsBloc>(context).add(result);
  }

  deleteTheFavoriteAd(String adId, String locatorFk, List<Ad> ads, int index) {
    print("delete favorite ad");
    showDialog(
      context: context,
      builder: (context) =>
          returnAlertDialogOnDeleteFavoriteAd(adId, locatorFk, ads, index),
    );
  }

  Widget returnAlertDialogOnDeleteFavoriteAd(
      String adId, String locatorFk, List<Ad> ads, int index) {
    return AlertDialog(
      title: Text(
        "Deleting Favorite Ad",
        textAlign: TextAlign.center,
      ),
      content: Text(
        "You are about to remove a favorite from an ad, \n are you sure you want to remove the favorite from the ad?",
        textAlign: TextAlign.center,
      ),
      elevation: 24.0,
      actions: [
        FlatButton(
          child: Text(
            "No",
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: () => AppRoutes.pop(context),
        ),
        FlatButton(
          child: Row(
            children: [
              Icon(
                FontAwesome5.heart_broken,
                color: Colors.red,
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(18.0),
          ),
          onPressed: () {
            BlocProvider.of<FavoriteAdsBloc>(context).add(
              FavoriteAdDeleteAd(
                adId,
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

  @override
  void dispose() {
    super.dispose();
  }
}
