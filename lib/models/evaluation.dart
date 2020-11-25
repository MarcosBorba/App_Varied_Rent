import 'package:json_annotation/json_annotation.dart';
part 'evaluation.g.dart';

@JsonSerializable(nullable: true)
class Evaluation {
  String id;
  String ad_fk;
  String user_fk;
  String user_name;
  String user_email;
  String amount_stars;
  String objective_opition;
  String opinion;
  String evaluation_date;

  Evaluation({
    this.id,
    this.ad_fk,
    this.user_fk,
    this.user_name,
    this.user_email,
    this.amount_stars,
    this.objective_opition,
    this.opinion,
    this.evaluation_date,
  });

  factory Evaluation.fromJson(Map json) => _$EvaluationFromJson(json);
  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}
