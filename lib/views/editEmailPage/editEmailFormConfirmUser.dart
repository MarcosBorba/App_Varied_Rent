import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/componentsEditEmailPage/componentsEditEmail.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailFormConfirmUser extends StatefulWidget {
  final double heightFormConfirmUser;

  const EditEmailFormConfirmUser({Key key, this.heightFormConfirmUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditEmailFormConfirmUserState(heightFormConfirmUser);
}

class EditEmailFormConfirmUserState extends State<EditEmailFormConfirmUser> {
  double heightFormConfirmUser;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditEmail = new GlobalKey();
  bool _obscurePassword = true;
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;

  EditEmailFormConfirmUserState(this.heightFormConfirmUser);

  @override
  Widget build(BuildContext context) {
    heightOfTextFieldsAccordingToContainerSize = EdgeInsets.symmetric(
        vertical: (heightFormConfirmUser * 0.14) * 0.20,
        horizontal: (screenWidth * 0.94) * 0.04);
    return BlocBuilder<EditEmailBloc, EditEmailState>(
      builder: (context, state) {
        return Form(
          key: _keyFormEditEmail,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: heightFormConfirmUser * 0.10,
                width: screenWidth * 0.80,
                child: returnsAnHelperText(),
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
              returnsButtonConfirmedUser(
                  heightFormConfirmUser * 0.08, screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget returnsAnHelperText() {
    return Text(
      AppTexts().confirmUserHelperText,
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

  functionVerifyAndConfirmUser() {
    _keyFormEditEmail.currentState.validate()
        ? BlocProvider.of<EditEmailBloc>(context)
            .add(EditEmailButtonConfirmUserPressed(
                user: new User.login(
            _emailController.text,
            _passwordController.text,
          )))
        : false;
  }
}
