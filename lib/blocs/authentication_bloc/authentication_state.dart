import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//não inicializado - aguardando para ver se o usuário está autenticado ou não no início do aplicativo.
class AuthenticationUninitialized extends AuthenticationState {}

//autenticado - autenticado com sucesso
class AuthenticationAuthenticated extends AuthenticationState {}

//não autenticado - não autenticado
class AuthenticationUnauthenticated extends AuthenticationState {}

//loading - aguardando para persistir / excluir um token
class AuthenticationLoading extends AuthenticationState {}
