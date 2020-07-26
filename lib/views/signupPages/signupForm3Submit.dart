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
//TODO: nivel 3 - melhorar perfomance para ver se email e cpf sao unicos, nos seus proprios formularios, para evitar troca de formularios e o usuario precisar voltar
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
        BlocProvider.of<AuthenticationBloc>(context).add(
          LoggedIn(
            id: userTransition.id,
            name: userTransition.name,
            genre: userTransition.genre,
            landlordType: userTransition.landlord_type,
            cpfCnpj: userTransition.cpf_cnpj,
            email: userTransition.email,
            phones: new Phones(
              telephone1: userTransition.phones.telephone1,
              telephone2: userTransition.phones.telephone2,
            ),
            address: new Address(
              country: userTransition.address.country,
              state: userTransition.address.state,
              city: userTransition.address.city,
              zip_code: userTransition.address.zip_code,
              neighborhood: userTransition.address.neighborhood,
              street: userTransition.address.street,
              number: userTransition.address.number,
            ),
            token: state.token,
          ),
        );
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
      labelText: AppTexts().addressCountryTextFieldLabelText,
      hintText: AppTexts().addressCountryTextFieldHintText,
      helperText: AppTexts().addressCountryTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().countryFormFieldValidator,
    );
  }

  Widget returnsAnStateInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _stateController,
      labelText: AppTexts().addressStateTextFieldLabelText,
      hintText: AppTexts().addressStateTextFieldHintText,
      helperText: AppTexts().addressStateTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().stateFormFieldValidator,
    );
  }

  Widget returnsAnCityInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _cityController,
      labelText: AppTexts().addressCityTextFieldLabelText,
      hintText: AppTexts().addressCityTextFieldHintText,
      helperText: AppTexts().addressCityTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().cityFormFieldValidator,
    );
  }

  Widget returnsAnZipCodeInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _zipCodeController,
      labelText: AppTexts().addressZipCodeTextFieldLabelText,
      hintText: AppTexts().addressZipCodeTextFieldHintText,
      helperText: AppTexts().addressZipCodeTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().zipCodeFormFieldValidator,
    );
  }

  Widget returnsAnNeighborhoodInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _neighborhoodController,
      labelText: AppTexts().addressNeighborhoodTextFieldLabelText,
      hintText: AppTexts().addressNeighborhoodTextFieldHintText,
      helperText: AppTexts().addressNeighborhoodTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().neighborhoodFormFieldValidator,
    );
  }

  Widget returnsAnStreetInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _streetController,
      labelText: AppTexts().addressStreetTextFieldLabelText,
      hintText: AppTexts().addressStreetTextFieldHintText,
      helperText: AppTexts().addressStreetTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().streetFormFieldValidator,
    );
  }

  Widget returnsAnNumberInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _numberController,
      labelText: AppTexts().addressNumberTextFieldLabelText,
      hintText: AppTexts().addressNumberTextFieldHintText,
      helperText: AppTexts().addressNumberTextFieldHelpText,
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
      country: _countryController.text,
      state: _stateController.text,
      city: _cityController.text,
      zip_code: _zipCodeController.text,
      neighborhood: _neighborhoodController.text,
      street: _streetController.text,
      number: _numberController.text,
    );

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
