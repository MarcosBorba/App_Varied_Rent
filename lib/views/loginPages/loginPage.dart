import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/components/componentsLogin/getFlatButtonToLogInAsAVisitor.dart';
import 'package:varied_rent/components/componentsLogin/getInitialImage.dart';
import 'package:varied_rent/repositories/repositories.dart';

import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/utils/app_colors.dart';
import 'package:varied_rent/utils/app_routes.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/utils/app_texts.dart';
import 'package:varied_rent/views/homePages/myHomePage.dart';
import 'package:varied_rent/views/loginPages/loginForm.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;
  final double imageHeight = screenHeight * 0.24;
  final double imageWidth = screenWidth * 0.50;
  final double containerBorderWidth = (screenWidth * 0.94) * 0.01;
  final double containerLoginFormHeight = screenHeight * 0.65;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(create: (context) {
        return LoginBloc(
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
          userRepository: userRepository,
        );
      }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Container(
          height: screenHeight,
          width: screenWidth,
          color: AppColors.primaryColor,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.01, bottom: screenHeight * 0.01),
                child: getInitialImage(imageHeight, imageWidth),
              ),
              Container(
                decoration: returnsLoginFormBoxDecoration(containerBorderWidth),
                height: containerLoginFormHeight,
                margin: EdgeInsets.only(
                    left: screenWidth * 0.03, right: screenWidth * 0.03),
                child: LoginForm(),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screenHeight * 0.05),
                child:
                    returnsARowWithANavigationButtonToLogInAsAVisitor(context),
              ),
            ],
          ),
        );
      })),
    );
  }
}

Widget returnsARowWithANavigationButtonToLogInAsAVisitor(
    BuildContext contextVisitor) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      getFlatButtonToLogInAsAVisitor(contextVisitor),
    ],
  );
}

Widget getFlatButtonToLogInAsAVisitor(BuildContext contextVisitor) {
  return FlatButtonLinkForScreenNavigation(
    splashColor: AppColors.transparentBackground,
    textButton: AppTexts().textLogInAsAVisitor,
    onPressed: () {
      logInAsAVisitor(contextVisitor);
    },
  );
}

logInAsAVisitor(BuildContext contextVisitor) {
  AppRoutes.makeFirst(contextVisitor, HomePage());
}

Widget getInitialImage(double imageHeight, double imageWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        height: imageHeight,
        width: imageWidth,
        color: AppColors.transparentBackground,
        child: InitialImage(),
      ),
    ],
  );
}

BoxDecoration returnsLoginFormBoxDecoration(double widthBorder) {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.size40)),
      color: Colors.white,
      border: Border.all(
        color: AppColors.secondaryColor,
        width: widthBorder,
      ));
}
