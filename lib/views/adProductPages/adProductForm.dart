import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/adProductPages/myAdsProductInheritedClass.dart';

class AdProductForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdProductFormState();
}

class AdProductFormState extends State<AdProductForm> {
  bool isAnAnnouncementOfTheLoggedUser;
  FocusNode focusTextField = FocusNode();
  TextEditingController _questionTextController = TextEditingController();
  final GlobalKey<FormState> _questionFieldKey = GlobalKey();

  ItemScrollController _evaluationScrollController = ItemScrollController();
  double selectStars;
  List<Evaluation> evaluations;

  @override
  Widget build(BuildContext context) {
    isAnAnnouncementOfTheLoggedUser =
        CacheProviderAdProduct.of(context).isAnAnnouncementOfTheLoggedUser;
    evaluations = CacheProviderAdProduct.of(context).evaluations;
    return Container(
      height: screenHeight,
      width: screenWidth,
      color: Colors.white,
      child: SafeArea(
          child: ListView(
        children: <Widget>[
          returnHeaderProduct(),
          returnSubTitleProduct(),
          returnImagesAdProduct(),
          returnDivider(AppTexts().myAdsProductDescription),
          returnDescription(),
          returnDivider(AppTexts().myAdsProductQuestions),
          returnQuestionsAndAnswer(),
          isAnAnnouncementOfTheLoggedUser
              ? Padding(padding: EdgeInsets.all(0.0))
              : returnAddQuestionsAndAnswer(),
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
      )),
    );
  }

  Widget returnHeaderProduct() {
    return new MaterialAdTitle();
  }

  Widget returnSubTitleProduct() {
    return SubTitleAdProduct();
  }

  Widget returnImagesAdProduct() {
    return ImagesAdProduct();
  }

  Widget returnDescription() {
    return DescriptionProduct();
  }

  Widget returnDivider(String textDivider) {
    return DividersAd(textTitleDivider: textDivider);
  }

  Widget returnQuestionsAndAnswer() {
    return new QuestionsAndAnswerAdContainer();
  }

  Widget returnAddQuestionsAndAnswer() {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.05,
        right: AppSizes.size10,
        left: AppSizes.size10,
      ),
      child: Form(
        key: _questionFieldKey,
        child: TextFieldDefaultAplication(
          inputController: _questionTextController,
          prefixIcon: Icons.question_answer,
          defaultFormColor: AppColors.tertiaryColor,
          focusedDefaultFormColor: AppColors.secondaryColor,
          borderWidth: AppSizes.size2,
          contentPadding: EdgeInsets.all(20),
          focusNode: focusTextField,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.send,
          hintText: "Ask a question",
          helperText: "Ex: What is the size of the product?",
          validator: FieldValidators().questionFormFieldValidator,
          onFieldSubmitted: (value) async {
            String idAd = CacheProviderAdProduct.of(context).idAd;
            List<QuestionAndAnswer> questionsAndAnswers =
                CacheProviderAdProduct.of(context).questionsAndAnswers;
            _questionFieldKey.currentState.validate()
                ? {
                    focusTextField.unfocus(),
                    _questionTextController.clear(),
                    print(value),
                    BlocProvider.of<AdProductPageBloc>(context).add(
                      AdProductPageAddQuestionAd(
                          idAd, value, questionsAndAnswers),
                    ),
                  }
                : FocusScope.of(context).requestFocus(focusTextField);
          },
        ),
      ),
    );
  }

  Widget returnSelectEvaluationAmountStars() {
    return SelectStarsEvaluationProduct(
      onChanged: (SmoothStarRating value) {
        setState(() {
          selectStars = value.rating;
          evaluations != null && evaluations.length > 0
              ? _evaluationScrollController.jumpTo(index: 0)
              : 0;
        });
      },
    );
  }

  Widget returnEvaluationsAd() {
    return EvaluationsProductAd(
      controllerItemRefreshListView: _evaluationScrollController,
      starSelected: selectStars,
    );
  }

  Widget returnLocatorInfo() {
    return LocatorInfoAdProduct();
  }
}
