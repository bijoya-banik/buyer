// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discountModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountModel _$DiscountModelFromJson(Map<String, dynamic> json) {
  return DiscountModel(
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DiscountModelToJson(DiscountModel instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['discount'],
    json['discountValidity'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'discount': instance.discount,
      'discountValidity': instance.discountValidity,
    };
