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
  QuestionAndAnswerRepository questionAndAnswerRepository;

  MyAdProductPageBloc({
    @required this.evaluationRepository,
    @required this.questionAndAnswerRepository,
  })  : assert(evaluationRepository != null),
        assert(questionAndAnswerRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingMyAdProductPage();

  @override
  Stream<MyAdProductPageState> mapEventToState(
      MyAdProductPageEvent event) async* {
    if (event is MyAdProductPageGetQuestionsAndEvaluations) {
      try {
        List dataUserLogged = await getFutureDataUserLogged();
        List<Evaluation> evaluations =
            await evaluationRepository.getEvaluationsAdRepository(
          event.idAd,
          dataUserLogged[0].toString(),
        );

        List<QuestionAndAnswer> questionsAndAnswers =
            await questionAndAnswerRepository.getQuestionAndAnswersAdRepository(
          event.idAd,
          dataUserLogged[0].toString(),
        );

        double medianEvaluationStars =
            await medianCalculationEvaluationsStars(evaluations);
        //await printEvaluationAds(evaluations);
        //await printQuestionsAndAnswersAds(questionsAndAnswers);
        yield ShowQuestionsAndEvaluationsMyAdProductPage(
          evaluations: evaluations,
          questionsAndAnswer: questionsAndAnswers,
          medianAmountStars: medianEvaluationStars,
          nameLocator: dataUserLogged[1],
          landlordTypeLocator: dataUserLogged[2],
          telephone1: dataUserLogged[3]['telephone1'],
          telephone2: dataUserLogged[3]['telephone2'],
          emailLocator: dataUserLogged[4],
        );
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FailureMyAdProductPage(error: error.message);
        } else {
          yield FailureMyAdProductPage(error: "500 - Internal Server Error");
        }
      }
    } else if (event is MyAdProductPageUpdateQuestionAndEvaluation) {
      try {
        String token = await sharedPref.read('token');

        await questionAndAnswerRepository.updateQuestionAndAnswersAdRepository(
            event.questionAndAnswer, token);

        yield ShowUpdateQuestionsAndEvaluationsMyAdProductPage();
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FailureMyAdProductPage(error: error.message);
        } else {
          yield FailureMyAdProductPage(error: "500 - Internal Server Error");
        }
      }
    }
  }

  Future<List> getFutureDataUserLogged() async {
    List valuesSharedPrefUser = [];
    await sharedPref.read('token').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPref.read('name').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPref.read('landlordType').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPref.read('phones').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPref.read('email').then((value) {
      valuesSharedPrefUser.add(value);
    });
    return valuesSharedPrefUser;
  }

  Future<double> medianCalculationEvaluationsStars(
      List<Evaluation> evaluations) async {
    double median = 0.0;
    double sum = 0.0;
    Duration(seconds: 5);
    if (evaluations != null) {
      for (var index = 0; index < evaluations.length; index++) {
        sum += double.parse(evaluations[index].amount_stars);
      }
      evaluations.length > 0 ? median = sum / evaluations.length : 0;
      return median;
    } else {
      return median;
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

  Future<List<Evaluation>> printQuestionsAndAnswersAds(
      List<QuestionAndAnswer> list) async {
    for (var i = 0; i < list.length; i++) {
      print("item" + i.toString());
      print(list[i].id);
      print(list[i].ad_fk);
      print(list[i].tenant_fk);
      print(list[i].question);
      print(list[i].answer);
      print("\n");
    }
  }
}
