// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['country'] as String,
    json['state'] as String,
    json['city'] as String,
    json['zip_code'] as String,
    json['neighborhood'] as String,
    json['street'] as String,
    json['number'] as String,
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
