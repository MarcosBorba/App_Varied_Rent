import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_api_client.dart';

class AdRepository {
  final AdApiCLient adApiClient;

  AdRepository({@required this.adApiClient}) : assert(adApiClient != null);

  Future getAdRepository(String idUserLoggedIn, String token) async {
    List ads = await adApiClient.getAdsComponents(idUserLoggedIn, token);
    return ads;
  }

  Future getInfoAdRepository(
      String adFk, String userId, String locatorFk, String token) async {
    List ads =
        await adApiClient.getInfoAdComponents(adFk, userId, locatorFk, token);
    return ads;
  }

  Future addAdRepository(Ad ad, String token) async =>
      await adApiClient.addAdComponents(ad, token);

  Future deleteAdRepository(String id, String token) async {
    await adApiClient.deleteAdComponents(id, token);
  }

  Future updateAdRepository(Ad ad, List imagesAwsRemove, String token) async =>
      await adApiClient.updateAdComponents(ad, imagesAwsRemove, token);
}
