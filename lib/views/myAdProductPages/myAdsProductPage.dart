import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProduct.dart';

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
            }
          },
          child: MyAdsProduct(
            titleAd: titleAd,
            descriptionAd: descriptionAd,
            valueAd: valueAd,
            imagesAd: imagesAd,
          ),
        ),
      ),
    );
  }
}
