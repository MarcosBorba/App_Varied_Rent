import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';

import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/SignupPages/signupForm1.dart';
import 'package:varied_rent/views/SignupPages/signupForm2.dart';
import 'package:varied_rent/views/SignupPages/signupForm3Submit.dart';

class SignupPage extends StatelessWidget {
  final UserRepository userRepository;
  final int registrationForm;
  final User user;
  final double containerBorderWidth = (screenWidth * 0.94) * 0.01;
//FIXME: nivel 4 - ao retornar formularios, se perde o user, olhar retornos de navegacao e o bloc para gerenciar os estados ao retornar rotas
  SignupPage(
      {Key key,
      @required this.userRepository,
      @required this.registrationForm,
      this.user})
      : assert(userRepository != null),
        assert(registrationForm != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
          body: BlocProvider(
        create: (context) {
          return SignupBloc(
              userRepository: userRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
        },
        child: Container(
            height: screenHeight,
            width: screenWidth,
            color: AppColors.primaryColor,
            child: ListView(shrinkWrap: true, children: <Widget>[
              SizedBox(
                  height: screenHeight * 0.10,
                  child: returnsARowWithTittleSignup()),
              registrationForm == 1
                  ? Container(
                      height: screenHeight * 0.85,
                      margin: EdgeInsets.only(
                          left: screenWidth * 0.03, right: screenWidth * 0.03),
                      child: SignupForm1(),
                    )
                  : registrationForm == 2
                      ? Container(
                          margin: EdgeInsets.only(
                              left: screenWidth * 0.03,
                              right: screenWidth * 0.03),
                          child: SignupForm2(
                            user: user,
                          ),
                        )
                      : registrationForm == 3
                          ? Container(
                              margin: EdgeInsets.only(
                                  left: screenWidth * 0.03,
                                  right: screenWidth * 0.03),
                              child: SignupForm3Submit(
                                user: user,
                              ),
                            )
                          : Container(
                              height: screenHeight * 0.85,
                              margin: EdgeInsets.only(
                                  left: screenWidth * 0.03,
                                  right: screenWidth * 0.03),
                              child: SignupForm1(),
                            )
            ])),
      ));

  Widget returnsARowWithTittleSignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[returnsATittleTextSignup()],
    );
  }

  Widget returnsATittleTextSignup() {
    return Text(
      "Fill in your new account details",
      style: TextStyle(
          color: AppColors().defaultTitleColor, fontSize: AppFontSize.s20),
    );
  }
}
