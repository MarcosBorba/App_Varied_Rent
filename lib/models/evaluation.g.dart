// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evaluation _$EvaluationFromJson(Map<String, dynamic> json) {
  return Evaluation(
    id: json['id'] as String,
    ad_fk: json['ad_fk'] as String,
    user_fk: json['user_fk'] as String,
    user_name: json['user_name'] as String,
    user_email: json['user_email'] as String,
    amount_stars: json['amount_stars'] as String,
    objective_opition: json['objective_opition'] as String,
    opinion: json['opinion'] as String,
    evaluation_date: json['evaluation_date'] as String,
  );
}

Map<String, dynamic> _$EvaluationToJson(Evaluation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad_fk': instance.ad_fk,
      'user_fk': instance.user_fk,
      'user_name': instance.user_name,
      'user_email': instance.user_email,
      'amount_stars': instance.amount_stars,
      'objective_opition': instance.objective_opition,
      'opinion': instance.opinion,
      'evaluation_date': instance.evaluation_date,
    };
