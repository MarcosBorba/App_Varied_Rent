import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/blocs/myAdsProduct_bloc/myAdProductBloc.dart';
import 'package:varied_rent/models/models.dart';
part 'myAdProduct_event.dart';
part 'myAdProduct_state.dart';

class MyAdProductPageBloc
    extends Bloc<MyAdProductPageEvent, MyAdProductPageState> {
  MyAdProductPageBloc();

  @override
  get initialState => LoadingMyAdProductPage();

  @override
  Stream<MyAdProductPageState> mapEventToState(
      MyAdProductPageEvent event) async* {
    if (event is MyAdProductPageGetQuestionsAndEvaluations) {
      event.idAd
      ///criar parte de repositorio e backend e depois ligar com o front
    }
  }
}
