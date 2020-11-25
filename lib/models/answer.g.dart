// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    id: json['id'] as String,
    locator_name: json['locator_name'] as String,
    locator_email: json['locator_email'] as String,
    answer_date_time: json['answer_date_time'] as String,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'locator_name': instance.locator_name,
      'locator_email': instance.locator_email,
      'answer_date_time': instance.answer_date_time,
      'answer': instance.answer,
    };
