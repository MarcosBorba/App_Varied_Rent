import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/components/componentsEditEmailPage/componentsEditEmail.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editEmailPage/editEmailPage.dart';

class EditEmailFormConfirmUser extends StatefulWidget {
  final double heightFormConfirmUser;

  const EditEmailFormConfirmUser({Key key, this.heightFormConfirmUser})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditEmailFormConfirmUserState(heightFormConfirmUser);
}

//TODO: nivel 4 - definir colors, texts e routes
//FIXME: vivel 2 - textField quando seleciona, perde o foco
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
    return BlocListener<EditEmailBloc, EditEmailState>(
      listener: (context, state) {
        if (state is EditEmailFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 5)),
          );
        } else if (state is EditEmailConfirmedUser) {
          final UserRepository userRepository = UserRepository(
            userApiClient: UserApiClient(),
          );
          AppRoutes.push(
              context,
              EditEmailPage(
                userRepository: userRepository,
                editEmailForm: 2,
              ));
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
      }),
    );
  }

  Widget returnsAnHelperText() {
    return Text(
      "Confirm your email and password to update your email",
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
      hintText: AppTexts().hintTextFromEmailTextField,
      prefixIcon: Icons.alternate_email,
      helperText: AppTexts().emailTextFieldHelpText,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: FieldValidators().emailFormFieldValidator,
    );
  }

  Widget returnsAnPasswordInput(EdgeInsetsGeometry contentPadding) {
    return EditEmailTextsFields(
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
      textButton: "Confirmed user",
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
