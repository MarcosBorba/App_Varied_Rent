import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EditPasswordFormConfirmEditPassword extends StatefulWidget {
  final double heightFormConfirmEditPassword;
  final String editPasswordHelperText;

  const EditPasswordFormConfirmEditPassword(
      {Key key,
      @required this.heightFormConfirmEditPassword,
      @required this.editPasswordHelperText})
      : assert(heightFormConfirmEditPassword != null),
        assert(editPasswordHelperText != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditPasswordFormConfirmEditPasswordState(
          heightFormConfirmEditPassword, editPasswordHelperText);
}

//TODO: colocar progress no botao
class EditPasswordFormConfirmEditPasswordState
    extends State<EditPasswordFormConfirmEditPassword> {
  double heightFormConfirmEditPassword;
  String editPasswordHelperText;
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditPassword = new GlobalKey();
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;

  EditPasswordFormConfirmEditPasswordState(
      this.heightFormConfirmEditPassword, this.editPasswordHelperText);

  @override
  Widget build(BuildContext context) {
    heightOfTextFieldsAccordingToContainerSize = EdgeInsets.symmetric(
        vertical: (heightFormConfirmEditPassword * 0.14) * 0.20,
        horizontal: (screenWidth * 0.94) * 0.04);
    return BlocBuilder<EditEmailAndPasswordBloc, EditEmailAndPasswordState>(
      builder: (context, state) {
        return Form(
          key: _keyFormEditPassword,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: heightFormConfirmEditPassword * 0.10,
                width: screenWidth * 0.80,
                child: returnsAnEditPasswordHelperText(editPasswordHelperText),
              ),
              Container(
                height: heightFormConfirmEditPassword * 0.20,
                child: returnsAnPasswordInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              Container(
                height: heightFormConfirmEditPassword * 0.20,
                child: returnsAnConfirmPasswordInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              returnsButtonConfirmEditPassword(
                  heightFormConfirmEditPassword * 0.08, screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget returnsAnEditPasswordHelperText(String passwordHelperText) {
    return Text(
      passwordHelperText,
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: AppColors.editEmailOrPasswordColorMainHelperText,
        fontSize: AppFontSize.s15,
      ),
    );
  }

  Widget returnsAnPasswordInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailOrPasswordTextsFields(
      contentPadding: contentPadding,
      inputController: _newPasswordController,
      labelText: AppTexts().confirmEditNewPasswordLabelTextField,
      hintText: AppTexts().confirmEditNewPasswordHintTextField,
      prefixIcon: Icons.lock,
      helperText: AppTexts().confirmEditNewPasswordHelperTextField,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().passwordFormFieldValidator,
    );
  }

  Widget returnsAnConfirmPasswordInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailOrPasswordTextsFields(
      contentPadding: contentPadding,
      inputController: _newPasswordConfirmController,
      labelText: AppTexts().confirmEditConfirmNewPasswordLabelTextField,
      hintText: AppTexts().confirmEditNewPasswordHintTextField,
      prefixIcon: Icons.lock,
      helperText: AppTexts().confirmEditNewPasswordHelperTextField,
      validator: FieldValidators().passwordFormFieldValidator,
    );
  }

  Widget returnsButtonConfirmEditPassword(
      double heightButton, double widthButton) {
    return EditEmailOrPasswordButtons(
      heightButton: heightButton,
      minWidthButton: widthButton,
      textButton: AppTexts().confirmEditPasswordTextButton,
      onPressed: () => functionVerifyNewPasswordAndNewPasswordConfirmed(),
    );
  }

  functionVerifyNewPasswordAndNewPasswordConfirmed() {
    _newPasswordController.text == _newPasswordConfirmController.text
        ? functionVerifyAndConfirmEditPassword()
        : functionShowErrorSnackBar();
  }

  functionVerifyAndConfirmEditPassword() {
    _keyFormEditPassword.currentState.validate()
        ? BlocProvider.of<EditEmailAndPasswordBloc>(context).add(
            ConfirmPasswordEditButtonPressed(
              newPassword: _newPasswordController.text,
              newPasswordConfirmed: _newPasswordConfirmController.text,
            ),
          )
        : false;
  }

  functionShowErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
            AppTexts().confirmEditConfirmNewPasswordMessageErrorEmailsEquals),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
