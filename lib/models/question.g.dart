// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    id: json['id'] as String,
    tenant_name: json['tenant_name'] as String,
    tenant_email: json['tenant_email'] as String,
    question_date_time: json['question_date_time'] as String,
    question: json['question'] as String,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'tenant_name': instance.tenant_name,
      'tenant_email': instance.tenant_email,
      'question_date_time': instance.question_date_time,
      'question': instance.question,
    };
