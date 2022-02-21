import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/models/models.dart';

class EvaluationApiCLient {
  //static const baseUrl = 'http://192.168.43.31:3000/evaluationRoute';
  Dio dio = new Dio();
  EvaluationApiCLient();

  static String get baseUrl => DotEnv().env['urlApi'] + '/evaluationRoute';

  Future<List<Evaluation>> getEvaluationAdComponent(
      String idAd, String token) async {
    final evaluationUrl = '$baseUrl/get_evaluations_one_ad';
    List<Evaluation> evaluationList = [];
    final Map<String, dynamic> jsonEvaluation = {
      "_ad_fk": idAd,
    };
    Response<Map> evaluationResponse;
    try {
      evaluationResponse = await dio.get(
        evaluationUrl,
        queryParameters: jsonEvaluation,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error evaluation message: " + error.message);
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
    evaluationList = await populateEvaluationAds(evaluationResponse.data);

    return evaluationList;
  }

  Future<List<Evaluation>> populateEvaluationAds(Map list) async {
    final List<Evaluation> listEvaluation = [];
    for (var i = 0; i < list['evaluation'].length; i++) {
      listEvaluation.add(
        new Evaluation(
          id: list['evaluation'][i]['_id'],
          ad_fk: list['evaluation'][i]['_ad_fk'],
          user_fk: list['evaluation'][i]['_user_fk'],
          user_name: list['evaluation'][i]['user_name'],
          user_email: list['evaluation'][i]['user_email'],
          amount_stars: list['evaluation'][i]['amount_stars'].toString(),
          objective_opition: list['evaluation'][i]['objective_opition'],
          opinion: list['evaluation'][i]['opinion'],
          evaluation_date: DateFormat('y-M-d')
              .format(DateTime.parse(list['evaluation'][i]['evaluation_date'])),
        ),
      );
    }
    return listEvaluation;
  }
}
