import 'package:json_annotation/json_annotation.dart';
part 'ad.g.dart';

@JsonSerializable()
class Ad {
  String id;
  String locator_fk;
  String title;
  List images;
  String value;
  String description;
  String category;

  Ad({
    this.id,
    this.locator_fk,
    this.title,
    this.images,
    this.value,
    this.description,
    this.category,
  });

  factory Ad.fromJson(Map json) => _$AdFromJson(json);
  Map<String, dynamic> toJson() => _$AdToJson(this);
}
