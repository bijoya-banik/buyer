// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preorderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreorderModel _$PreorderModelFromJson(Map<String, dynamic> json) {
  return PreorderModel(
    (json['reservation'] as List)
        ?.map((e) =>
            e == null ? null : Reservation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PreorderModelToJson(PreorderModel instance) =>
    <String, dynamic>{
      'reservation': instance.reservation,
    };

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return Reservation(
    json['id'],
    json['userId'],
    json['productId'],
    json['quantity'],
    json['combinationId'],
    json['status'],
    json['product'] == null
        ? null
        : Products.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReservationToJson(Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'combinationId': instance.combinationId,
      'status': instance.status,
      'product': instance.product,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) {
  return Products(
    json['id'],
    json['name'],
    json['image'],
    json['description'],
    json['price'],
    json['discount'],
    json['stock'],
    json['totalSale'],
    (json['photo'] as List)
        ?.map(
            (e) => e == null ? null : Photo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['video'] as List)
        ?.map(
            (e) => e == null ? null : Video.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['average'] == null
        ? null
        : Average.fromJson(json['average'] as Map<String, dynamic>),
    (json['review'] as List)
        ?.map((e) =>
            e == null ? null : Review.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['product_vc'] as List)
        ?.map((e) =>
            e == null ? null : Product_vc.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['product_variable'] as List)
        ?.map((e) => e == null
            ? null
            : Product_variable.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'price': instance.price,
      'discount': instance.discount,
      'stock': instance.stock,
      'totalSale': instance.totalSale,
      'photo': instance.photo,
      'video': instance.video,
      'average': instance.average,
      'review': instance.review,
      'product_vc': instance.product_vc,
      'product_variable': instance.product_variable,
    };

Photo _$PhotoFromJson(Map<String, dynamic> json) {
  return Photo(
    json['id'],
    json['link'],
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
    };

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video(
    json['id'],
    json['link'],
  );
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
    };

Average _$AverageFromJson(Map<String, dynamic> json) {
  return Average(
    json['productId'],
    json['averageRating'],
  );
}

Map<String, dynamic> _$AverageToJson(Average instance) => <String, dynamic>{
      'productId': instance.productId,
      'averageRating': instance.averageRating,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['id'],
    json['userId'],
    json['review'],
    json['rating'],
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'review': instance.review,
      'rating': instance.rating,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'],
    json['firstName'],
    json['lastName'],
    json['profilepic'],
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilepic': instance.profilepic,
    };

Product_vc _$Product_vcFromJson(Map<String, dynamic> json) {
  return Product_vc(
    json['id'],
    json['productId'],
    json['combination'],
    json['stock'],
  );
}

Map<String, dynamic> _$Product_vcToJson(Product_vc instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'combination': instance.combination,
      'stock': instance.stock,
    };

Product_variable _$Product_variableFromJson(Map<String, dynamic> json) {
  return Product_variable(
    json['id'],
    json['productId'],
    json['name'],
    (json['values'] as List)
        ?.map((e) =>
            e == null ? null : Values.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$Product_variableToJson(Product_variable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'values': instance.values,
    };

Values _$ValuesFromJson(Map<String, dynamic> json) {
  return Values(
    json['id'],
    json['productId'],
    json['variationId'],
    json['value'],
  );
}

Map<String, dynamic> _$ValuesToJson(Values instance) => <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'variationId': instance.variationId,
      'value': instance.value,
    };
