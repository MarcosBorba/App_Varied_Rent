import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:varied_rent/blocs/authentication_bloc/authentication.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'dart:async';
import 'package:dio/dio.dart';

import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  SignupBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  get initialState => SignupInitial();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupButtonSubmitPressed) {
      yield SignupLoading();

      try {
        await userRepository.userSignupRepository(event.user);

        final token = await userRepository.userLoginRepository(
            event.user.email, event.user.password);

        yield SignupSuccessfullyConcluded(token: token);
      } catch (error) {
        if (error is DioError) {
          yield SignupFailure(error: error.message);
        } else {
          yield SignupFailure(error: "500 - Internal Server Error");
        }
      }
    } else if (event is SignupButtonContinuePressed) {
      //TODO: nivel 3 - tratamento de erros nao parece efetivo
      //TODO: nivel 4 - otimizar signupTransitionFormScreen, para quando o usuario navegar pelos tres formularios, de forma que troque os estados tambem
      yield SignupLoading();
      try {
        yield SignupTransitionFormScreen(user: event.user);
      } catch (error) {
        yield SignupFailure(error: error.toString());
      }
    }
  }
}
