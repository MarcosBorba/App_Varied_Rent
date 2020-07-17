// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    country: json['country'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    zip_code: json['zip_code'] as String,
    neighborhood: json['neighborhood'] as String,
    street: json['street'] as String,
    number: json['number'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'zip_code': instance.zip_code,
      'neighborhood': instance.neighborhood,
      'street': instance.street,
      'number': instance.number,
    };
