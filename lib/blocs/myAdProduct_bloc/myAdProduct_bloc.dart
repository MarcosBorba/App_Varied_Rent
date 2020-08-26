import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/ad_repository.dart';
import 'package:varied_rent/repositories/repositories.dart';

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
      //pega o id do anuncio e do locador
      //vai no banco e pega os dados de avaliaçao, questaoresposta e
      //do locador, de acordo com o id do locador ou anuncio
      print("passou started");
      String token = await sharedPref.read('token');
      String idUserLoggedIn = await sharedPref.read('id');
      List ads = await adRepository.getAdRepository(idUserLoggedIn, token);
      yield ShowMyAdProduct(ads: ads);
    } else if (event is MyAdProducPageAddAds) {
      print("passou event add image");
      String token = await sharedPref.read('token');
      await adRepository.addAdRepository(event.image, token);
    }
  }
}
