import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_api_client.dart';

class AdRepository {
  final AdApiCLient adApiClient;

  AdRepository({@required this.adApiClient}) : assert(adApiClient != null);

  Future<Ad> getAdRepository(String idUserLoggedIn, String token) async {
    await adApiClient.getAdsComponents(idUserLoggedIn, token);
    //return ads;
  }
}
