import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/myAdsProduct_bloc/myAdProductBloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'myAdProduct_event.dart';
part 'myAdProduct_state.dart';

class MyAdProductPageBloc
    extends Bloc<MyAdProductPageEvent, MyAdProductPageState> {
  EvaluationRepository evaluationRepository;

  MyAdProductPageBloc({
    @required this.evaluationRepository,
  }) : assert(evaluationRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingMyAdProductPage();

  @override
  Stream<MyAdProductPageState> mapEventToState(
      MyAdProductPageEvent event) async* {
    if (event is MyAdProductPageGetQuestionsAndEvaluations) {
      try {
        String token = await sharedPref.read('token');

        List<Evaluation> evaluations = await evaluationRepository
            .getEvaluationsAdRepository(event.idAd, token);
        await printEvaluationAds(evaluations);
        yield ShowQuestionsAndEvaluationsMyAdProductPage(
            evaluations: evaluations);
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FailureMyAdProductPage(error: error.message);
        } else {
          yield FailureMyAdProductPage(error: "500 - Internal Server Error");
        }
      }
      //event.
      ///criar parte de repositorio e backend e depois ligar com o front
    }
  }

  Future<List<Evaluation>> printEvaluationAds(List<Evaluation> list) async {
    for (var i = 0; i < list.length; i++) {
      print("item" + i.toString());
      print(list[i].id);
      print(list[i].ad_fk);
      print(list[i].user_fk);
      print(list[i].user_name);
      print(list[i].user_email);
      print(list[i].amount_stars);
      print(list[i].objective_opition);
      print(list[i].opinion);
      print(list[i].evaluation_date);
      print("\n");
    }
  }
}
