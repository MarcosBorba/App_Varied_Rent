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

  Future<List> addAdRepository(String image, String token) async {
    List ads = await adApiClient.addAdComponents(image, token);
    return ads;
  }

  Future deleteAdRepository(String id, String token) async {
    await adApiClient.deleteAdComponents(id, token);
  }
}
