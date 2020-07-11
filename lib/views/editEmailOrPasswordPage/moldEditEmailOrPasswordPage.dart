import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/main.dart';

import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editEmailOrPasswordPage/editEmailFormConfirmEditEmail.dart';
import 'package:varied_rent/views/editEmailOrPasswordPage/editFormConfirmUser.dart';
import 'package:varied_rent/views/editEmailOrPasswordPage/editPasswordFormConfirmEditPassword.dart';

class MoldEditEmailOrPassword extends StatelessWidget {
  final UserRepository userRepository;
  final String editEmailForm;
  final String titlePage;
  final String dataThatWillEdit;
  final double containerBorderWidth = (screenWidth * 0.94) * 0.01;
  final double heightFormConfirmUser = screenHeight * 0.92;

  MoldEditEmailOrPassword({
    Key key,
    @required this.userRepository,
    @required this.editEmailForm,
    @required this.titlePage,
    this.dataThatWillEdit,
  })  : assert(userRepository != null),
        assert(editEmailForm != null),
        assert(titlePage != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (context) {
            return EditEmailAndPasswordBloc(userRepository: userRepository);
          },
          child:
              BlocListener<EditEmailAndPasswordBloc, EditEmailAndPasswordState>(
            listener: (context, state) {
              if (state is FailureDataEditing) {
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
                  MoldEditEmailOrPassword(
                    userRepository: userRepository,
                    editEmailForm: "ConfirmEditEmail",
                    titlePage: titlePage,
                  ),
                );
              } else if (state is EditPasswordConfirmedUser) {
                final UserRepository userRepository = UserRepository(
                  userApiClient: UserApiClient(),
                );
                AppRoutes.push(
                  context,
                  MoldEditEmailOrPassword(
                    userRepository: userRepository,
                    editEmailForm: "ConfirmEditPassword",
                    titlePage: titlePage,
                  ),
                );
              } else if (state is DataSuccessfullyEdited) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                final UserRepository userRepository = UserRepository(
                  userApiClient: UserApiClient(),
                );
                AppRoutes.makeFirst(
                    context, App(userRepository: userRepository));
              }
            },
            child: BlocBuilder<EditEmailAndPasswordBloc,
                EditEmailAndPasswordState>(
              builder: (context, state) {
                return Container(
                  height: screenHeight,
                  width: screenWidth,
                  color: AppColors.editEmailOrPasswordPageColorBackground,
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
      color: AppColors.editEmailOrPasswordPageColorMainBackground,
      border: Border.all(
        color: AppColors.editEmailOrPasswordPageColorMainBorder,
        width: AppSizes.size2,
      ),
    );
  }

  returnsFormConfirmUserTextsFields(EditEmailAndPasswordState state) {
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
        editEmailForm == "ConfirmUser"
            ? EditEmailFormConfirmUser(
                heightFormConfirmUser: heightFormConfirmUser,
                titlePasswordHelperText: AppTexts().confirmUserHelperText,
                dataThatWillEdit: dataThatWillEdit,
                state: state,
              )
            : editEmailForm == "ConfirmEditEmail"
                ? EditEmailFormConfirmEditEmail(
                    heightFormConfirmEditEmail: heightFormConfirmUser,
                    editEmailHelperText: AppTexts().confirmEditEmailHelperText,
                  )
                : editEmailForm == "ConfirmEditPassword"
                    ? EditPasswordFormConfirmEditPassword(
                        heightFormConfirmEditPassword: heightFormConfirmUser,
                        editPasswordHelperText:
                            AppTexts().confirmEditPasswordHelperText,
                      )
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
            color: AppColors.editEmailOrPasswordColorIconTitle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            titlePage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.editEmailOrPasswordColorTitle,
              fontSize: AppFontSize.s20,
            ),
          ),
        ),
      ],
    );
  }
}
