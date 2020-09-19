import 'package:json_annotation/json_annotation.dart';
part 'imageAd.g.dart';

@JsonSerializable(nullable: true)
class ImageAd {
  String id;
  String url;
  String key;

  ImageAd({
    this.id,
    this.url,
    this.key,
  });

  factory ImageAd.fromJson(Map json) => _$ImageAdFromJson(json);
  Map<String, dynamic> toJson() => _$ImageAdToJson(this);
}
