import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:varied_rent/blocs/blocs.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'editEmail_event.dart';
part 'editEmail_state.dart';

class EditEmailBloc extends Bloc<EditEmailEvent, EditEmailState> {
  final UserRepository userRepository;

  EditEmailBloc({@required this.userRepository})
      : assert(userRepository != null);

  SharedPref sharedPref = SharedPref();

  @override
  get initialState => EditEmailInitial();

  @override
  Stream<EditEmailState> mapEventToState(EditEmailEvent event) async* {
    if (event is EditEmailButtonConfirmUserPressed) {
      yield EditEmailLoading();
      try {
        String token = await sharedPref.read('token');
        await checkConfirmEmailIsEqualEmailLoggin(event.user.email);
        await userRepository.userCheckUserRepository(event.user, token);
        yield EditEmailConfirmedUser();
      } catch (error) {
        if (error is DioError) {
          yield EditEmailFailure(error: error.message);
        } else {
          yield EditEmailFailure(error: "500 - Internal Server Error");
        }
      }
    } else if (event is EditEmailButtonConfirmEditEmailPressed) {
      yield EditEmailLoading();
      try {
        String token = await sharedPref.read('token');
        String oldEmail = await sharedPref.read('email');
        await userRepository.userUpdateEmailRepository(
            oldEmail, event.newEmail, event.newEmailConfirmed, token);
        yield EditEmailSuccessfullyConcluded();
      } catch (error) {
        if (error is DioError) {
          yield EditEmailFailure(error: error.message);
        } else {
          yield EditEmailFailure(error: "500 - Internal Server Error");
        }
      }
    }
  }

  Future checkConfirmEmailIsEqualEmailLoggin(String confirmEmail) async {
    String emailLoggin = await sharedPref.read('email');
    emailLoggin == confirmEmail
        ? true
        : throw new DioError(
            error:
                "401 - The email provided is different from the logged in user.");
  }
}
