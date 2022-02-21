import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/models/models.dart';

class QuestionAndAnswerApiCLient {
  //static const baseUrl = 'http://192.168.43.31:3000/questionAndAnswerRoute';
  Dio dio = new Dio();
  QuestionAndAnswerApiCLient();
  static String get baseUrl =>
      DotEnv().env['urlApi'] + '/questionAndAnswerRoute';

  Future<String> addQuestionsAndAnswersAdComponent(
      String idAd, String idUser, Question question, String token) async {
    final questionsAndAnswersUrl = '$baseUrl/add_question_and_answer';
    final Map<String, dynamic> jsonQuestionAndAnswer = {
      "_ad_fk": idAd,
      "_tenant_fk": idUser,
      "question": {
        "tenant_name": question.tenant_name,
        "tenant_email": question.tenant_email,
        "question": question.question,
        "question_date_time": DateFormat('y-M-d').format(DateTime.now()),
      },
    };
    Response<Map> questionAndAnswerResponse;
    try {
      questionAndAnswerResponse = await dio.post(
        questionsAndAnswersUrl,
        data: jsonQuestionAndAnswer,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error questions and answers message: " + error.message);
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
    return questionAndAnswerResponse.data['id'];
  }

  Future<List<QuestionAndAnswer>> getQuestionsAndAnswersAdComponent(
      String idAd, String token) async {
    final questionsAndAnswersUrl = '$baseUrl/get_questions_and_answers_one_ad';
    List<QuestionAndAnswer> questionsAndAnswersList = [];
    final Map<String, dynamic> jsonQuestionAndAnswer = {
      "_ad_fk": idAd,
    };
    Response<Map> questionAndAnswerResponse;
    try {
      questionAndAnswerResponse = await dio.get(
        questionsAndAnswersUrl,
        queryParameters: jsonQuestionAndAnswer,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error questions and answers message: " + error.message);
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
    print("question type: " + questionAndAnswerResponse.data.toString());
    questionsAndAnswersList =
        await populateQuestionAndAnswerAd(questionAndAnswerResponse.data);

    return questionsAndAnswersList;
  }

  Future<List<QuestionAndAnswer>> populateQuestionAndAnswerAd(Map list) async {
    final List<QuestionAndAnswer> listQuestionAndAnswer = [];
    for (var i = 0; i < list['question_and_answer'].length; i++) {
      listQuestionAndAnswer.add(
        new QuestionAndAnswer(
          id: list['question_and_answer'][i]['_id'],
          ad_fk: list['question_and_answer'][i]['_ad_fk'],
          tenant_fk: list['question_and_answer'][i]['_tenant_fk'],
          question: new Question(
            tenant_name: list['question_and_answer'][i]['question']
                ['tenant_name'],
            tenant_email: list['question_and_answer'][i]['question']
                ['tenant_email'],
            question_date_time: DateFormat('yyyy-MM-dd').format(
              DateTime.parse(
                list['question_and_answer'][i]['question']
                    ['question_date_time'],
              ),
            ),
            question: list['question_and_answer'][i]['question']['question'],
          ),
          answer: list['question_and_answer'][i]['answer'] != null
              ? new Answer(
                  locator_name: list['question_and_answer'][i]['answer']
                      ['locator_name'],
                  locator_email: list['question_and_answer'][i]['answer']
                      ['locator_email'],
                  answer_date_time: DateFormat('yyyy-MM-dd').format(
                    DateTime.parse(
                      list['question_and_answer'][i]['answer']
                          ['answer_date_time'],
                    ),
                  ),
                  answer: list['question_and_answer'][i]['answer']['answer'],
                )
              : new Answer(
                  locator_name: null,
                  locator_email: null,
                  answer_date_time: null,
                  answer: null,
                ),
        ),
      );
    }
    return listQuestionAndAnswer;
  }

  Future updateQuestionsAndAnswersAdComponent(
      QuestionAndAnswer questionAndAnswer, String token) async {
    final questionsAndAnswersUrl = '$baseUrl/update_question_and_answer_one_ad';
    print("entrou update");
    final Map<String, dynamic> jsonQuestionAndAnswer = {
      "_id": questionAndAnswer.id,
      "_ad_fk": questionAndAnswer.ad_fk,
      "_tenant_fk": questionAndAnswer.tenant_fk,
      "question": {
        "tenant_name": questionAndAnswer.question.tenant_name,
        "tenant_email": questionAndAnswer.question.tenant_email,
        "question": questionAndAnswer.question.question,
        "question_date_time":
            DateTime.parse(questionAndAnswer.question.question_date_time)
                .toIso8601String(),
      },
      "answer": questionAndAnswer.answer != null &&
              questionAndAnswer.answer.answer != null
          ? {
              "locator_name": questionAndAnswer.answer.locator_name,
              "locator_email": questionAndAnswer.answer.locator_email,
              "answer": questionAndAnswer.answer.answer,
              "answer_date_time":
                  DateTime.parse(questionAndAnswer.answer.answer_date_time)
                      .toIso8601String(),
            }
          : null,
    };
    try {
      print(jsonQuestionAndAnswer);

      await dio.put(
        questionsAndAnswersUrl,
        queryParameters: jsonQuestionAndAnswer,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error questions and answers message: " + error.message);
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
