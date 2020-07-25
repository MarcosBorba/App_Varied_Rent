import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

//674 linhas antes otimizar
class MyAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageState();
}

//TODO: nivel 4 - definir texts, colors, routes....
class MyAdsPageState extends State<MyAdsPage> {
  String titleAd = "Viagens para lua de mel - EUA, MEX, BRA, FRA, CHI";
  String valueAd = "R\$ 2,00";
  String typeValueAd = " / Hr";
  String nameLocator = "Joao Gabriel Faria Borba da Silva";
  ItemScrollController _evaluation2ScrollController = ItemScrollController();
  int navigationBarBottomIndex = 0;
  final List<String> images = [
    'https://cdn.pixabay.com/photo/2020/05/15/11/49/pet-5173354_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/07/01/16/59/cherries-5360265_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/07/09/10/31/sea-5386810_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/14/17/17/kyrgyzstan-4765706_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/03/06/22/10/zakynthos-4908247_960_720.jpg',
  ];

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
              returnDescription(
                "O Mestre na arte da vida faz pouca distinção entre o seu trabalho e o seu lazer, entre a sua mente e o seu corpo, entre a sua educação e a sua recreação, entre o seu amor e a sua religião. Ele dificilmente sabe distinguir um corpo do outro. Ele simplesmente persegue sua visão de excelência em tudo que faz, deixando para os outros a decisão de saber se está trabalhando ou se divertindo. Ele acha que está sempre fazendo as duas coisas simultaneamente.",
              ),
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
      bottomNavigationBar: MyAccountPageFFNavigationBar(
        selectedIndex: navigationBarBottomIndex,
        onSelectTab: (index) {
          setState(
            () {
              navigationBarBottomIndex = index;
              index == 0
                  ? navigateToTheEditAdScreen()
                  : index == 1
                      ? navigateToTheReservationScreen()
                      : index == 2 ? navigateToTheChatScreen() : false;
            },
          );
        },
        bottomNavyBarItems: listBottomFFNavigationBarItems(),
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
      images: images,
    );
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(
      textTitleDivider: textDivider,
    );
  }

  Widget returnDescription(String description) {
    return Description(
      textDescription: description,
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

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.edit,
        label: "Edit Ad",
      ),
      FFNavigationBarItem(
        iconData: FontAwesome.calendar,
        label: "Reservations",
      ),
      FFNavigationBarItem(
        iconData: Icons.chat,
        label: "Chat",
      ),
    ];
    return fFNavigationBarItem;
  }

  navigateToTheEditAdScreen() {
    //print("pega os dados deste anuncio e ");
    print("navega para a tela de editar anuncio");
  }

  navigateToTheReservationScreen() {
    //ainda nao decidi como vai ser feito, se vai para uma nova tela ou cria um especie de pop up
    print("navega para a tela de editar e ver reserva");
  }

  navigateToTheChatScreen() {
    print("navega para a tela de chat");
  }
}
