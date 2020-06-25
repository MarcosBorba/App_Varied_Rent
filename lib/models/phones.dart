import 'package:json_annotation/json_annotation.dart';
part 'phones.g.dart';

@JsonSerializable()
class Phones {
  String telephone1;
  String telephone2;

  Phones({this.telephone1,this.telephone2});

 factory Phones.fromJson(Map<String, dynamic> json) => _$PhonesFromJson(json);
  Map<String, dynamic> toJson() => _$PhonesToJson(this);

  
}