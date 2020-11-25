import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
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

//TODO: nivel 4 - definir texts, colors, routes....
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
  String typeValueAd = " / Hr";
  String nameLocator = "Joao Gabriel Faria Borba da Silva";
  ItemScrollController _evaluation2ScrollController = ItemScrollController();
  int navigationBarBottomIndex = 0;

  List questionsAnswers = [
    [
      'Marcos Flavio Ferreira Borba',
      '23 Jul 20',
      'Qual o valor por dia completo?',
      null,
      null,
      null
    ],
    [
      'Marcos Flavio Ferreira Borba',
      '23 Jul 20',
      'Qual o valor por dia completo?',
      'Joao Gabriel Faria Borba da Silva',
      '24 Jul 20',
      "O valor por dia completo é 120."
    ],
    [
      'Mariana Damaceno Campos',
      '24 Jul 20',
      'Qual é o limite de pessoas que podem ficar no imovel?',
      'Joao Gabriel Faria Borba da Silva',
      '25 Jul 20',
      "Podem ficar 16 pessoas."
    ],
    [
      'Adriano Barroso do Sul',
      '25 Jul 20',
      'A área em volta do imóvel é segura?',
      'Joao Gabriel Faria Borba da Silva',
      '25 Jul 20',
      'A segurança do bairro é mediana, com rondas nas ruas em horários variados e uma quantidade de policias que atende bem os chamados normais.'
    ],
  ];

  List evaluations = [
    [
      "Marcos Flavio Ferreira Borba",
      "25 Jul 20",
      5.0,
      "Casa linda, espaçosa, limpa, curti!",
      "A casa é bem bonita mesmo, os quartos e a varanda são muito espaçosos, a garagem também, o local é muito bem cuidado e limpo, recomendo!",
    ],
    [
      "Mariana Damaceno Campos",
      "25 Jul 20",
      4.0,
      "Curti pra caramba, recomendo",
      "Curti, curti e curti, recomendo recomendo",
    ],
    [
      "Marcos Flavio Ferreira Borba",
      "25 Jul 20",
      5.0,
      "Casa linda, espaçosa, limpa, curti!",
      "A casa é bem bonita mesmo, os quartos e a varanda são muito espaçosos, a garagem também, o local é muito bem cuidado e limpo, recomendo!",
    ],
    [
      "Mariana Damaceno Campos",
      "25 Jul 20",
      4.0,
      "Curti pra caramba, recomendo",
      "Curti, curti e curti, recomendo recomendo",
    ],
    [
      "Marcos Flavio Ferreira Borba",
      "25 Jul 20",
      5.0,
      "Casa linda, espaçosa, limpa, curti!",
      "A casa é bem bonita mesmo, os quartos e a varanda são muito espaçosos, a garagem também, o local é muito bem cuidado e limpo, recomendo!",
    ],
    [
      "Mariana Damaceno Campos",
      "25 Jul 20",
      4.0,
      "Curti pra caramba, recomendo",
      "Curti, curti e curti, recomendo recomendo",
    ],
  ];

  double selectStars;
  SharedPref sharedPrefUser = SharedPref();
  List valuesSharedPrefUser = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
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
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget returnHeader() {
    return MaterialTitle(
      title: titleAd,
      evaluationsForCalculeAmount: evaluations,
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
    return QuestionsAndAnswerContainer(
      questionsAnswers: questionsAnswers,
      userNameLocator: nameLocator,
    );
  }

  Widget returnSelectEvaluationAmountStars() {
    return SelectStarsEvaluation(
      hintText: "Select Evaluations Stars",
      onChanged: (SmoothStarRating value) {
        setState(() {
          selectStars = value.rating;
          _evaluation2ScrollController.jumpTo(index: 0);
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
