// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sellModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellModel _$SellModelFromJson(Map<String, dynamic> json) {
  return SellModel(
    json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SellModelToJson(SellModel instance) => <String, dynamic>{
      'status': instance.status,
    };

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    json['id'],
    json['name'],
    json['startTime'],
    json['endTime'],
    (json['products'] as List)
        ?.map((e) =>
            e == null ? null : Products.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'products': instance.products,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    json['id'],
    json['flashsaleId'],
    json['productId'],
    json['discount'],
    json['quantity'],
    json['totalSale'],
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
      'totalSale': instance.totalSale,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['name'],
    json['image'],
    json['stock'],
    json['totalSale'],
    json['photo'],
    json['price'],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'stock': instance.stock,
      'totalSale': instance.totalSale,
      'photo': instance.photo,
      'price': instance.price,
    };
