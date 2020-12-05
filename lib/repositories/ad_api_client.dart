import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:varied_rent/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:varied_rent/views/insertAdsPages/imageFile.dart';
import 'dart:convert';

class AdApiCLient {
  static const baseUrl = 'http://192.168.0.180:3000/adRoute';
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
    await populatesFiles(newAd.images, request);
  }

  Future<int> populatesFiles(
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

    await uploadNewAd(request);
  }

  Future uploadNewAd(http.MultipartRequest request) async {
    var response;
    try {
      response = await request.send();
      /* response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      }); */
    } catch (error) {
      print("error message: " + error.message);
      print("response : " + response.toString());
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
