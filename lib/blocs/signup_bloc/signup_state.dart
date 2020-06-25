part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

//SignupInitial é o estado inicial do SignupForm.
class SignupInitial extends SignupState {}

class SignupSuccessfullyConcluded extends SignupState {
  final String token;

  const SignupSuccessfullyConcluded({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'SignupSuccessfullyConcluded { token: $token }';
}

class SignupTransitionFormScreen extends SignupState {
  final User user;

  const SignupTransitionFormScreen({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() =>
      'SignupTransitionFormScreen { user: $user }';
}

//SignupLoading é o estado do SignupForm quando validamos credenciais
class SignupLoading extends SignupState {}

//SignupFailure é o estado do SignupForm quando uma tentativa de signup falha.
class SignupFailure extends SignupState {
  final String error;

  const SignupFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignupFailure { error: $error }';
}
