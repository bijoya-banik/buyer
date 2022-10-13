// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllProductModel _$AllProductModelFromJson(Map<String, dynamic> json) {
  return AllProductModel(
    (json['product'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AllProductModelToJson(AllProductModel instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['name'],
    json['price'],
    json['image'],
    json['discount'],
    json['stock'],
    json['totalSale'],
    json['average'] == null
        ? null
        : Average.fromJson(json['average'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'discount': instance.discount,
      'stock': instance.stock,
      'totalSale': instance.totalSale,
      'average': instance.average,
    };

Average _$AverageFromJson(Map<String, dynamic> json) {
  return Average(
    json['averageRating'],
  );
}

Map<String, dynamic> _$AverageToJson(Average instance) => <String, dynamic>{
      'averageRating': instance.averageRating,
    };
