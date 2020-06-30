import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:varied_rent/repositories/repositories.dart';

import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  //Substituindo State inicial pelo estado Authentication Uninitialized() > não inicializado.
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  SharedPref sharedPref = SharedPref();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    //se o evento for App Iniciado, verfica se tem token e retorna um estado de acordo com a resposta.
    if (event is AppStarted) {
      final bool hasToken = await sharedPref.checkKey('token');
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else
    //se o evento for logado como usuario, retorna um estado usuario autenticado.
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await sharedPref.save('token', event.token);
      await sharedPref.save('name', event.name);
      await sharedPref.save('genre', event.genre);
      await sharedPref.save('landlordType', event.landlordType);
      await sharedPref.save('cpfCnpj', event.cpfCnpj);
      await sharedPref.save('phones', event.phones);
      await sharedPref.save('address', event.address);
      yield AuthenticationAuthenticated();
    } else if (event is LoggedOut) {
      yield AuthenticationLoading();
      await sharedPref.remove('token');
      await sharedPref.remove('name');
      await sharedPref.remove('genre');
      await sharedPref.remove('landlordType');
      await sharedPref.remove('cpfCnpj');
      await sharedPref.remove('phones');
      await sharedPref.remove('address');
      yield AuthenticationUnauthenticated();
    }
  }
}
