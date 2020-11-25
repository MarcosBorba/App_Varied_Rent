import 'package:flutter/material.dart';
import 'package:varied_rent/models/evaluation.dart';
import 'package:varied_rent/repositories/evalulation_api_client.dart';

class EvaluationRepository {
  final EvaluationApiCLient evaluationApiClient;

  EvaluationRepository({@required this.evaluationApiClient})
      : assert(evaluationApiClient != null);

  Future<List<Evaluation>> getEvaluationsAdRepository(
      String idAd, String token) async {
    List<Evaluation> evaluations =
        await evaluationApiClient.getEvaluationAdComponent(idAd, token);
    return evaluations;
  }
}
