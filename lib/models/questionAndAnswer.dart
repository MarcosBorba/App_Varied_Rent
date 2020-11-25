import 'package:json_annotation/json_annotation.dart';
import 'package:varied_rent/models/answer.dart';
import 'package:varied_rent/models/question.dart';
part 'questionAndAnswer.g.dart';

@JsonSerializable(nullable: true)
class QuestionAndAnswer {
  String id;
  String ad_fk;
  String tenant_fk;
  Question question;
  Answer answer;

  QuestionAndAnswer({
    this.id,
    this.ad_fk,
    this.tenant_fk,
    this.question,
    this.answer,
  });

  factory QuestionAndAnswer.fromJson(Map json) =>
      _$QuestionAndAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionAndAnswerToJson(this);
}
