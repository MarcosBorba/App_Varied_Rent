import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'adProduct_event.dart';
part 'adProduct_state.dart';

class AdProductPageBloc extends Bloc<AdProductPageEvent, AdProductPageState> {
  EvaluationRepository evaluationRepository;
  QuestionAndAnswerRepository questionAndAnswerRepository;
  FavoriteAdRepository favoriteAdRepository;
  AdRepository adRepository;

  /* @required this.evaluationRepository,
    @required this.questionAndAnswerRepository,
    @required this.favoriteAdRepository,
,
        assert(evaluationRepository != null),
        assert(questionAndAnswerRepository != null),
        assert(favoriteAdRepository != null) */
  AdProductPageBloc({
    @required this.adRepository,
  }) : assert(adRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingAdProductPage();

  @override
  Stream<AdProductPageState> mapEventToState(AdProductPageEvent event) async* {
    if (event is AdProductPageGetInfoAd) {
      try {
        String token = await sharedPref.read('token');
        String userId = await sharedPref.read('id');
        List resultGetInfo = await adRepository.getInfoAdRepository(
            event.idAd, userId, event.locatorFk, token);
        await printUserAd(resultGetInfo[0]);
        print("favorite is true -> " + resultGetInfo[1].toString());
        await printQuestionsAndAnswersAds(resultGetInfo[2]);
        await printEvaluationAds(resultGetInfo[3]);
      } catch (error) {
        print("error no bloc ->>>> " + error.toString());
        if (error is DioError) {
          yield FailureAdProductPage(error: error.message);
        } else {
          yield FailureAdProductPage(error: "500 - Internal Server Error");
        }
      }
    }
  }

  Future printUserAd(User list) async {
    print("item user ");
    print(list.id);
    print(list.name);
    print(list.email);
    print(list.genre);
    print(list.cpf_cnpj);
    print(list.landlord_type);
    print(list.password);
    print(list.phones);
    print(list.address);
    print("\n");
  }

  Future printEvaluationAds(List<Evaluation> list) async {
    for (var i = 0; i < list.length; i++) {
      print("item evaluation " + i.toString());
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

  Future printQuestionsAndAnswersAds(List<QuestionAndAnswer> list) async {
    for (var i = 0; i < list.length; i++) {
      print("item question " + i.toString());
      print(list[i].id);
      print(list[i].ad_fk);
      print(list[i].tenant_fk);
      print(list[i].question);
      print(list[i].answer);
      print("\n");
    }
  }
}
