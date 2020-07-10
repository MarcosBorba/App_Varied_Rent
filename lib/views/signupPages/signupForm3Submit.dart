import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/homePages/myHomePage.dart';

class SignupForm3Submit extends StatefulWidget {
  final User user;

  const SignupForm3Submit({Key key, @required this.user}) : super(key: key);

  @override
  State<SignupForm3Submit> createState() =>
      _SignupForm3SubmitState(userTransition: user);
}

//TODO: nivel 1 - estudar e implementar busca de enderecos no backend para trazer opcoes pro usuario
class _SignupForm3SubmitState extends State<SignupForm3Submit> {
  final User userTransition;
  _SignupForm3SubmitState({this.userTransition});
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final GlobalKey<FormState> _keyFormSignup = new GlobalKey();
  final double containerBorderWidth = (screenWidth * 0.94) * 0.01;
  final double minWidthMainButtons = (screenWidth * 0.94) * 0.94;
  final double heightMainButtons = (screenHeight * 0.85) * 0.08500;
  final EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize =
      EdgeInsets.symmetric(
          vertical: ((screenHeight * 0.85) * 0.14) * 0.20,
          horizontal: (screenWidth * 0.94) * 0.04);
  final double heightLinearProgressLoading =
      ((screenHeight * 0.85) * 0.08500) * 0.15;
  final double widthLinearProgressLoading = (screenWidth * 0.94) * 0.94;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(listener: (context, state) {
      if (state is SignupFailure) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      } else if (state is SignupSuccessfullyConcluded) {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedIn(token: state.token));
        AppRoutes.makeFirst(context, HomePage());
      }
    }, child: BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      return Form(
        key: _keyFormSignup,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Container(
                decoration:
                    returnsSignupFormBoxDecoration(containerBorderWidth),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                  ),
                  child: returnsAddressTextsFields(),
                )),
            SizedBox(
              height: (screenHeight * 0.85) * 0.03,
            ),
            state is SignupLoading
                ? Container(
                    height: heightMainButtons,
                    width: minWidthMainButtons,
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      returnsARoundedLinearProgressLoading(
                          heightLinearProgressLoading,
                          widthLinearProgressLoading),
                    ]))
                : returnsButtonSubmitSignup(
                    state, minWidthMainButtons, heightMainButtons),
            SizedBox(
              height: (screenHeight * 0.85) * 0.03,
            ),
          ],
        ),
      );
    }));
  }

  BoxDecoration returnsSignupFormBoxDecoration(double widthBorder) {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppSizes.size40)),
        color: Colors.white,
        border: Border.all(
          color: AppColors.secondaryColor,
          width: widthBorder,
        ));
  }

  Widget returnsAddressTextsFields() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: (screenHeight * 0.85) * 0.10,
        ),
        returnsALineWithAnIconAndATextForTheTitle(screenWidth * 0.04),
        SizedBox(
          height: (screenHeight * 0.85) * 0.10,
        ),
        Divider(
          endIndent: AppSizes.size10,
          indent: AppSizes.size10,
          thickness: AppSizes.size2,
        ),
        SizedBox(
          height: (screenHeight * 0.85) * 0.13,
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnCountryInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnStateInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnsAnCityInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnZipCodeInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnsAnNeighborhoodInput(
              heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnStreetInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnNumberInput(heightOfTextFieldsAccordingToContainerSize),
        ),
      ],
    );
  }

  Widget returnsALineWithAnIconAndATextForTheTitle(
      double spaceBetweenIconAndText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.add_location,
          size: AppSizes.size40,
          color: AppColors.tertiaryColor,
        ),
        SizedBox(
          width: spaceBetweenIconAndText,
        ),
        Text(
          "Address",
          style: TextStyle(
              color: AppColors.tertiaryColor, fontSize: AppFontSize.s20),
        ),
      ],
    );
  }

  Widget returnsAnCountryInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _countryController,
      labelText: AppTexts().countryTextFieldLabelText,
      hintText: AppTexts().hintTextFromCountryTextField,
      helperText: AppTexts().countryTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().countryFormFieldValidator,
    );
  }

  Widget returnsAnStateInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _stateController,
      labelText: AppTexts().stateTextFieldLabelText,
      hintText: AppTexts().hintTextFromStateTextField,
      helperText: AppTexts().stateTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().stateFormFieldValidator,
    );
  }

  Widget returnsAnCityInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _cityController,
      labelText: AppTexts().cityTextFieldLabelText,
      hintText: AppTexts().hintTextFromCityTextField,
      helperText: AppTexts().cityTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().cityFormFieldValidator,
    );
  }

  Widget returnsAnZipCodeInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _zipCodeController,
      labelText: AppTexts().zipCodeTextFieldLabelText,
      hintText: AppTexts().hintTextFromZipCodeTextField,
      helperText: AppTexts().zipCodeTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().zipCodeFormFieldValidator,
    );
  }

  Widget returnsAnNeighborhoodInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _neighborhoodController,
      labelText: AppTexts().neighborhoodTextFieldLabelText,
      hintText: AppTexts().hintTextFromNeighborhoodTextField,
      helperText: AppTexts().neighborhoodTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().neighborhoodFormFieldValidator,
    );
  }

  Widget returnsAnStreetInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _streetController,
      labelText: AppTexts().streetTextFieldLabelText,
      hintText: AppTexts().hintTextFromStreetTextField,
      helperText: AppTexts().streetTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().streetFormFieldValidator,
    );
  }

  Widget returnsAnNumberInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _numberController,
      labelText: AppTexts().numberTextFieldLabelText,
      hintText: AppTexts().hintTextFromNumberTextField,
      helperText: AppTexts().numberTextFieldHelpText,
      validator: FieldValidators().numberFormFieldValidator,
    );
  }

  Widget returnsButtonSubmitSignup(
      state, double minWidthButton, double heightButton) {
    return SignupMainButtons(
      minWidthButton: minWidthButton,
      heightButton: heightButton,
      color: AppColors().buttonColorDefault,
      splashColor: AppColors().buttonColorWhenClicking,
      disabledColor: AppColors().buttonColorWhenClicking,
      textButton: AppTexts().signupFinalizeRegistrationButtonText,
      onPressed: () {
        returnFunctionOnPressedButtonSignup(state);
      },
    );
  }

  returnFunctionOnPressedButtonSignup(state) {
    state is! SignupLoading
        ? _keyFormSignup.currentState.validate()
            ? _onSignupButtonPressed()
            : false
        : false;
  }

  _onSignupButtonPressed() {
    userTransition.address = Address(
        _countryController.text,
        _stateController.text,
        _cityController.text,
        _zipCodeController.text,
        _neighborhoodController.text,
        _streetController.text,
        _numberController.text);

    BlocProvider.of<SignupBloc>(context)
        .add(SignupButtonSubmitPressed(user: userTransition));
  }

  Widget returnsARoundedLinearProgressLoading(
      double linearHeight, double linearWidth) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: linearHeight,
          width: linearWidth,
          child: returnsLinearProgressLoading(),
        ));
  }

  Widget returnsLinearProgressLoading() {
    return LinearProgressIndicator(
      backgroundColor: AppColors.secondaryColor,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.tertiaryColor),
    );
  }
}
