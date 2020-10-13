import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:varied_rent/views/myAdsPage/myAdsPageForm.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/blocs/blocs.dart';

//TODO: nivel 4 - depois de criar outras telas, adicionar rotas....
class MyAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAdsPageState();
}

class MyAdsPageState extends State<MyAdsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onReturnHomePage,
      child: Scaffold(
        body: BlocProvider<MyAdProductBloc>(
          create: (_) {
            AdRepository adRepository =
                AdRepository(adApiClient: AdApiCLient());
            return MyAdProductBloc(adRepository: adRepository)
              ..add(
                MyAdsPageStarted(),
              );
          },
          child: BlocListener<MyAdProductBloc, MyAdProductState>(
            listener: (context, state) {
              if (state is FailureMyAdProduct) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.error}'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                  ),
                );
              } else if (state is DeleteMyAdProductSuccess) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ads success deleted!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 5),
                  ),
                );
              }
            },
            child: MyAdsPageForm(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.tertiaryColor,
          elevation: 20,
          icon: Icon(
            FontAwesome5.plus,
            color: Colors.white,
          ),
          onPressed: navigationToTheInsertAdScreen,
          label: Text(
            AppTexts().myAdsOptionInsertAds,
            style: TextStyle(
              color: Colors.white,
              fontSize: AppFontSize.s16,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  navigationToTheInsertAdScreen() {
    print("navigation to insert ad screen");
  }

  Future<bool> onReturnHomePage() async {
    AppRoutes.duoPop(context);
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
