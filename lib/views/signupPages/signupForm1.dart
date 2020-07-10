import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/utils/validators.dart';
import 'package:varied_rent/views/SignupPages/signupPage.dart';

class SignupForm1 extends StatefulWidget {
  @override
  State<SignupForm1> createState() => _SignupForm1State();
}

class _SignupForm1State extends State<SignupForm1> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _keyFormSignup = new GlobalKey();
  bool _obscurePassword = true;
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
              registrationForm: 2,
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
                height: (screenHeight * 0.85) * 0.85,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.02,
                    right: screenWidth * 0.02,
                  ),
                  child: returnsAccountTextsFields(),
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

  Widget returnsAccountTextsFields() {
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
          height: (screenHeight * 0.85) * 0.20,
          child:
              returnsAnEmailInput(heightOfTextFieldsAccordingToContainerSize),
        ),
        Container(
          height: (screenHeight * 0.85) * 0.20,
          child: returnsAnPasswordInput(
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
          Icons.email,
          size: AppSizes.size40,
          color: AppColors.tertiaryColor,
        ),
        SizedBox(
          width: spaceBetweenIconAndText,
        ),
        Text(
          "Account",
          style: TextStyle(
              color: AppColors.tertiaryColor, fontSize: AppFontSize.s20),
        ),
      ],
    );
  }

  Widget returnsAnEmailInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
      contentPadding: contentPadding,
      inputController: _emailController,
      labelText: AppTexts().emailTextFieldLabelText,
      hintText: AppTexts().hintTextFromEmailTextField,
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().emailTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnPasswordInput(EdgeInsetsGeometry contentPadding) {
    return SignupTextsFields(
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
    return SuffixIconSignupPasswordInput(
      obscurePassword: _obscurePassword,
      onPressed: () {
        _onLoginIconPasswordPressed();
      },
    ).build(context);
  }

  _onLoginIconPasswordPressed() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
    BlocProvider.of<SignupBloc>(context).add(SignupButtonContinuePressed(
        user: new User(
            email: _emailController.text, password: _passwordController.text)));
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
