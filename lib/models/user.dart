import 'package:json_annotation/json_annotation.dart';
import 'phones.dart';
import 'address.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String name;
  String genre;
  String landlord_type;
  String cpf_cnpj;
  String email;
  Phones phones;
  Address address;
  String password;

  User(
      {this.name,
      this.genre,
      this.landlord_type,
      this.cpf_cnpj,
      this.email,
      this.phones,
      this.address,
      this.password});
  User.login(this.email, this.password);

  factory User.fromJson(Map json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  fromJsonLogin(Map<String, dynamic> json) => _$UserLoginFromJson(json);
  Map<String, dynamic> userLogintoJson() => _$UserLoginToJson(this);

  User _$UserLoginFromJson(Map<String, dynamic> json) {
    return User.login(
      json['email'] as String,
      json['password'] as String,
    );
  }

  Map<String, dynamic> _$UserLoginToJson(User instance) => <String, dynamic>{
        'email': instance.email,
        'password': instance.password,
      };
}
