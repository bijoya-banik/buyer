// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featuredProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedProductModel _$FeaturedProductModelFromJson(Map<String, dynamic> json) {
  return FeaturedProductModel(
    (json['product'] as List)
        ?.map((e) => e == null
            ? null
            : FeaturedProducts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeaturedProductModelToJson(
        FeaturedProductModel instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

FeaturedProducts _$FeaturedProductsFromJson(Map<String, dynamic> json) {
  return FeaturedProducts(
    json['name'],
    json['price'],
  );
}

Map<String, dynamic> _$FeaturedProductsToJson(FeaturedProducts instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
