import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getContainerDescription.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getDividersAd.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getEvaluationItem.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getImagesAd.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getMaterialTitle.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getQuestionsAndAnswerContainer.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getSubTitleAd.dart';
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
  List<Widget> stars = [
    SmoothStarRating(
      rating: 5.0,
      isReadOnly: true,
      size: AppSizes.size20,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      color: Colors.yellow,
      borderColor: Colors.yellow,
    ),
    SmoothStarRating(
      rating: 4.0,
      isReadOnly: true,
      size: AppSizes.size20,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      color: Colors.yellow,
      borderColor: Colors.yellow,
    ),
    SmoothStarRating(
      rating: 3.0,
      isReadOnly: true,
      size: AppSizes.size20,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      color: Colors.yellow,
      borderColor: Colors.yellow,
    ),
    SmoothStarRating(
      rating: 2.0,
      isReadOnly: true,
      size: AppSizes.size20,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      color: Colors.yellow,
      borderColor: Colors.yellow,
    ),
    SmoothStarRating(
      rating: 1.0,
      isReadOnly: true,
      size: AppSizes.size20,
      filledIconData: Icons.star,
      halfFilledIconData: Icons.star_half,
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      color: Colors.yellow,
      borderColor: Colors.yellow,
    ),
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
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.06,
                  right: screenWidth * 0.06,
                ),
                child: DropdownButtonFormField<SmoothStarRating>(
                  items: stars.map((Widget dropDownStringItem) {
                    return DropdownMenuItem<SmoothStarRating>(
                      value: dropDownStringItem,
                      child: dropDownStringItem,
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                    ),
                  ),
                  hint: Text("Select Evaluations Stars"),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: AppSizes.size30,
                  ),
                  onChanged: (SmoothStarRating value) {
                    setState(() {
                      _evaluation2ScrollController.jumpTo(index: 0);
                      selectStars = value.rating;
                    });
                  },
                ),
              ),
              Container(
                height: screenHeight * 0.20,
                width: screenWidth,
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _evaluation2ScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: evaluations.length,
                  itemBuilder: (context, index) {
                    return evaluations[index][2] == selectStars ||
                            selectStars == null
                        ? EvaluationItem(
                            userNameEvaluator: evaluations[index][0],
                            dayTimeEvaluation: evaluations[index][1],
                            amountStars: evaluations[index][2],
                            objectiveOpition: evaluations[index][3],
                            opinion: evaluations[index][4],
                          )
                        : Text("");
                  },
                ),
              ),
              returnDivider("Locator"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //TODO: nivel 1 - buscar forma de colocar imagem do usuario aqui
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.all(AppSizes.size12),
                        child: ImageLogoApp()),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      margin: EdgeInsets.all(AppSizes.size12),
                      child: FutureBuilder<List>(
                          future: getFutureDados(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    snapshot.data[0].toString(),
                                    style: TextStyle(fontSize: AppFontSize.s18),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.00500,
                                      bottom: screenHeight * 0.00500,
                                    ),
                                    child: Divider(
                                      indent: 10,
                                      endIndent: 10,
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[1].toString(),
                                    style: TextStyle(fontSize: AppFontSize.s16),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.00500,
                                      bottom: screenHeight * 0.00500,
                                    ),
                                    child: Divider(
                                      indent: 30,
                                      endIndent: 30,
                                      thickness: 1,
                                    ),
                                  ),
                                  Text(
                                    "Telephones:",
                                    style: TextStyle(fontSize: AppFontSize.s15),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  Text(
                                    snapshot.data[2]['telephone1'].toString() +
                                        "         " +
                                        snapshot.data[2]['telephone2']
                                            .toString(),
                                    style: TextStyle(fontSize: AppFontSize.s13),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text(AppTexts
                                    .myAccountTextToWaitForFutureBuilderDataToGetTheName),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              ),
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
                  ? print("1")
                  : index == 1 ? print("2") : index == 2 ? print("3") : false;
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
      userNameLocator: "Joao Gabriel Faria Borba da Silva",
    );
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

  Future<List> getFutureDados() async {
    await sharedPrefUser.read('name').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPrefUser.read('landlordType').then((value) {
      valuesSharedPrefUser.add(value);
    });
    await sharedPrefUser.read('phones').then((value) {
      valuesSharedPrefUser.add(value);
    });
    return valuesSharedPrefUser;
  }
}
