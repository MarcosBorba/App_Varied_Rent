import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:varied_rent/models/models.dart';

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
  final String name;
  final String genre;
  final String landlordType;
  final String cpfCnpj;
  final Phones phones;
  final Address address;

  const LoggedIn(
      {@required this.genre,
      @required this.landlordType,
      @required this.cpfCnpj,
      @required this.phones,
      @required this.address,
      @required this.token,
      @required this.name});

  @override
  List<Object> get props =>
      [token, name, genre, landlordType, cpfCnpj, phones, address];

  @override
  String toString() =>
      'LoggedIn { token: $token , name: $name, genre: $genre, landLordType: $landlordType, cpfCnpj: $cpfCnpj , phones: ' +
      phones.toString() +
      ', address: ' +
      address.toString();
}

//LoggedOut para notificar o bloco de que o usuário efetuou logout com êxito.
class LoggedOut extends AuthenticationEvent {}
