import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/adProductForm.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class AdProductPage extends StatelessWidget {
  final String idAd;
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  final String locatorFk;
  final bool comesFromTheFavoritePage;
  int qtdEvaluations = 0;
  double adEvaluation = 0.0;
  List<Evaluation> evaluations;
  List<QuestionAndAnswer> questionsAndAnswers;
  String nameLocator;
  String emailLocator;
  String landlordTypeLocator;
  String telephone1;
  String telephone2;
  bool isFavorite = false;
  bool isAnAnnouncementOfTheLoggedUser = false;
  String userLoggedId;
  String userLoggedEmail;

  AdProductPage({
    Key key,
    this.idAd,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
    this.locatorFk,
    this.comesFromTheFavoritePage = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future printItens(ShowInfoAdMyAdProductPage state) {
      print(nameLocator);
      print(emailLocator);
      print(landlordTypeLocator);
      print(telephone1);
      print(telephone2);
      print(isFavorite.toString());
      print(questionsAndAnswers.toString());
      print(evaluations.toString());
      print(adEvaluation.toString());
      print(qtdEvaluations.toString());
      print(isAnAnnouncementOfTheLoggedUser.toString());
    }

    Future<bool> onReturnPage() async {
      if (comesFromTheFavoritePage) {
        Navigator.of(context).pop(FavoriteAdsPageStarted());
        return false;
      } else {
        return true;
      }
    }

    return WillPopScope(
      onWillPop: onReturnPage,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColors.insertAdStatusBar,
          ),
          child: BlocProvider<AdProductPageBloc>(
            create: (_) {
              AdRepository adRepository =
                  AdRepository(adApiClient: AdApiCLient());
              FavoriteAdRepository favoriteAdRepository = FavoriteAdRepository(
                  favoriteAdApiClient: FavoriteAdApiCLient());
              QuestionAndAnswerRepository questionAndAnswerRepository =
                  QuestionAndAnswerRepository(
                      questionAndAnswerApiClient: QuestionAndAnswerApiCLient());
              EvaluationRepository evaluationRepository = EvaluationRepository(
                  evaluationApiClient: EvaluationApiCLient());
              return AdProductPageBloc(
                adRepository: adRepository,
                favoriteAdRepository: favoriteAdRepository,
                questionAndAnswerRepository: questionAndAnswerRepository,
                evaluationRepository: evaluationRepository,
              )..add(
                  AdProductPageGetInfoAd(
                    idAd,
                    locatorFk,
                  ),
                );
            },
            child: BlocListener<AdProductPageBloc, AdProductPageState>(
              listener: (context, state) async {
                if (state is FailureAdProductPage) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    ),
                  );
                } else if (state is ShowInfoAdMyAdProductPage) {
                  nameLocator = state.nameLocator;
                  emailLocator = state.emailLocator;
                  landlordTypeLocator = state.landlordTypeLocator;
                  telephone1 = state.telephone1;
                  telephone2 = state.telephone2;
                  isFavorite = state.isFavorite;
                  questionsAndAnswers = state.questionsAndAnswer;
                  evaluations = state.evaluations;
                  adEvaluation = state.medianAmountStars;
                  qtdEvaluations = evaluations.length;
                  userLoggedEmail = state.userLoggedEmail;
                  userLoggedId = state.userLoggedId;
                  isAnAnnouncementOfTheLoggedUser =
                      state.isAnAnnouncementOfTheLoggedUser;
                  await printItens(state);
                } else if (state is RemoveFavoriteAdMyAdProductPage) {
                  isFavorite = state.isFavorite;
                } else if (state is AddFavoriteAdMyAdProductPage) {
                  isFavorite = state.isFavorite;
                } else if (state is AddQuestionAdMyAdProductPage) {
                  questionsAndAnswers = state.questionAndAnswer;
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Success on Add Question'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    ),
                  );
                } else if (state is EditQuestionAdMyAdProductPage) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Success on Edit Question'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: BlocBuilder<AdProductPageBloc, AdProductPageState>(
                builder: (context, state) {
                  return state is LoadingAdProductPage
                      ? LoadingAdsProduct()
                      : CacheProviderAdProduct(
                          idAd,
                          nameLocator,
                          emailLocator,
                          landlordTypeLocator,
                          telephone1,
                          telephone2,
                          isFavorite,
                          isAnAnnouncementOfTheLoggedUser,
                          questionsAndAnswers,
                          evaluations,
                          adEvaluation,
                          qtdEvaluations,
                          titleAd,
                          descriptionAd,
                          valueAd,
                          imagesAd,
                          userLoggedId,
                          userLoggedEmail,
                          AdProductForm(),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
