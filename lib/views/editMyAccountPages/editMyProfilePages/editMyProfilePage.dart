import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editMyAccountPages/editMyProfilePages/editMyProfileForm.dart';

//TODO: nivel 4 - colors, routes e otimzar blocs
class EditMyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditMyProfileBloc>(
        create: (_) {
          UserRepository userRepository =
              UserRepository(userApiClient: UserApiClient());
          return EditMyProfileBloc(userRepository: userRepository)
            ..add(PageEditMyProfileStarted());
        },
        child: BlocListener<EditMyProfileBloc, EditMyProfileState>(
          listener: (context, state) {
            if (state is FailureProfileDataEditing) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5)),
              );
            }
          },
          child: BlocBuilder<EditMyProfileBloc, EditMyProfileState>(
            builder: (context, state) {
              return Container(
                height: screenHeight,
                width: screenWidth,
                color: AppColors.tertiaryColor,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.02,
                        left: screenWidth * 0.03,
                        right: screenWidth * 0.03,
                        bottom: screenHeight * 0.02,
                      ),
                      child: Container(
                        decoration: boxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.02,
                              right: screenWidth * 0.02,
                              bottom: screenWidth * 0.04),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              returnsHeaderForm(),
                              EditMyProfilePageForm()
                            ],
                          ),
                        ),
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
  }

  boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: screenWidth * 0.00500,
        color: AppColors.primaryColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.size40),
      ),
    );
  }

  Widget returnsHeaderForm() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: screenHeight * 0.10,
        ),
        returnsALineWithAnIconAndATextForTheTitle(),
        SizedBox(
          height: screenHeight * 0.10,
        ),
        Divider(
          endIndent: AppSizes.size10,
          indent: AppSizes.size10,
          thickness: AppSizes.size2,
        ),
        SizedBox(
          height: screenHeight * 0.08,
        ),
      ],
    );
  }

  Widget returnsALineWithAnIconAndATextForTheTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.mode_edit,
          size: AppSizes.size40,
          color: AppColors.editEmailOrPasswordColorIconTitle,
        ),
        Text(
          AppTexts().editMyProfileTitlePage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.editEmailOrPasswordColorTitle,
            fontSize: AppFontSize.s20,
          ),
        ),
      ],
    );
  }
}
