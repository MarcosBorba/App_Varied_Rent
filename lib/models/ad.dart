import 'package:json_annotation/json_annotation.dart';
import 'package:varied_rent/models/imageAd.dart';
part 'ad.g.dart';

@JsonSerializable(nullable: true)
class Ad {
  String id;
  String locator_fk;
  String title;
  List images;
  List starsEvaluations;
  String value;
  String description;
  String category;

  Ad({
    this.id,
    this.locator_fk,
    this.title,
    this.images,
    this.starsEvaluations,
    this.value,
    this.description,
    this.category,
  });

  factory Ad.fromJson(Map json) => _$AdFromJson(json);
  Map<String, dynamic> toJson() => _$AdToJson(this);
}
