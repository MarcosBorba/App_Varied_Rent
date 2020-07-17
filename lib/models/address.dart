import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  String country;
  String state;
  String city;
  String zip_code;
  String neighborhood;
  String street;
  String number;

  Address(
      {this.country,
      this.state,
      this.city,
      this.zip_code,
      this.neighborhood,
      this.street,
      this.number});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
