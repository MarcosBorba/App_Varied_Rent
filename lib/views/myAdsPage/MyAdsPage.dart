import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/ad_api_client.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';

class MyAdsPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MyAdProductBloc>(
        create: (_) {
          AdRepository adRepository = AdRepository(adApiClient: AdApiCLient());
          return MyAdProductBloc(adRepository: adRepository)
            ..add(MyAdProducPageStarted());
        },
        child: BlocBuilder<MyAdProductBloc, MyAdProductState>(
          builder: (context, state) {
            return Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
