import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/repositories/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'myAdProduct_event.dart';
part 'myAdProduct_state.dart';

class MyAdProductBloc extends Bloc<MyAdProductEvent, MyAdProductState> {
  AdRepository adRepository;

  MyAdProductBloc({
    @required this.adRepository,
  }) : assert(adRepository != null);

  SharedPref sharedPref = SharedPref();
  @override
  get initialState => LoadingMyAdProduct();

  @override
  Stream<MyAdProductState> mapEventToState(MyAdProductEvent event) async* {
    if (event is MyAdProducPageStarted) {
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
    } else if (event is MyAdProducPageAddAds) {
      print("passou event add image");
      String token = await sharedPref.read('token');
      await adRepository.addAdRepository(event.image, token);
    }
  }
}
