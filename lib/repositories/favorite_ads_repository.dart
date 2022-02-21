import 'package:flutter/material.dart';
import 'package:varied_rent/repositories/favorite_ads_api_client.dart';

class FavoriteAdRepository {
  final FavoriteAdApiCLient favoriteAdApiClient;

  FavoriteAdRepository({@required this.favoriteAdApiClient})
      : assert(favoriteAdApiClient != null);

  Future getFavoriteAdRepository(String idUserLoggedIn, String token) async {
    List ads = await favoriteAdApiClient.getFavoriteAds(idUserLoggedIn, token);
    return ads;
  }

  Future deleteFavoriteAdRepository(
      String id, String locatorFk, String token) async {
    await favoriteAdApiClient.deleteFavoriteAd(id, locatorFk, token);
  }

  Future addFavoriteAdRepository(
      String id, String locatorFk, String token) async {
    print("repository");
    await favoriteAdApiClient.addFavoriteAd(id, locatorFk, token);
  }
}
