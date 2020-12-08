import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:varied_rent/utils/utils.dart';
import 'package:varied_rent/views/myFavoritesAdsPages/myFavoritesAdsForm.dart';

class MyFavoritesAdsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> backHomePage() async {
      AppRoutes.duoPop(context);
      return true;
    }

    return WillPopScope(
      onWillPop: backHomePage,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: AppColors.favoriteAdsStatusBar,
          ),
          child: BlocProvider<FavoriteAdsBloc>(
            create: (_) {
              FavoriteAdRepository favoriteAdRepository = FavoriteAdRepository(
                favoriteAdApiClient: FavoriteAdApiCLient(),
              );
              return FavoriteAdsBloc(favoriteAdRepository: favoriteAdRepository)
                ..add(
                  FavoriteAdsPageStarted(),
                );
            },
            child: BlocListener<FavoriteAdsBloc, FavoriteAdsState>(
              listener: (context, state) {
                if (state is FavoriteAdsFailure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.error}'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 5),
                    ),
                  );
                } else if (state is DeleteMyFavoriteAdSuccess) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Favorite Ad success deleted!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 5),
                    ),
                  );
                }
              },
              child: MyFavoritesAdsForm(),
            ),
          ),
        ),
      ),
    );
  }
}
