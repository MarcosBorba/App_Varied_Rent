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
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

//674 linhas antes otimizar
class MyAdsProduct extends StatefulWidget {
  const MyAdsProduct({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => MyAdsProductState();
}

//TODO: nivel 4 - definir texts, colors, routes....

class MyAdsProductState extends State<MyAdsProduct> {
  /* MyAdsProductState({
    Key key,
    this.titleAd = "NO TITLE",
    this.descriptionAd = "NO DESCRIPTION",
    this.valueAd = "0.00",
    this.imagesAd,
  }); */
  List<Evaluation> evaluations;
  String typeValueAd = " / Hr";
  ItemScrollController _evaluation2ScrollController = ItemScrollController();
  double selectStars;

  @override
  Widget build(BuildContext context) {
    evaluations = CacheProvider.of(context).evaluations;
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget returnHeader() {
    return new MaterialTitle();
  }

  Widget returnSubTitle() {
    return SubTitleAd(
      typeValue: typeValueAd,
    );
  }

  Widget returnImagesAd() {
    return ImagesAd();
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(
      textTitleDivider: textDivider,
    );
  }

  Widget returnDescription() {
    return Description();
  }

  Widget returnQuestionsAndAnswer() {
    return new QuestionsAndAnswerContainer();
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
      controllerItemRefreshListView: _evaluation2ScrollController,
      starSelected: selectStars,
    );
  }

  Widget returnLocatorInfo() {
    return LocatorInfo();
  }
}
