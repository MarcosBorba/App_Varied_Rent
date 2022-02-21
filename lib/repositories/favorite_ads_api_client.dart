import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:varied_rent/models/models.dart';

class FavoriteAdApiCLient {
  //static const baseUrl = 'http://192.168.43.31:3000/favoriteAdsRoute';
  Dio dio = new Dio();
  FavoriteAdApiCLient();
  static String get baseUrl => DotEnv().env['urlApi'] + '/favoriteAdsRoute';

  Future<List<Ad>> getFavoriteAds(String idUserLoggedIn, String token) async {
    final userCheckUserUrl = '$baseUrl/get_favorite_ad_one_user';
    List<Ad> adsList = [];
    final Map<String, dynamic> jsonUserLoggedIn = {
      "_locator_fk": idUserLoggedIn,
    };
    Response<Map> adsResponse;
    try {
      adsResponse = await dio.get(
        userCheckUserUrl,
        queryParameters: jsonUserLoggedIn,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error message: " + error.message);
      if (error is DioError) {
        if (error.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: error.response.statusCode.toString() +
                  " - " +
                  error.response.data['message']);
        }
      }
    }
    adsList = await populateFavoriteAds(adsResponse.data);
    return adsList;
  }

  Future<List<Ad>> populateFavoriteAds(Map list) async {
    final List<Ad> listFavoriteAds = [];
    for (var i = 0; i < list['ads'].length; i++) {
      listFavoriteAds.add(
        new Ad(
          id: list['ads'][i]['_id'],
          locator_fk: list['ads'][i]['_locator_fk'],
          title: list['ads'][i]['title'],
          images: list['ads'][i]['images'],
          starsEvaluations: list['ads'][i]['starsEvaluations'],
          value: list['ads'][i]['value'],
          description: list['ads'][i]['description'],
          category: list['ads'][i]['category'],
        ),
      );
    }
    return listFavoriteAds;
  }

  Future deleteFavoriteAd(String adFk, String locatorFk, String token) async {
    final deleteAdUrl = '$baseUrl/delete_favorite_ad';
    final Map<String, dynamic> jsonId = {
      "_ad_fk": adFk,
      "_locator_fk": locatorFk
    };
    Response<Map> adsResponse;
    print(deleteAdUrl);
    print(jsonId);
    try {
      adsResponse = await dio.delete(
        deleteAdUrl,
        queryParameters: jsonId,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error message: " + error.message);
      if (error is DioError) {
        if (error.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: error.response.statusCode.toString() +
                  " - " +
                  error.response.data['message']);
        }
      }
    }
  }

  Future addFavoriteAd(String adFk, String locatorFk, String token) async {
    final addAdUrl = '$baseUrl/add_favorite_ad';
    final Map<String, dynamic> jsonId = {
      "_ad_fk": adFk,
      "_locator_fk": locatorFk
    };
    Response<Map> adsResponse;
    try {
      print("add Function");
      adsResponse = await dio.post(
        addAdUrl,
        data: jsonId,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
      print(adsResponse);
    } catch (error) {
      print("error message: " + error.message);
      if (error is DioError) {
        if (error.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: error.response.statusCode.toString() +
                  " - " +
                  error.response.data['message']);
        }
      }
    }
  }
}
