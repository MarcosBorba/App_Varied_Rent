import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/repositories.dart';
part 'editAccountData_event.dart';
part 'editAccountData_state.dart';

class EditEmailAndPasswordBloc
    extends Bloc<EditEmailAndPasswordEvents, EditEmailAndPasswordState> {
  final UserRepository userRepository;

  EditEmailAndPasswordBloc({@required this.userRepository})
      : assert(userRepository != null);

  SharedPref sharedPref = SharedPref();

  @override
  get initialState => EditInitialData();

  @override
  Stream<EditEmailAndPasswordState> mapEventToState(
      EditEmailAndPasswordEvents event) async* {
    if (event is EmailButtonConfirmUserPressed) {
      yield LoadingDataEditing();
      try {
        String token = await sharedPref.read('token');
        await checkConfirmEmailIsEqualEmailLoggin(event.user.email);
        await userRepository.userCheckUserRepository(event.user, token);
        yield EditEmailConfirmedUser();
      } catch (error) {
        if (error is DioError) {
          yield FailureDataEditing(error: error.message);
        } else {
          yield FailureDataEditing(error: "500 - Internal Server Error");
        }
      }
    } else if (event is PasswordButtonConfirmUserPressed) {
      yield LoadingDataEditing();
      try {
        String token = await sharedPref.read('token');
        await checkConfirmEmailIsEqualEmailLoggin(event.user.email);
        await userRepository.userCheckUserRepository(event.user, token);
        yield EditPasswordConfirmedUser();
      } catch (error) {
        if (error is DioError) {
          yield FailureDataEditing(error: error.message);
        } else {
          yield FailureDataEditing(error: "500 - Internal Server Error");
        }
      }
    } else if (event is ConfirmEmailEditButtonPressed) {
      yield LoadingDataEditing();
      try {
        String token = await sharedPref.read('token');
        String oldEmail = await sharedPref.read('email');
        await userRepository.userUpdateEmailRepository(
            oldEmail, event.newEmail, event.newEmailConfirmed, token);
        yield DataSuccessfullyEdited();
      } catch (error) {
        if (error is DioError) {
          yield FailureDataEditing(error: error.message);
        } else {
          yield FailureDataEditing(error: "500 - Internal Server Error");
        }
      }
    } else if (event is ConfirmPasswordEditButtonPressed) {
      yield LoadingDataEditing();
      try {
        String token = await sharedPref.read('token');
        String userEmail = await sharedPref.read('email');
        await userRepository.userUpdatePasswordRepository(
            userEmail, event.newPassword, event.newPasswordConfirmed, token);
        yield DataSuccessfullyEdited();
      } catch (error) {
        if (error is DioError) {
          yield FailureDataEditing(error: error.message);
        } else {
          yield FailureDataEditing(error: "500 - Internal Server Error");
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
