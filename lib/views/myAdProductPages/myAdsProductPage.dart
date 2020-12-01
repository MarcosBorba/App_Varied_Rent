import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProduct.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class MyAdsProductPage extends StatelessWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;

  const MyAdsProductPage({
    Key key,
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int qtdEvaluations = 0;
    double adEvaluation = 0.0;
    List<Evaluation> evaluations;
    List<QuestionAndAnswer> questionsAndAnswers;
    String nameLocator;
    String landlordTypeLocator;
    String telephone1;
    String telephone2;
    return Scaffold(
      body: BlocProvider<MyAdProductPageBloc>(
        create: (_) {
          EvaluationRepository evaluationRepository =
              EvaluationRepository(evaluationApiClient: EvaluationApiCLient());
          QuestionAndAnswerRepository questionAndAnswerRepository =
              QuestionAndAnswerRepository(
                  questionAndAnswerApiClient: QuestionAndAnswerApiCLient());
          return MyAdProductPageBloc(
              evaluationRepository: evaluationRepository,
              questionAndAnswerRepository: questionAndAnswerRepository)
            ..add(
              MyAdProductPageGetQuestionsAndEvaluations(idAd),
            );
        },
        child: BlocListener<MyAdProductPageBloc, MyAdProductPageState>(
          listener: (context, state) {
            if (state is FailureMyAdProductPage) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
            } else if (state is ShowQuestionsAndEvaluationsMyAdProductPage) {
              adEvaluation = state.medianAmountStars;
              evaluations = state.evaluations;
              qtdEvaluations = evaluations.length;
              questionsAndAnswers = state.questionsAndAnswer;
              nameLocator = state.nameLocator;
              landlordTypeLocator = state.landlordTypeLocator;
              telephone1 = state.telephone1;
              telephone2 = state.telephone2;
            }
          },
          child: BlocBuilder<MyAdProductPageBloc, MyAdProductPageState>(
            builder: (context, state) {
              return state is LoadingMyAdProductPage
                  ? LoadingMyAdsProduct()
                  : CacheProvider(
                      evaluations,
                      questionsAndAnswers,
                      qtdEvaluations,
                      adEvaluation,
                      nameLocator,
                      landlordTypeLocator,
                      telephone1,
                      telephone2,
                      titleAd,
                      descriptionAd,
                      valueAd,
                      imagesAd,
                      MyAdsProduct(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
