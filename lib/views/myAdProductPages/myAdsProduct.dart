import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

//674 linhas antes otimizar
class MyAdsProduct extends StatefulWidget {
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;

  const MyAdsProduct({
    Key key,
    this.titleAd,
    this.descriptionAd,
    this.valueAd,
    this.imagesAd,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyAdsProductState(
        titleAd: titleAd,
        descriptionAd: descriptionAd,
        valueAd: valueAd,
        imagesAd: imagesAd,
      );
}

//TODO: nivel 4 - estrela no cabecario não rebuilda
//TODO: nivel 4 - definir texts, colors, routes....

class CacheProvider extends InheritedWidget {
  final List<Evaluation> evaluations;
  final List<QuestionAndAnswer> questionsAndAnswers;
  final int qtdEvaluations;
  final double adEvaluation;
  final Widget child;
  CacheProvider(
    this.evaluations,
    this.questionsAndAnswers,
    this.qtdEvaluations,
    this.adEvaluation,
    this.child, {
    Key key,
  })  : assert(child != null),
        super(key: key);

  static CacheProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CacheProvider>();
  }

  @override
  bool updateShouldNotify(CacheProvider old) => true;
}

class MyAdsProductState extends State<MyAdsProduct> {
  MyAdsProductState({
    Key key,
    this.titleAd = "NO TITLE",
    this.descriptionAd = "NO DESCRIPTION",
    this.valueAd = "0.00",
    this.imagesAd,
  });
  final String titleAd;
  final String descriptionAd;
  final String valueAd;
  final List imagesAd;
  List<Evaluation> evaluations;
  List<QuestionAndAnswer> questionsAndAnswers;
  String typeValueAd = " / Hr";
  String nameLocator = "Joao Gabriel Faria Borba da Silva";
  ItemScrollController _evaluation2ScrollController = ItemScrollController();
  int navigationBarBottomIndex = 0;
  int qtdEvaluations = 0;
  double adEvaluation = 0.0;
  double selectStars;
  SharedPref sharedPrefUser = SharedPref();
  List valuesSharedPrefUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<MyAdProductPageBloc, MyAdProductPageState>(
        listener: (context, state) {
          if (state is ShowQuestionsAndEvaluationsMyAdProductPage) {
            adEvaluation = state.medianAmountStars;
            evaluations = state.evaluations;
            qtdEvaluations = evaluations.length;
            questionsAndAnswers = state.questionsAndAnswer;
            nameLocator = "joana";
          } else if (state
              is ShowUpdateQuestionsAndEvaluationsMyAdProductPage) {
            setState(() {});
          }
        },
        child: BlocBuilder<MyAdProductPageBloc, MyAdProductPageState>(
          builder: (context, state) {
            return CacheProvider(
              evaluations,
              questionsAndAnswers,
              qtdEvaluations,
              adEvaluation,
              Container(
                height: screenHeight,
                width: screenWidth,
                color: Colors.white,
                child: SafeArea(
                  child: ListView(
                    children: <Widget>[
                      //usando inhetited widget para tentar ´passar dados para os filhos
                      //continuar implementando
                      returnHeader(),
                      returnSubTitle(),
                      returnImagesAd(),
                      returnDivider("Description"),
                      returnDescription(),
                      returnDivider("Questions"),
                      returnQuestionsAndAnswer(),
                      returnDivider("Evaluations"),
                      returnSelectEvaluationAmountStars(),
                      returnEvaluationsAd(),
                      returnDivider("Locator"),
                      returnLocatorInfo(),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: screenHeight * 0.05,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget returnHeader() {
    return new MaterialTitle(
      titleAd: titleAd,
    );
  }

  Widget returnSubTitle() {
    return SubTitleAd(
      valueAd: valueAd,
      typeValue: typeValueAd,
    );
  }

  Widget returnImagesAd() {
    return ImagesAd(
      images: imagesAd,
    );
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(
      textTitleDivider: textDivider,
    );
  }

  Widget returnDescription() {
    return Description(
      textDescription: descriptionAd,
    );
  }

  Widget returnQuestionsAndAnswer() {
    return new QuestionsAndAnswerContainer(
      userNameLocator: nameLocator,
    );
  }

  Widget returnSelectEvaluationAmountStars() {
    return SelectStarsEvaluation(
      hintText: "Select Evaluations Stars",
      onChanged: (SmoothStarRating value) {
        setState(() {
          selectStars = value.rating;
          evaluations != null && evaluations.length > 0
              ? _evaluation2ScrollController.jumpTo(index: 0)
              : 0;
        });
      },
    );
  }

  Widget returnEvaluationsAd() {
    return EvaluationsAd(
      evaluations: evaluations,
      controllerItemRefreshListView: _evaluation2ScrollController,
      starSelected: selectStars,
    );
  }

  Widget returnLocatorInfo() {
    return LocatorInfo();
  }
}
