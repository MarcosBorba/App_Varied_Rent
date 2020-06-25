// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
    genre: json['genre'] as String,
    landlord_type: json['landlord_type'] as String,
    cpf_cnpj: json['cpf_cnpj'] as String,
    email: json['email'] as String,
    phones: json['phones'] == null
        ? null
        : Phones.fromJson(json['phones'] as Map<String, dynamic>),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'genre': instance.genre,
      'landlord_type': instance.landlord_type,
      'cpf_cnpj': instance.cpf_cnpj,
      'email': instance.email,
      'phones': instance.phones?.toJson(),
      'address': instance.address?.toJson(),
      'password': instance.password,
    };
