import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//AppStarted para notificar o bloco de que ele precisa verificar
//se o usuário está atualmente autenticado ou não.
class AppStarted extends AuthenticationEvent {}

//LoggedIn para notificar o bloco de que o usuário efetuou login com êxito.
class LoggedIn extends AuthenticationEvent {
  final String token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn { token: $token }';
}

//LoggedOut para notificar o bloco de que o usuário efetuou logout com êxito.
class LoggedOut extends AuthenticationEvent {}
