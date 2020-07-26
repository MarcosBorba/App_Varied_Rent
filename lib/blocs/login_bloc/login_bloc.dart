import 'dart:async';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final User userLogin = await userRepository.userLoginRepository(
            event.email, event.password);
        authenticationBloc.add(LoggedIn(
            id: userLogin.id,
            token: userLogin.token,
            name: userLogin.name,
            genre: userLogin.genre,
            landlordType: userLogin.landlord_type,
            cpfCnpj: userLogin.cpf_cnpj,
            email: userLogin.email,
            phones: Phones(
              telephone1: userLogin.phones.telephone1,
              telephone2: userLogin.phones.telephone2,
            ),
            address: Address(
              country: userLogin.address.country,
              state: userLogin.address.state,
              city: userLogin.address.city,
              zip_code: userLogin.address.zip_code,
              neighborhood: userLogin.address.neighborhood,
              street: userLogin.address.street,
              number: userLogin.address.number,
            )));
        yield LoginInitial();
      } catch (error) {
        if (error is DioError) {
          yield LoginFailure(error: error.message);
        } else {
          yield LoginFailure(error: "500 - Internal Server Error");
        }
      }
    }
  }
}
