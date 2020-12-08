import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'favoriteAds_event.dart';
part 'favoriteAds_state.dart';

class FavoriteAdsBloc extends Bloc<FavoriteAdsEvent, FavoriteAdsState> {
  FavoriteAdRepository favoriteAdRepository;

  FavoriteAdsBloc({
    @required this.favoriteAdRepository,
  }) : assert(favoriteAdRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => FavoriteAdsLoading();

  @override
  Stream<FavoriteAdsState> mapEventToState(FavoriteAdsEvent event) async* {
    if (event is FavoriteAdsPageStarted) {
      yield FavoriteAdsLoading();
      try {
        String token = await sharedPref.read('token');
        String idUserLoggedIn = await sharedPref.read('id');
        List ads = await favoriteAdRepository.getFavoriteAdRepository(
          idUserLoggedIn,
          token,
        );
        await Future.delayed(Duration(seconds: 1));
        yield ShowFavoriteAdsPage(ads: ads);
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FavoriteAdsFailure(error: error.message);
        } else {
          yield FavoriteAdsFailure(error: "500 - Internal Server Error");
        }
      }
    } else if (event is FavoriteAdDeleteAd) {
      try {
        yield FavoriteAdsLoading();
        String token = await sharedPref.read('token');
        String locatorFk = await sharedPref.read('id');
        await favoriteAdRepository.deleteFavoriteAdRepository(
            event.idAd, locatorFk, token);
        event.ads.removeAt(event.index);

        yield ShowFavoriteAdsPage(ads: event.ads);
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FavoriteAdsFailure(error: error.message);
        } else {
          yield FavoriteAdsFailure(error: "500 - Internal Server Error");
        }
      }
    }
  }
}
