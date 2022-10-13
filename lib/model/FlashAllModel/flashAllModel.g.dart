// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashAllModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashAllModel _$FlashAllModelFromJson(Map<String, dynamic> json) {
  return FlashAllModel(
    (json['product'] as List)
        ?.map((e) =>
            e == null ? null : Products.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FlashAllModelToJson(FlashAllModel instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    json['id'],
    json['flashsaleId'],
    json['productId'],
    json['discount'],
    json['quantity'],
    json['totalsale'],
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'flashsaleId': instance.flashsaleId,
      'productId': instance.productId,
      'discount': instance.discount,
      'quantity': instance.quantity,
      'totalsale': instance.totalsale,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['name'],
    json['image'],
    json['photo'],
    json['price'],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'photo': instance.photo,
      'price': instance.price,
    };
