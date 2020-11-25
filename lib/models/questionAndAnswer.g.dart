// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionAndAnswer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionAndAnswer _$QuestionAndAnswerFromJson(Map<String, dynamic> json) {
  return QuestionAndAnswer(
    id: json['id'] as String,
    ad_fk: json['ad_fk'] as String,
    tenant_fk: json['tenant_fk'] as String,
    question: json['question'] == null
        ? null
        : Question.fromJson(json['question'] as Map<String, dynamic>),
    answer: json['answer'] == null
        ? null
        : Answer.fromJson(json['answer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$QuestionAndAnswerToJson(QuestionAndAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad_fk': instance.ad_fk,
      'tenant_fk': instance.tenant_fk,
      'question': instance.question,
      'answer': instance.answer,
    };
