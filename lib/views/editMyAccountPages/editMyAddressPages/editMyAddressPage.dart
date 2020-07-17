import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/editAddressData_bloc/editAddressData_bloc.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/editMyAccountPages/editMyAddressPages/editMyAddressForm.dart';

//TODO: nivel 4 - definir cores, texts, rotas
class EditMyAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<EditMyAddressBloc>(
        create: (_) {
          UserRepository userRepository =
              UserRepository(userApiClient: UserApiClient());
          return EditMyAddressBloc(userRepository: userRepository)
            ..add(PageEditMyAddressStarted());
        },
        child: BlocListener<EditMyAddressBloc, EditMyAddressState>(
          listener: (context, state) {
            if (state is FailureAddressDataEditing) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5)),
              );
            }
          },
          child: BlocBuilder<EditMyAddressBloc, EditMyAddressState>(
            builder: (context, state) {
              return Container(
                height: screenHeight,
                width: screenWidth,
                color: AppColors.editMyAddressBackground,
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
                              EditMyAddressPageForm(),
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
      color: AppColors.editMyAddressBackgroundForm,
      border: Border.all(
        width: screenWidth * 0.00500,
        color: AppColors.editMyAddressBorderForm,
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
          color: AppColors.editMyAddressIconTitle,
        ),
        Text(
          AppTexts().editMyAddressTitlePage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.editMyAddressTitle,
            fontSize: AppFontSize.s20,
          ),
        ),
      ],
    );
  }
}
