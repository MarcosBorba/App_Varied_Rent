import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/main.dart';

import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editEmailPage/editEmailFormConfirmEditEmail.dart';
import 'package:varied_rent/views/editEmailPage/editEmailFormConfirmUser.dart';

class EditEmailPage extends StatelessWidget {
  final UserRepository userRepository;
  final int editEmailForm;
  final double containerBorderWidth = (screenWidth * 0.94) * 0.01;
  final double heightFormConfirmUser = screenHeight * 0.92;

  EditEmailPage({Key key, this.userRepository, @required this.editEmailForm})
      : assert(userRepository != null),
        assert(editEmailForm != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (context) {
            return EditEmailBloc(userRepository: userRepository);
          },
          child: BlocListener<EditEmailBloc, EditEmailState>(
            listener: (context, state) {
              if (state is EditEmailFailure) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  ),
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
                  ),
                );
              } else if (state is EditEmailSuccessfullyConcluded) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                final UserRepository userRepository = UserRepository(
                  userApiClient: UserApiClient(),
                );
                AppRoutes.makeFirst(
                    context, App(userRepository: userRepository));
              }
            },
            child: BlocBuilder<EditEmailBloc, EditEmailState>(
              builder: (context, state) {
                return Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: AppColors.editEmailColorPageBackground,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Container(
                        decoration: returnsBoxDecorationForm(),
                        height: heightFormConfirmUser,
                        margin: EdgeInsets.only(
                            left: screenWidth * 0.03,
                            right: screenWidth * 0.03),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.01,
                            right: screenWidth * 0.02,
                          ),
                          child: returnsFormConfirmUserTextsFields(state),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );

  returnsBoxDecorationForm() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(AppSizes.size40)),
      color: AppColors.editEmailColorMainPageBackground,
      border: Border.all(
        color: AppColors.editEmailColorMainPageBorder,
        width: AppSizes.size2,
      ),
    );
  }

  returnsFormConfirmUserTextsFields(EditEmailState state) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: heightFormConfirmUser * 0.10,
        ),
        returnsALineWithAnIconAndATextForTheTitle(),
        SizedBox(
          height: heightFormConfirmUser * 0.10,
        ),
        Divider(
          endIndent: AppSizes.size10,
          indent: AppSizes.size10,
          thickness: AppSizes.size2,
        ),
        SizedBox(
          height: heightFormConfirmUser * 0.10,
        ),
        editEmailForm == 1
            ? EditEmailFormConfirmUser(
                heightFormConfirmUser: heightFormConfirmUser)
            : editEmailForm == 2
                ? EditEmailFormConfirmEditEmail(
                    heightFormConfirmEditEmail: heightFormConfirmUser)
                : false
      ],
    );
  }

  Widget returnsALineWithAnIconAndATextForTheTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Icon(
            Icons.mode_edit,
            size: AppSizes.size40,
            color: AppColors.editEmailColorIconTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            AppTexts().editEmailPageTitle,
            style: TextStyle(
                color: AppColors.editEmailColorTitle,
                fontSize: AppFontSize.s20),
          ),
        ),
      ],
    );
  }
}
