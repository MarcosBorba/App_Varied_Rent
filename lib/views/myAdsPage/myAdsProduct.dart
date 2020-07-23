import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getEvaluationItem.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageState();
}

/* question: {
        tenant_name: { type: String, required: [true, 'Tenant name is required'] },
        tenant_email: { type: String, required: [true, 'Tenant email is required'] },
        question_date_time: { type: Date, required: [true, 'Question date time is required'] },
        question: { type: String, required: [true, 'Question is required'] },
    },
    answer: {
        locator_name: { type: String, required: [true, 'Locator name is required'] },
        locator_email: { type: String, required: [true, 'Locator email is required'] },
        answer_date_time: { type: Date, required: [true, 'Answer date time is required'] },
        answer: { type: String, required: [true, 'Answer is required'] },
    } */
class MyAdsPageState extends State<MyAdsPage> {
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
  ];
  @override
  Widget build(BuildContext context) {
    BuildContext context2 = context;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Material(
                elevation: 7,
                child: Container(
                  color: AppColors.tertiaryColor,
                  height: AppSizes.size100,
                  width: screenWidth,
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.05,
                    right: screenWidth * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Viagens para lua de mel - EUA, MEX, BRA, FRA, CHI",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: AppFontSize.s18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SmoothStarRating(
                        rating: 2.5,
                        isReadOnly: true,
                        size: AppSizes.size20,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                        onRated: (value) {
                          print("rating value -> $value");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "\$\$\$\$",
                      style: TextStyle(
                        fontSize: AppFontSize.s29,
                      ),
                    ),
                    Text(
                      " / Hr",
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: AppColors.tertiaryColor.withOpacity(0.1),
                elevation: 20,
                child: Container(
                  height: screenHeight * 0.40,
                  width: screenWidth,
                  color: Colors.transparent,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: images.length,
                    viewportFraction: 0.9,
                    scale: 0.95,
                    pagination: new SwiperPagination(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                    Text("Description"),
                    Expanded(
                      flex: 8,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.05,
                  bottom: screenHeight * 0.05,
                ),
                child: TextField(
                  enabled: false,
                  readOnly: true,
                  textDirection: TextDirection.ltr,
                  decoration: InputDecoration(
                    hintMaxLines: 100,
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 2, color: Colors.grey[300]),
                    ),
                    hintText:
                        "O Mestre na arte da vida faz pouca distinção entre o seu trabalho e o seu lazer, entre a sua mente e o seu corpo, entre a sua educação e a sua recreação, entre o seu amor e a sua religião. Ele dificilmente sabe distinguir um corpo do outro. Ele simplesmente persegue sua visão de excelência em tudo que faz, deixando para os outros a decisão de saber se está trabalhando ou se divertindo. Ele acha que está sempre fazendo as duas coisas simultaneamente.",
                    hintStyle: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                    Text("Questions"),
                    Expanded(
                      flex: 8,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.20,
                width: screenWidth,
                child: ListView.builder(
                  itemCount: questionsAnswers.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context2, index) {
                    return QuestionAndAnswerItem(
                      userNameQuestion: questionsAnswers[index][0],
                      dayTimeQuestion: questionsAnswers[index][1],
                      question: questionsAnswers[index][2],
                      userNameAnswer: questionsAnswers[index][3],
                      dayTimeAnswer: questionsAnswers[index][4],
                      answer: questionsAnswers[index][5],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.05,
                  top: screenHeight * 0.05,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                    Text("Evaluations"),
                    Expanded(
                      flex: 8,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.20,
                width: screenWidth,
                child: ListView.builder(
                  itemCount: evaluations.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context2, index) {
                    return EvaluationItem(
                      userNameEvaluator: evaluations[index][0],
                      dayTimeEvaluation: evaluations[index][1],
                      amountStars: evaluations[index][2],
                      objectiveOpition: evaluations[index][3],
                      opinion: evaluations[index][4],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.05,
                  top: screenHeight * 0.05,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                    Text("Locator"),
                    Expanded(
                      flex: 8,
                      child: Divider(
                        endIndent: AppSizes.size10,
                        indent: AppSizes.size10,
                        thickness: AppSizes.size2,
                      ),
                    ),
                  ],
                ),
              ),
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
                  : index == 1
                      ? print("2")
                      : index == 2
                          ? print("3")
                          : index == 3 ? print("4") : false;
            },
          );
        },
        bottomNavyBarItems: listBottomFFNavigationBarItems(),
      ),
    );
  }

  List<FFNavigationBarItem> listBottomFFNavigationBarItems() {
    var fFNavigationBarItem = [
      FFNavigationBarItem(
        iconData: Icons.menu,
        label: "Menu",
      ),
      FFNavigationBarItem(
        iconData: Icons.favorite,
        label: "Favorite",
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
}
