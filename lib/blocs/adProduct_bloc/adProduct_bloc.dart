import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'adProduct_event.dart';
part 'adProduct_state.dart';

class AdProductPageBloc extends Bloc<AdProductPageEvent, AdProductPageState> {
  EvaluationRepository evaluationRepository;
  QuestionAndAnswerRepository questionAndAnswerRepository;
  FavoriteAdRepository favoriteAdRepository;
  AdRepository adRepository;

  AdProductPageBloc({
    @required this.adRepository,
    @required this.favoriteAdRepository,
    @required this.questionAndAnswerRepository,
    @required this.evaluationRepository,
  })  : assert(adRepository != null),
        assert(favoriteAdRepository != null),
        assert(questionAndAnswerRepository != null),
        assert(evaluationRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingAdProductPage();

  @override
  Stream<AdProductPageState> mapEventToState(AdProductPageEvent event) async* {
    try {
      yield LoadingAdProductPage();
      String token = await sharedPref.read('token');
      if (event is AdProductPageGetInfoAd) {
        String userId = await sharedPref.read('id');
        String userEmail = await sharedPref.read('email');
        bool isAnAnnouncementOfTheLoggedUser =
            userId == event.locatorFk ? true : false;
        List resultGetInfo = await adRepository.getInfoAdRepository(
            event.idAd, userId, event.locatorFk, token);
        double medianEvaluationStars =
            await medianCalculationEvaluationsStars(resultGetInfo[3]);

        yield ShowInfoAdMyAdProductPage(
          nameLocator: resultGetInfo[0].name,
          emailLocator: resultGetInfo[0].email,
          landlordTypeLocator: resultGetInfo[0].landlord_type,
          telephone1: resultGetInfo[0].phones.telephone1,
          telephone2: resultGetInfo[0].phones.telephone2,
          isFavorite: resultGetInfo[1],
          questionsAndAnswer: resultGetInfo[2],
          evaluations: resultGetInfo[3],
          medianAmountStars: medianEvaluationStars,
          userLoggedEmail: userEmail,
          userLoggedId: userId,
          isAnAnnouncementOfTheLoggedUser: isAnAnnouncementOfTheLoggedUser,
        );
      } else if (event is AdProductPageRemoveFavoriteAd) {
        await favoriteAdRepository.deleteFavoriteAdRepository(
            event.idAd, event.idUserLogged, token);
        yield RemoveFavoriteAdMyAdProductPage(
          isFavorite: false,
        );
      } else if (event is AdProductPageAddFavoriteAd) {
        await favoriteAdRepository.addFavoriteAdRepository(
            event.idAd, event.idUserLogged, token);
        yield AddFavoriteAdMyAdProductPage(
          isFavorite: true,
        );
      } else if (event is AdProductPageAddQuestionAd) {
        String idUser = await sharedPref.read('id');
        String nameUser = await sharedPref.read('name');
        String emailUser = await sharedPref.read('email');
        String questionDateTime = DateFormat('y-M-d').format(DateTime.now());
        String idQuestion =
            await questionAndAnswerRepository.addQuestionAndAnswersAdRepository(
                event.idAd,
                idUser,
                new Question(
                    tenant_name: nameUser,
                    tenant_email: emailUser,
                    question: event.question),
                token);

        List<QuestionAndAnswer> listQuestionsAndAnswers =
            await insertItemListQuestionAndAnswer(
          event.questionsAndAnswer,
          idQuestion,
          event.idAd,
          idUser,
          nameUser,
          emailUser,
          questionDateTime,
          event.question,
        );

        yield AddQuestionAdMyAdProductPage(
            questionAndAnswer: listQuestionsAndAnswers);
      } else if (event is AdProductPageEditQuestionAd) {
        await questionAndAnswerRepository.updateQuestionAndAnswersAdRepository(
            event.questionsAndAnswer, token);
        yield EditQuestionAdMyAdProductPage();
      }
    } catch (error) {
      print("error no bloc ->>>> " + error.toString());
      if (error is DioError) {
        yield FailureAdProductPage(error: error.message);
      } else {
        yield FailureAdProductPage(error: "500 - Internal Server Error");
      }
    }
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

  Future<List<QuestionAndAnswer>> insertItemListQuestionAndAnswer(
      List<QuestionAndAnswer> questionsAndAnswer,
      String idQuestion,
      String idAd,
      String idUser,
      String nameUser,
      String emailUser,
      String questionDateTime,
      String question) async {
    questionsAndAnswer.insert(
      0,
      new QuestionAndAnswer(
        id: idQuestion,
        ad_fk: idAd,
        tenant_fk: idUser,
        question: new Question(
            tenant_name: nameUser,
            tenant_email: emailUser,
            question_date_time: questionDateTime,
            question: question),
        answer: new Answer(
            locator_name: null,
            locator_email: null,
            answer_date_time: null,
            answer: null),
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    return questionsAndAnswer;
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
    print(list.phones.telephone1);
    print(list.phones.telephone2);
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
