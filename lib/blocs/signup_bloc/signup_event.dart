part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class SignupButtonSubmitPressed extends SignupEvent {
  final User user;

  const SignupButtonSubmitPressed({
    @required this.user,
  });

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SignupButtonPressed { user: $user}';
}

class SignupButtonContinuePressed extends SignupEvent {
  final User user;

  const SignupButtonContinuePressed({
    @required this.user,
  });

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'SignupButtonContinuePressed { user: $user}';
}
