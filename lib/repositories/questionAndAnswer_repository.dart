import 'package:flutter/material.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

class QuestionAndAnswerRepository {
  final QuestionAndAnswerApiCLient questionAndAnswerApiClient;

  QuestionAndAnswerRepository({@required this.questionAndAnswerApiClient})
      : assert(questionAndAnswerApiClient != null);

  Future<String> addQuestionAndAnswersAdRepository(
      String idAd, String userId, Question question, String token) async {
    String id = await questionAndAnswerApiClient
        .addQuestionsAndAnswersAdComponent(idAd, userId, question, token);
    return id;
  }

  Future<List<QuestionAndAnswer>> getQuestionAndAnswersAdRepository(
      String idAd, String token) async {
    List<QuestionAndAnswer> questionsAndAnswers =
        await questionAndAnswerApiClient.getQuestionsAndAnswersAdComponent(
            idAd, token);
    return questionsAndAnswers;
  }

  Future updateQuestionAndAnswersAdRepository(
      QuestionAndAnswer questionAndAnswer, String token) async {
    await questionAndAnswerApiClient.updateQuestionsAndAnswersAdComponent(
        questionAndAnswer, token);
  }
}
