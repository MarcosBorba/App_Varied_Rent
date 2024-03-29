import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:varied_rent/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';

class AdApiCLient {
  //static const baseUrl = 'http://192.168.43.31:3000/adRoute';
  Dio dio = new Dio();
  AdApiCLient();
  static String get baseUrl => DotEnv().env['urlApi'] + '/adRoute';

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

  Future<List<dynamic>> getInfoAdComponents(
      String adFk, String userId, String locatorFk, String token) async {
    //_ad_fk, _user_id, _locator_fk
    final infoAdCheckUrl = '$baseUrl/get_info_ad';
    List infoAdList = [];
    final Map<String, dynamic> jsonInfoAdProduct = {
      "_ad_fk": adFk,
      "_user_id": userId,
      "_locator_fk": locatorFk,
    };
    Response<Map> infoAdResponse;
    try {
      infoAdResponse = await dio.get(
        infoAdCheckUrl,
        queryParameters: jsonInfoAdProduct,
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
    User userLocator = new User();
    infoAdList.add(
      await userLocator.fromJsonSharedPrefenrence(
        infoAdResponse.data['userLocator'],
      ),
    );
    infoAdList.add(infoAdResponse.data['favoriteAd']);

    infoAdList.add(
      await QuestionAndAnswerApiCLient().populateQuestionAndAnswerAd(
        infoAdResponse.data,
      ),
    );
    infoAdList.add(
      await EvaluationApiCLient().populateEvaluationAds(
        infoAdResponse.data,
      ),
    );
    return infoAdList;
  }

  Future addAdComponents(Ad newAd, String token) async {
    final userCheckUserUrl = Uri.parse('$baseUrl/create_ad');
    final Map<String, String> jsonNewAdFields = {
      "_locator_fk": newAd.locator_fk,
      "title": newAd.title,
      "value": newAd.value,
      'description': newAd.description,
      "category": newAd.category,
    };

    var request = new http.MultipartRequest("POST", userCheckUserUrl)
      ..fields.addAll(jsonNewAdFields);
    return await populatesFiles(newAd.images, request);
  }

  Future populatesFiles(
      List<ImageFile> imageFile, http.MultipartRequest request) async {
    await Future.forEach(imageFile, (ImageFile image) async {
      List<int> imageData = image.image.readAsBytesSync();
      int lastIndexImageName = path.basename(image.image.path).lastIndexOf('.');

      http.MultipartFile multipartFile = new http.MultipartFile.fromBytes(
        'varios',
        imageData,
        filename: path.basename(image.image.path),
        contentType: MediaType(
            "image",
            (lastIndexImageName != -1)
                ? path
                    .basename(image.image.path)
                    .substring(lastIndexImageName + 1)
                : "png"),
      );
      request.files.add(multipartFile);
    });

    return await uploadNewAd(request);
  }

  Future uploadNewAd(http.MultipartRequest request) async {
    http.StreamedResponse response;
    try {
      response = await request.send();
      if (response.statusCode != 200) throw new Exception("");
    } catch (error) {
      if (error.response == null) {
        throw new DioError(error: "500 - Internal Server Error");
      } else {
        throw new DioError(
          error: response.statusCode.toString() + " - Error Update Ad",
        );
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

  Future updateAdComponents(Ad ad, List imagesAwsRemove, String token) async {
    final updateAdUrl = Uri.parse('$baseUrl/update_ad');
    final Map<String, String> jsonUpdateAd = {
      "_id": ad.id,
      "title": ad.title,
      "value": ad.value,
      'description': ad.description,
      "category": ad.category,
      "imagesAwsRemove": json.encode(imagesAwsRemove),
    };
    var request = new http.MultipartRequest("PUT", updateAdUrl)
      ..fields.addAll(jsonUpdateAd);
    await populatesFiles(ad.images, request);
  }
}
