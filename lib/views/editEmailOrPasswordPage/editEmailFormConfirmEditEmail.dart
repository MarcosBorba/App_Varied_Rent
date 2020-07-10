import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/components.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailFormConfirmEditEmail extends StatefulWidget {
  final double heightFormConfirmEditEmail;
  final String editEmailHelperText;

  const EditEmailFormConfirmEditEmail(
      {Key key,
      @required this.heightFormConfirmEditEmail,
      @required this.editEmailHelperText})
      : assert(heightFormConfirmEditEmail != null),
        assert(editEmailHelperText != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => EditEmailFormConfirmEditEmailState(
      heightFormConfirmEditEmail, editEmailHelperText);
}

class EditEmailFormConfirmEditEmailState
    extends State<EditEmailFormConfirmEditEmail> {
  double heightFormConfirmEditEmail;
  String editEmailHelperText;
  final _newEmailController = TextEditingController();
  final _newEmailConfirmController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditEmail = new GlobalKey();
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;

  EditEmailFormConfirmEditEmailState(
      this.heightFormConfirmEditEmail, this.editEmailHelperText);

  @override
  Widget build(BuildContext context) {
    heightOfTextFieldsAccordingToContainerSize = EdgeInsets.symmetric(
        vertical: (heightFormConfirmEditEmail * 0.14) * 0.20,
        horizontal: (screenWidth * 0.94) * 0.04);
    return BlocBuilder<EditEmailAndPasswordBloc, EditEmailAndPasswordState>(
      builder: (context, state) {
        return Form(
          key: _keyFormEditEmail,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: heightFormConfirmEditEmail * 0.10,
                width: screenWidth * 0.80,
                child: returnsAnEditEmailHelperText(editEmailHelperText),
              ),
              Container(
                height: heightFormConfirmEditEmail * 0.20,
                child: returnsAnEmailInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              Container(
                height: heightFormConfirmEditEmail * 0.20,
                child: returnsAnConfirmEmailInput(
                    heightOfTextFieldsAccordingToContainerSize),
              ),
              returnsButtonConfirmEditEmail(
                  heightFormConfirmEditEmail * 0.08, screenWidth),
            ],
          ),
        );
      },
    );
  }

  Widget returnsAnEditEmailHelperText(String emailHelperText) {
    return Text(
      emailHelperText,
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
      inputController: _newEmailController,
      labelText: AppTexts().confirmEditNewEmailLabelTextField,
      hintText: AppTexts().confirmEditNewEmailHintTextField,
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().confirmEditNewEmailHelperTextField,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnConfirmEmailInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailTextsFields(
      contentPadding: contentPadding,
      inputController: _newEmailConfirmController,
      labelText: AppTexts().confirmEditConfirmNewEmailLabelTextField,
      hintText: AppTexts().confirmEditNewEmailHintTextField,
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().confirmEditNewEmailHelperTextField,
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsButtonConfirmEditEmail(
      double heightButton, double widthButton) {
    return EditEmailButtons(
      heightButton: heightButton,
      minWidthButton: widthButton,
      textButton: AppTexts().confirmEditEmailTextButton,
      onPressed: () => functionVerifyNewEmailAndNewEmailConfirmed(),
    );
  }

  functionVerifyNewEmailAndNewEmailConfirmed() {
    _newEmailController.text == _newEmailConfirmController.text
        ? functionVerifyAndConfirmEditEmail()
        : functionShowErrorSnackBar();
  }

  functionVerifyAndConfirmEditEmail() {
    _keyFormEditEmail.currentState.validate()
        ? BlocProvider.of<EditEmailAndPasswordBloc>(context).add(
            ConfirmEmailEditButtonPressed(
              newEmail: _newEmailController.text,
              newEmailConfirmed: _newEmailConfirmController.text,
            ),
          )
        : false;
  }

  functionShowErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content:
            Text(AppTexts().confirmEditConfirmNewEmailMessageErrorEmailsEquals),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
