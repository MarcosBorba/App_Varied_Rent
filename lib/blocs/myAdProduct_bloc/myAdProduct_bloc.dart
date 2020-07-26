import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'myAdProduct_event.dart';
part 'myAdProduct_state.dart';

class MyAdProductBloc extends Bloc<MyAdProductEvent, MyAdProductState> {
  UserRepository userRepository;

  MyAdProductBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  SharedPref sharedPref = SharedPref();

  @override
  get initialState => LoadingMyAdProduct();

  @override
  Stream<MyAdProductState> mapEventToState(MyAdProductEvent event) {
    if (event is MyAdProducPageStarted) {
      //pega o id do anuncio e do locador
      //vai no banco e pega os dados de avaliaçao, questaoresposta e
      //do locador, de acordo com o id do locador ou anuncio

    }
  }
}
