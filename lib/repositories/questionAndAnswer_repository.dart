import 'package:flutter/material.dart';
import 'package:varied_rent/models/questionAndAnswer.dart';
import 'package:varied_rent/repositories/repositories.dart';

class QuestionAndAnswerRepository {
  final QuestionAndAnswerApiCLient questionAndAnswerApiClient;

  QuestionAndAnswerRepository({@required this.questionAndAnswerApiClient})
      : assert(questionAndAnswerApiClient != null);

  Future<List<QuestionAndAnswer>> getQuestionAndAnswersAdRepository(
      String idAd, String token) async {
    List<QuestionAndAnswer> questionsAndAnswers =
        await questionAndAnswerApiClient.getQuestionsAndAnswersAdComponent(
            idAd, token);
    return questionsAndAnswers;
  }
}
