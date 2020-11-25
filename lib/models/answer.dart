import 'package:json_annotation/json_annotation.dart';
part 'answer.g.dart';

@JsonSerializable(nullable: true)
class Answer {
  String id;
  String locator_name;
  String locator_email;
  String answer_date_time;
  String answer;

  Answer({
    this.id,
    this.locator_name,
    this.locator_email,
    this.answer_date_time,
    this.answer,
  });

  factory Answer.fromJson(Map json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
