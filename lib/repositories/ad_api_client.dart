import 'package:dio/dio.dart';
import 'package:varied_rent/models/models.dart';

class AdApiCLient {
  static const baseUrl = 'http://192.168.2.180:3000/adRoute';
  Dio dio = new Dio();
  AdApiCLient();

  Future<List<Ad>> getAdsComponents(String idUserLoggedIn, String token) async {
    final userCheckUserUrl = '$baseUrl/get_ads_one_user';
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
    adsList = await populateAds(adsResponse.data);
    return adsList;
  }

  Future<List<Ad>> populateAds(Map list) async {
    final List<Ad> lista = [];
    for (var i = 0; i < list['ads'].length; i++) {
      lista.add(
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
    return lista;
  }

  Future addAdComponents(String image, String token) async {
    final userCheckUserUrl = '$baseUrl/create_ad';
    final Map<String, dynamic> jsonUserLoggedIn = {
      "_locator_fk": "5ebc83a7c2159307500e7f9c",
      "images": [image.toString()],
      "title": "test app varied",
      "value": "12.00",
      'description': "ads test of test test result",
      "category": "cars",
    };
    Response<Map> adsResponse;
    try {
      adsResponse = await dio.post(
        userCheckUserUrl,
        data: jsonUserLoggedIn,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error message: " + error.message);
      print("response : " + adsResponse.toString());
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

  Future deleteAdComponents(String id, String token) async {
    final deleteAdUrl = '$baseUrl/delete_ads';
    final Map<String, dynamic> jsonId = {
      "_id": id,
    };
    Response<Map> adsResponse;
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
      print("response : " + adsResponse.toString());
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
