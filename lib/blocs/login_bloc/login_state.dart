part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

//LoginInitial é o estado inicial do LoginForm.
class LoginInitial extends LoginState {}

//LoginLoading é o estado do LoginForm quando validamos credenciais
class LoginLoading extends LoginState {}

//LoginFailure é o estado do LoginForm quando uma tentativa de login falha.
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}
