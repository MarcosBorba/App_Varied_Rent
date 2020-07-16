import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/SignupPages/signupPage.dart';

class SignupForm2 extends StatefulWidget {
  final User user;

  const SignupForm2({Key key, @required this.user}) : super(key: key);

  @override
  State<SignupForm2> createState() => _SignupForm2State(userTransition: user);
}

class _SignupForm2State extends State<SignupForm2> {
  final User userTransition;
  _SignupForm2State({this.userTransition});
  final _nameController = TextEditingController();
  final _cpfCnpjController = TextEditingController();
  final _telephone1Controller = TextEditingController();
  final _telephone2Controller = TextEditingController();
  var selectedItemOfGenderType;
  var selectedItemOfLandlordType;
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
            duration: Duration(seconds: 4),
          ),
        );
      } else if (state is SignupTransitionFormScreen) {
        final UserRepository userRepository = UserRepository(
          userApiClient: UserApiClient(),
        );
        AppRoutes.push(
            context,
            SignupPage(
              userRepository: userRepository,
              registrationForm: 3,
              user: state.user,
            ));
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
                  child: returnsProfileTextsFields(),
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

  Widget returnsProfileTextsFields() {
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
          child: returnsAnNameInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnDropDownButtonSelectorGenderType(),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnDropDownButtonSelectorLandlordType(),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child:
              returnsAnCpfCnpjInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnsAnTelephoneMandatoryInput(
              heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.18,
          child: returnsAnTelephoneOptionalInput(
              heightOfTextFieldsAccordingToContainerSize),
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
          Icons.account_circle,
          size: AppSizes.size40,
          color: AppColors.tertiaryColor,
        ),
        SizedBox(
          width: spaceBetweenIconAndText,
        ),
        Text(
          "Profile",
          style: TextStyle(
              color: AppColors.tertiaryColor, fontSize: AppFontSize.s20),
        ),
      ],
    );
  }

  Widget returnsAnNameInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _nameController,
      labelText: AppTexts().nameTextFieldLabelText,
      hintText: AppTexts().hintTextFromNameTextField,
      prefixIcon: Icons.tag_faces,
      helperText: AppTexts().nameTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().nameFormFieldValidator,
    );
  }

  Widget returnDropDownButtonSelectorGenderType() {
    return SignupDropDownButtonSelectors(
      prefixIcon: FontAwesome.venus_mars,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().hintTextFromGenderSelector,
      helperText: AppTexts().genderSelectordHelpText,
      items: AppTexts().genderTypesList,
      value: selectedItemOfGenderType,
      validator: FieldValidators().genderFormFieldValidator,
      onChanged: (String novoItemSelecionado) {
        _dropDownItemSelected(novoItemSelecionado);
      },
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this.selectedItemOfGenderType = novoItem;
    });
  }

  Widget returnDropDownButtonSelectorLandlordType() {
    return SignupDropDownButtonSelectors(
      prefixIcon: Icons.work,
      suffixIcon: Icons.arrow_drop_down,
      hint: AppTexts().hintTextFromLandlordSelector,
      helperText: AppTexts().landlordSelectordHelpText,
      items: AppTexts().landlordTypesList,
      value: selectedItemOfLandlordType,
      validator: FieldValidators().landlordTypeFormFieldValidator,
      onChanged: (String novoItemSelecionado) {
        _dropDownItemSelectedLand(novoItemSelecionado);
      },
    );
  }

  void _dropDownItemSelectedLand(String novoItem) {
    setState(() {
      this.selectedItemOfLandlordType = novoItem;
    });
  }

  Widget returnsAnCpfCnpjInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _cpfCnpjController,
      labelText: AppTexts().cpfCnpjTextFieldLabelText,
      hintText: AppTexts().hintTextFromCpfCnpjTextField,
      prefixIcon: FontAwesome5.id_badge,
      helperText: AppTexts().cpfCnpjTextFieldHelpText,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().cpfCnpjFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XXX.XXX.XXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX"),
      ],
    );
  }

  Widget returnsAnTelephoneMandatoryInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _telephone1Controller,
      labelText: AppTexts().telephoneMandatoryTextFieldLabelText,
      hintText: AppTexts().hintTextFromTelephoneMandatoryTextField,
      prefixIcon: Icons.phone_android,
      helperText: AppTexts().telephoneMandatoryTextFieldHelpText,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().telephoneMandatoryFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XX XXXX-XXXX", maskTWO: "XX XXXXX-XXXX"),
      ],
    );
  }

  Widget returnsAnTelephoneOptionalInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _telephone2Controller,
      labelText: AppTexts().telephoneOptionalTextFieldLabelText,
      hintText: AppTexts().hintTextFromTelephoneOptionalTextField,
      prefixIcon: ModernPictograms.mobile,
      helperText: AppTexts().telephoneOptionalTextFieldHelpText,
      keyboardType: TextInputType.number,
      validator: FieldValidators().telephoneOptionalFormFieldValidator,
      inputFormatters: [
        MaskedTextInputFormatterShifter(
            maskONE: "XX XXXX-XXXX", maskTWO: "XX XXXXX-XXXX"),
      ],
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
      textButton: AppTexts().signupContinueRegistrationButtonText,
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
    userTransition.name = _nameController.text;
    userTransition.genre = selectedItemOfGenderType.toString();
    userTransition.landlord_type = selectedItemOfLandlordType.toString();
    userTransition.cpf_cnpj = _cpfCnpjController.text;
    userTransition.phones = new Phones(
        telephone1: _telephone1Controller.text,
        telephone2: _telephone2Controller.text);

    BlocProvider.of<SignupBloc>(context)
        .add(SignupButtonContinuePressed(user: userTransition));
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
