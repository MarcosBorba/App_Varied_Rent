import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'myAdsPage_event.dart';
part 'myAdsPage_state.dart';

class MyAdProductBloc extends Bloc<MyAdsPageEvent, MyAdProductState> {
  AdRepository adRepository;

  MyAdProductBloc({
    @required this.adRepository,
  }) : assert(adRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingMyAdProduct();

  @override
  Stream<MyAdProductState> mapEventToState(MyAdsPageEvent event) async* {
    if (event is MyAdsPageStarted) {
      try {
        String token = await sharedPref.read('token');
        String idUserLoggedIn = await sharedPref.read('id');
        List ads = await adRepository.getAdRepository(
          idUserLoggedIn,
          token,
        );
        yield ShowMyAdProduct(ads: ads);
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FailureMyAdProduct(error: error.message);
        } else {
          yield FailureMyAdProduct(error: "500 - Internal Server Error");
        }
      }
    } else if (event is MyAdsPageDeleteAd) {
      try {
        yield LoadingMyAdProduct();
        String token = await sharedPref.read('token');
        await adRepository.deleteAdRepository(event.id, token);
        event.ads.removeAt(event.index);
        yield ShowMyAdProduct(ads: event.ads);
      } catch (error) {
        print(error);
        if (error is DioError) {
          yield FailureMyAdProduct(error: error.message);
        } else {
          yield FailureMyAdProduct(error: "500 - Internal Server Error");
        }
      }
    }
  }
}
