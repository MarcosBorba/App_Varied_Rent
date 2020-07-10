import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailFormConfirmUser extends StatefulWidget {
  final double heightFormConfirmUser;
  final String titlePasswordHelperText;
  final String dataThatWillEdit;
  final EditEmailAndPasswordState state;

  const EditEmailFormConfirmUser(
      {Key key,
      this.heightFormConfirmUser,
      this.titlePasswordHelperText,
      this.dataThatWillEdit,
      this.state})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => EditEmailFormConfirmUserState(
        heightFormConfirmUser,
        titlePasswordHelperText,
        dataThatWillEdit,
        state,
      );
}

class EditEmailFormConfirmUserState extends State<EditEmailFormConfirmUser> {
  double heightFormConfirmUser;
  String titlePasswordHelperText;
  String dataThatWillEdit;
  EditEmailAndPasswordState state;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditEmail = new GlobalKey();
  bool _obscurePassword = true;
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;
  final double heightLinearProgressLoading =
      ((screenHeight * 0.65) * 0.11) * 0.15;
  final double widthLinearProgressLoading = (screenWidth * 0.94) * 0.94;

  EditEmailFormConfirmUserState(this.heightFormConfirmUser,
      this.titlePasswordHelperText, this.dataThatWillEdit, this.state);

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
                child:
                    returnsAnTitlePasswordHelperText(titlePasswordHelperText),
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
                  ? Container(
                      height: heightFormConfirmUser * 0.08,
                      width: screenWidth,
                      child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            returnsARoundedLinearProgressLoading(
                                heightLinearProgressLoading,
                                widthLinearProgressLoading),
                          ]))
                  : returnsButtonConfirmedUser(
                      heightFormConfirmUser * 0.08, screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget returnsAnTitlePasswordHelperText(String titlePasswordHelperText) {
    return Text(
      titlePasswordHelperText,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: AppColors.editEmailColorMainHelperText,
        fontSize: AppFontSize.s15,
      ),
    );
  }

  Widget returnsAnEmailInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailTextsFields(
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
    return EditEmailTextsFields(
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
    return SuffixIconEditEmailPasswordInput(
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
    return EditEmailButtons(
      heightButton: heightButton,
      minWidthButton: widthButton,
      textButton: AppTexts().confirmUserTextButton,
      onPressed: () => functionVerifyAndConfirmUser(),
    );
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
