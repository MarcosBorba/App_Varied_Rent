import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';

@JsonSerializable(nullable: true)
class Question {
  String id;
  String tenant_name;
  String tenant_email;
  String question_date_time;
  String question;

  Question({
    this.id,
    this.tenant_name,
    this.tenant_email,
    this.question_date_time,
    this.question,
  });

  factory Question.fromJson(Map json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
