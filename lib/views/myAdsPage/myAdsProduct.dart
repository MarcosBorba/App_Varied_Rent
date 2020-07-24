import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/components/componentsMyAdsProduct/getEvaluationItem.dart';
import 'package:varied_rent/repositories/repositories.dart';
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

  double mediana() {
    double median = 0.0;
    double sum = 0.0;
    for (var index = 0; index < evaluations.length; index++) {
      sum += (evaluations[index][2]);
    }
    median = sum / evaluations.length;
    return median;
  }

  SharedPref sharedPrefUser = SharedPref();
  List valuesSharedPrefUser = [];

  @override
  Widget build(BuildContext context) {
    addResponseOnQuestion(
        response, String userName, String dataResponse, index) {
      setState(() {
        questionsAnswers[index][3] = userName;
        questionsAnswers[index][4] = dataResponse;
        questionsAnswers[index][5] = response;
      });
    }

    editResponseOnQuestion(index) {
      setState(() {
        questionsAnswers[index][3] = null;
        questionsAnswers[index][4] = null;
        questionsAnswers[index][5] = null;
      });
    }

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SmoothStarRating(
                            rating: mediana(),
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
                          Text(
                            " ( " + evaluations.length.toString() + " )",
                            style: TextStyle(color: Colors.yellow),
                          )
                        ],
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
                      "R\$ 2,00",
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
                      onSubmitted: (value) {
                        String formattedDate =
                            DateFormat('d MMM yy').format(DateTime.now());
                        addResponseOnQuestion(
                          value,
                          "Joao Gabriel Faria Borba da Silva",
                          formattedDate,
                          index,
                        );
                      },
                      onEditIconButtonPressed: () {
                        editResponseOnQuestion(index);
                      },
                      //onSubmitted: () {

                      //a resposta envia pro banco só com o submit

                      //pega o controller text
                      //pega data
                      //pega nome locador

                      //muda para um estado de enviar resposta
                      //envia a resposta pro banco na questao x
                      //retorna se deu sucesso ou falha

                      //retorna um snack bar
                      //sucesso modifica a questao com a resposta
                      // },
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: screenHeight * 0.05,
                  top: screenHeight * 0.03,
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
              Padding(
                padding: EdgeInsets.only(
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
