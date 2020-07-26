// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ad _$AdFromJson(Map<String, dynamic> json) {
  return Ad(
    id: json['id'] as String,
    locator_fk: json['locator_fk'] as String,
    title: json['title'] as String,
    images: json['images'] as List,
    value: json['value'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
  );
}

Map<String, dynamic> _$AdToJson(Ad instance) => <String, dynamic>{
      'id': instance.id,
      'locator_fk': instance.locator_fk,
      'title': instance.title,
      'images': instance.images,
      'value': instance.value,
      'description': instance.description,
      'category': instance.category,
    };
