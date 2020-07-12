import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailFormConfirmUser extends StatefulWidget {
  final double heightFormConfirmUser;
  final String titleConfirmUserHelperText;
  final String dataThatWillEdit;

  const EditEmailFormConfirmUser({
    Key key,
    this.heightFormConfirmUser,
    this.titleConfirmUserHelperText,
    this.dataThatWillEdit,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => EditEmailFormConfirmUserState(
        heightFormConfirmUser,
        titleConfirmUserHelperText,
        dataThatWillEdit,
      );
}

class EditEmailFormConfirmUserState extends State<EditEmailFormConfirmUser> {
  double heightFormConfirmUser;
  String titleConfirmUserHelperText;
  String dataThatWillEdit;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditEmail = new GlobalKey();
  bool _obscurePassword = true;
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;
  final double heightLinearProgressLoading =
      ((screenHeight * 0.65) * 0.11) * 0.15;
  final double widthLinearProgressLoading = (screenWidth * 0.94) * 0.94;

  EditEmailFormConfirmUserState(this.heightFormConfirmUser,
      this.titleConfirmUserHelperText, this.dataThatWillEdit);

  @override
  Widget build(BuildContext context) {
    heightOfTextFieldsAccordingToContainerSize = EdgeInsets.symmetric(
        vertical: (heightFormConfirmUser * 0.14) * 0.20,
        horizontal: (screenWidth * 0.94) * 0.04);
    return BlocBuilder<EditEmailAndPasswordBloc, EditEmailAndPasswordState>(
      builder: (context, state) {
        return Form(
          key: _keyFormEditEmail,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: heightFormConfirmUser * 0.10,
                width: screenWidth * 0.80,
                child: returnsAnTitlePasswordHelperText(
                    titleConfirmUserHelperText),
              ),
              Container(
                height: heightFormConfirmUser * 0.20,
                child: returnsAnEmailInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              Container(
                height: heightFormConfirmUser * 0.20,
                child: returnsAnPasswordInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              state is LoadingDataEditing
                  ? EditEmailOrPasswordLinearProgressIndicator(
                      heightDisponibleProgressIndicator:
                          heightFormConfirmUser * 0.08,
                      widthDisponibleProgressIndicator: screenWidth,
                      heightLinearProgressLoading: heightLinearProgressLoading,
                      widthLinearProgressLoading: widthLinearProgressLoading,
                    )
                  : returnsButtonConfirmedUser(
                      heightFormConfirmUser * 0.08, screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget returnsAnTitlePasswordHelperText(String titleConfirmUserHelperText) {
    return Text(
      titleConfirmUserHelperText,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: AppColors.editEmailOrPasswordColorMainHelperText,
        fontSize: AppFontSize.s15,
      ),
    );
  }

  Widget returnsAnEmailInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailOrPasswordTextsFields(
      contentPadding: contentPadding,
      inputController: _emailController,
      labelText: AppTexts().confirmUserEmailLabelTextField,
      hintText: AppTexts().confirmUserEmailHintTextField,
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().confirmUserEmailHelperTextField,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnPasswordInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailOrPasswordTextsFields(
      contentPadding: contentPadding,
      inputController: _passwordController,
      labelText: AppTexts().confirmUserPasswordLabelTextField,
      hintText: AppTexts().confirmUserPasswordHintTextField,
      prefixIcon: Icons.lock,
      helperText: AppTexts().confirmUserPasswordHelperTextField,
      suffixIcon: returnsSuffixIconPasswordInput(),
      obscureText: _obscurePassword,
      validator: FieldValidators().passwordFormFieldValidator,
    );
  }

  Widget returnsSuffixIconPasswordInput() {
    return EditEmailOrPasswordInputSuffixIconPassword(
      obscurePassword: _obscurePassword,
      onPressed: () {
        _onEditEmailIconPasswordPressed();
      },
    ).build(context);
  }

  _onEditEmailIconPasswordPressed() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Widget returnsButtonConfirmedUser(double heightButton, double widthButton) {
    return EditEmailOrPasswordButtons(
      heightButton: heightButton,
      minWidthButton: widthButton,
      textButton: AppTexts().confirmUserTextButton,
      onPressed: () => functionVerifyAndConfirmUser(),
    );
  }

  functionVerifyAndConfirmUser() {
    _keyFormEditEmail.currentState.validate()
        ? dataThatWillEdit == "Email"
            ? BlocProvider.of<EditEmailAndPasswordBloc>(context)
                .add(EmailButtonConfirmUserPressed(
                    user: new User.login(
                _emailController.text,
                _passwordController.text,
              )))
            : dataThatWillEdit == "Password"
                ? BlocProvider.of<EditEmailAndPasswordBloc>(context)
                    .add(PasswordButtonConfirmUserPressed(
                        user: new User.login(
                    _emailController.text,
                    _passwordController.text,
                  )))
                : false
        : false;
  }
}
