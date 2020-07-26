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
    Ad ad = new Ad();
    adsList = await populateAds(adsResponse.data);
  }

  Future<List<Ad>> populateAds(Map list) async {
    final List<Ad> lista = [];
    for (var i = 0; i < list['ads'].length; i++) {
      print(list['ads'][i]['_id']);
    }
    return lista;
  }
}
