import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/componentsEditEmailPage/componentsEditEmail.dart';
import 'package:varied_rent/main.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

class EditEmailFormConfirmEditEmail extends StatefulWidget {
  final double heightFormConfirmEditEmail;

  const EditEmailFormConfirmEditEmail(
      {Key key, this.heightFormConfirmEditEmail})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditEmailFormConfirmEditEmailState(heightFormConfirmEditEmail);
}

//TODO: nivel 4 - definir colors, texts e routes, validators email = email confirmed
//FIXME: vivel 2 - textField quando seleciona, perde o foco
class EditEmailFormConfirmEditEmailState
    extends State<EditEmailFormConfirmEditEmail> {
  double heightFormConfirmEditEmail;
  final _emailController = TextEditingController();
  final _emailConfirmController = TextEditingController();
  final GlobalKey<FormState> _keyFormEditEmail = new GlobalKey();
  EdgeInsetsGeometry heightOfTextFieldsAccordingToContainerSize;

  EditEmailFormConfirmEditEmailState(this.heightFormConfirmEditEmail);

  @override
  Widget build(BuildContext context) {
    heightOfTextFieldsAccordingToContainerSize = EdgeInsets.symmetric(
        vertical: (heightFormConfirmEditEmail * 0.14) * 0.20,
        horizontal: (screenWidth * 0.94) * 0.04);
    return BlocListener<EditEmailBloc, EditEmailState>(
      listener: (context, state) {
        if (state is EditEmailFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5)),
          );
        } else if (state is EditEmailSuccessfullyConcluded) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          final UserRepository userRepository = UserRepository(
            userApiClient: UserApiClient(),
          );
          AppRoutes.makeFirst(context, App(userRepository: userRepository));
        }
      },
      child:
          BlocBuilder<EditEmailBloc, EditEmailState>(builder: (context, state) {
        return Form(
          key: _keyFormEditEmail,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: heightFormConfirmEditEmail * 0.10,
                width: screenWidth * 0.80,
                child: returnsAnEditEmailHelperText(),
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
      }),
    );
  }

  Widget returnsAnEditEmailHelperText() {
    return Text(
      "Enter your new email and confirm",
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(
        color: Colors.black87,
        fontSize: AppFontSize.s15,
      ),
    );
  }

  Widget returnsAnEmailInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailTextsFields(
      contentPadding: contentPadding,
      inputController: _emailController,
      labelText: AppTexts().emailTextFieldLabelText,
      hintText: "Type your new Email",
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().emailTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnConfirmEmailInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailTextsFields(
      contentPadding: contentPadding,
      inputController: _emailConfirmController,
      labelText: "Confirm email",
      hintText: "Type your new Email",
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().emailTextFieldHelpText,
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsButtonConfirmEditEmail(
      double heightButton, double widthButton) {
    return EditEmailButtons(
      heightButton: heightButton,
      minWidthButton: widthButton,
      textButton: "Confirmed New Email",
      onPressed: () => functionVerifyAndConfirmEditEmail(),
    );
  }

  functionVerifyAndConfirmEditEmail() {
    _keyFormEditEmail.currentState.validate()
        ? BlocProvider.of<EditEmailBloc>(context)
            .add(EditEmailButtonConfirmEditEmailPressed(
            newEmail: _emailController.text,
            newEmailConfirmed: _emailConfirmController.text,
          ))
        : false;
  }
}
