import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myAdProductPages/myAdsProductInheritedClass.dart';

class MyAdsProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsProductState();
}

class MyAdsProductState extends State<MyAdsProduct> {
  ItemScrollController _evaluation2ScrollController = ItemScrollController();
  List<Evaluation> evaluations;
  double selectStars;

  @override
  Widget build(BuildContext context) {
    evaluations = CacheProvider.of(context).evaluations;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColors.tertiaryColor,
          ),
          child: Container(
            height: screenHeight,
            width: screenWidth,
            color: AppColors.adsProductBackgroundPage,
            child: SafeArea(
              child: ListView(
                children: <Widget>[
                  returnHeader(),
                  returnSubTitle(),
                  returnImagesAd(),
                  returnDivider(AppTexts().myAdsProductDescription),
                  returnDescription(),
                  returnDivider(AppTexts().myAdsProductQuestions),
                  returnQuestionsAndAnswer(),
                  returnDivider(AppTexts().myAdsProductEvaluations),
                  returnSelectEvaluationAmountStars(),
                  returnEvaluationsAd(),
                  returnDivider(AppTexts().myAdsProductLocator),
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
        ),
      ),
    );
  }

  Widget returnHeader() {
    return new MaterialTitle();
  }

  Widget returnSubTitle() {
    return SubTitleAd();
  }

  Widget returnImagesAd() {
    return ImagesAd();
  }

  Widget returnDescription() {
    return Description();
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(
      textTitleDivider: textDivider,
    );
  }

  Widget returnQuestionsAndAnswer() {
    return new QuestionsAndAnswerContainer();
  }

  Widget returnSelectEvaluationAmountStars() {
    return SelectStarsEvaluation(
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
