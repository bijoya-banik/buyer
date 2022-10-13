import 'package:json_annotation/json_annotation.dart';
part 'discountModel.g.dart';

@JsonSerializable()
class DiscountModel {
  User user;

  DiscountModel(this.user);

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}

@JsonSerializable()
class User {
  dynamic discount;
  dynamic discountValidity;

  User(this.discount, this.discountValidity);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
