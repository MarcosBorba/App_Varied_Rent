import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/insertAdsPages/insertAdsForm.dart';

class InsertAdsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InsertAdsPageState();
}

class InsertAdsPageState extends State<InsertAdsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors.insertAdStatusBar,
        ),
        child: BlocProvider<InsertAdsBloc>(
            create: (_) {
              AdRepository adRepository =
                  AdRepository(adApiClient: AdApiCLient());
              return InsertAdsBloc(adRepository: adRepository);
            },
            child: InsertAdsForm()),
      ),
    );
  }
}
