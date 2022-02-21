import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

//TODO: nivel 4 - olhar sizes,colors,texts, e estado favorite u nao
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
    String idAd = CacheProviderAdProduct.of(context).idAd;
    String idUserLogged = CacheProviderAdProduct.of(context).userLoggedId;
    bool isFavorite = CacheProviderAdProduct.of(context).isFavorite;
    bool isAnAnnouncementOfTheLoggedUser =
        CacheProviderAdProduct.of(context).isAnAnnouncementOfTheLoggedUser;
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
          isAnAnnouncementOfTheLoggedUser
              ? Padding(
                  padding: EdgeInsets.all(0),
                )
              : Expanded(
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
                        isFavorite
                            ? BlocProvider.of<AdProductPageBloc>(context).add(
                                AdProductPageRemoveFavoriteAd(
                                    idAd, idUserLogged))
                            : BlocProvider.of<AdProductPageBloc>(context).add(
                                AdProductPageAddFavoriteAd(idAd, idUserLogged));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isFavorite
                              ? Icon(
                                  FontAwesome5.heart,
                                  color: Colors.red,
                                  size: AppSizes.size35,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                  size: AppSizes.size35,
                                )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
