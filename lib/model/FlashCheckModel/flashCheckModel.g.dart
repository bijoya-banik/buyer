// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashCheckModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCheckModel _$FlashCheckModelFromJson(Map<String, dynamic> json) {
  return FlashCheckModel(
    (json['status'] as List)
        ?.map((e) =>
            e == null ? null : Status.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FlashCheckModelToJson(FlashCheckModel instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    json['id'],
    json['name'],
    json['startTime'],
    json['endTime'],
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['flashsaleId'],
    json['discount'],
    json['quantity'],
    json['totalSale'],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'flashsaleId': instance.flashsaleId,
      'discount': instance.discount,
      'quantity': instance.quantity,
      'totalSale': instance.totalSale,
    };
