// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    (json['cart'] as List)
        ?.map(
            (e) => e == null ? null : Cart.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['isFlashsaleOrder'],
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'cart': instance.cart,
      'isFlashsaleOrder': instance.isFlashsaleOrder,
    };

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    json['id'],
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    json['combinationId'],
    json['combination'],
    json['price'],
    json['type'],
    json['quantity'],
  )..allcombination = json['allcombination'] == null
      ? null
      : Allcombination.fromJson(json['allcombination'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'combinationId': instance.combinationId,                     
      'combination': instance.combination,
      'price': instance.price,
      'type': instance.type,
      'product': instance.product,
      'allcombination': instance.allcombination,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['name'],
    json['image'],
    json['stock'],
    json['price'],
    json['discount'],
    json['flash_product']== null
        ? null
        : FlashProduct.fromJson(json['flash_product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'stock': instance.stock,
      'discount': instance.discount,
      'flashProduct': instance.flashProduct,
    };

FlashProduct _$FlashProductFromJson(Map<String, dynamic> json) {
  return FlashProduct(
    json['id'],
    json['flashsaleId'],
    json['productId'],
    json['discount'],
    json['quantity'],
    json['totalSale'],
  );
}

Map<String, dynamic> _$FlashProductToJson(FlashProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flashsaleId': instance.flashsaleId,
      'productId': instance.productId,
      'discount': instance.discount,
      'quantity': instance.quantity,
      'totalSale': instance.totalSale,
    };

Allcombination _$AllcombinationFromJson(Map<String, dynamic> json) {
  return Allcombination(
    json['id'],
    json['productId'],
    json['combination'],
    json['stock'],
  );
}

Map<String, dynamic> _$AllcombinationToJson(Allcombination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'combination': instance.combination,
      'stock': instance.stock,
    };
