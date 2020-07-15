import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editMyAccountPages/editMyProfilePages/editMyProfileForm.dart';

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
                        height: 1500,
                        decoration: boxDecoration(),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.02,
                              right: screenWidth * 0.02,
                              bottom: screenWidth * 0.04),
                          child: EditMyProfilePageForm(),
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
}
