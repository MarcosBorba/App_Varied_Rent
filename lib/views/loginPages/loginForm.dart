import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/utils/validators.dart';
import 'package:varied_rent/views/SignupPages/signupPage.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = new GlobalKey();
  bool _obscurePassword = true;
  final EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize =
      EdgeInsets.symmetric(
          vertical: ((screenHeight * 0.65) * 0.20) * 0.19,
          horizontal: (screenWidth * 0.94) * 0.04);
  final double minWidthMainButtons = (screenWidth * 0.94) * 0.94;
  final double heightMainButtons = (screenHeight * 0.65) * 0.11;
  final double heightLinearProgressLoading =
      ((screenHeight * 0.65) * 0.11) * 0.15;
  final double widthLinearProgressLoading = (screenWidth * 0.94) * 0.94;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5)),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(
                  left: (screenWidth * 0.94) * 0.02,
                  right: (screenWidth * 0.94) * 0.02,
                  top: (screenHeight * 0.65) * 0.03,
                  bottom: (screenHeight * 0.65) * 0.03),
              child: Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: (screenHeight * 0.65) * 0.21,
                      child: returnsAnEmailInput(
                          heightOfTextFieldsAccordingToContainerSize),
                    ),
                    Container(
                      height: (screenHeight * 0.65) * 0.23,
                      child: returnsAnPasswordInput(
                          heightOfTextFieldsAccordingToContainerSize),
                    ),
                    Container(
                      height: (screenHeight * 0.65) * 0.12,
                      child:
                          returnsARowWithANavigationButtonToRetrieveTheForgottenPassword(),
                    ),
                    state is LoginLoading
                        ? Container(
                            height: heightMainButtons,
                            width: minWidthMainButtons,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  returnsARoundedLinearProgressLoading(
                                      heightLinearProgressLoading,
                                      widthLinearProgressLoading),
                                ]))
                        : returnsButtonLogin(
                            state, minWidthMainButtons, heightMainButtons),
                    Container(
                        height: (screenHeight * 0.65) * 0.10,
                        child: returnsARowWithDividerOfTheMainButtons()),
                    returnsButtonSignup(minWidthMainButtons, heightMainButtons),
                  ],
                ),
              ));
        },
      ),
    );
  }

  _onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  Widget returnsAnEmailInput(EdgeInsetsGeometry contentPadding) {
    return LoginTextsFields(
      contentPadding: contentPadding,
      inputController: _emailController,
      labelText: AppTexts().emailTextFieldLabelText,
      hintText: AppTexts().hintTextFromEmailTextField,
      prefixIcon: Icons.email,
      helperText: AppTexts().emailTextFieldHelpText,
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnPasswordInput(EdgeInsetsGeometry contentPadding) {
    return LoginTextsFields(
      contentPadding: contentPadding,
      inputController: _passwordController,
      labelText: AppTexts().passwordTextFieldLabelText,
      hintText: AppTexts().hintTextFromPasswordTextField,
      prefixIcon: Icons.lock,
      helperText: AppTexts().passwordTextFieldHelpText,
      suffixIcon: returnsSuffixIconPasswordInput(),
      obscureText: _obscurePassword,
      validator: FieldValidators().passwordFormFieldValidator,
    );
  }

  Widget returnsSuffixIconPasswordInput() {
    return SuffixIconPasswordInput(
      onPressed: () {
        _onLoginIconPasswordPressed();
      },
      obscurePassword: _obscurePassword,
    ).build(context);
  }

  _onLoginIconPasswordPressed() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget returnsButtonLogin(state, double minWidthButton, double heightButton) {
    return LoginMainButtons(
      minWidthButton: minWidthButton,
      heightButton: heightButton,
      color: AppColors().buttonColorDefault,
      splashColor: AppColors().buttonColorWhenClicking,
      disabledColor: AppColors().buttonColorWhenClicking,
      textButton: AppTexts().loginButtonText,
      onPressed: () {
        returnFunctionOnPressedButtonLogin(state);
      },
    );
  }

  returnFunctionOnPressedButtonLogin(state) {
    state is! LoginLoading
        ? _key.currentState.validate() ? _onLoginButtonPressed() : false
        : false;
  }

  Widget returnsButtonSignup(double minWidthButton, double heightButton) {
    return LoginMainButtons(
      minWidthButton: minWidthButton,
      heightButton: heightMainButtons,
      color: AppColors.tertiaryColor,
      splashColor: AppColors.secondaryColor,
      disabledColor: AppColors.secondaryColor,
      textButton: AppTexts().signupButtonText,
      onPressed: returnFunctionOnPressedButtonSignup,
    );
  }

  returnFunctionOnPressedButtonSignup() {
    final UserRepository userRepository = UserRepository(
      userApiClient: UserApiClient(),
    );
    AppRoutes.push(context,
        SignupPage(userRepository: userRepository, registrationForm: 1));
  }

  Widget returnsARowWithANavigationButtonToRetrieveTheForgottenPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        returnsNavigationButtonToRetrieveTheForgottenPassword(),
      ],
    );
  }

  Widget returnsNavigationButtonToRetrieveTheForgottenPassword() {
    return FlatButtonLinkForScreenNavigation(
      splashColor: AppColors.transparentBackground,
      textButton: AppTexts().questionTextForgotPassword,
      onPressed: returnFunctionOnPressedButtonRetrieveTheForgottenPassword,
    );
  }

  returnFunctionOnPressedButtonRetrieveTheForgottenPassword() {
    print("Forgot Password?");
  }

  Widget returnsARowWithDividerOfTheMainButtons() {
    return Row(children: <Widget>[
      Expanded(
          child: Divider(
        endIndent: AppSizes.size10,
        indent: AppSizes.size10,
        thickness: AppSizes.size2,
      )),
      Text(AppTexts().dividerTextButtonLoginAndButtonSignup),
      Expanded(
          child: Divider(
        endIndent: AppSizes.size10,
        indent: AppSizes.size10,
        thickness: AppSizes.size2,
      )),
    ]);
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
