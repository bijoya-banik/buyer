// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    (json['order'] as List)
        ?.map(
            (e) => e == null ? null : Order.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    json['id'],
    json['date'],
    json['status'],
    json['discount'],
    json['subTotal'],
    json['paymentType'],
    json['grandTotal'],
    json['shippingPrice'],
    json['orderType'],
    json['area'],
    json['house'],
    json['road'],
    json['block'],
    json['city'],
    json['state'],
    json['country'],
    (json['orderdetails'] as List)
        ?.map((e) =>
            e == null ? null : Orderdetails.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['tax'],
  )..used_vaoucher = json['used_vaoucher'] == null
      ? null
      : UsedVoucher.fromJson(json['used_vaoucher'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'status': instance.status,
      'discount': instance.discount,
      'subTotal': instance.subTotal,
      'paymentType': instance.paymentType,
      'grandTotal': instance.grandTotal,
      'shippingPrice': instance.shippingPrice,
      'orderType': instance.orderType,
      'area': instance.area,
      'house': instance.house,
      'road': instance.road,
      'block': instance.block,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'tax': instance.tax,
      'orderdetails': instance.orderdetails,
      'used_vaoucher': instance.used_vaoucher,
    };

Orderdetails _$OrderdetailsFromJson(Map<String, dynamic> json) {
  return Orderdetails(
    json['id'],
    json['price'],
    json['isReviewed'],
    json['quantity'],
    json['totalPrice'],
    json['orderId'],
    json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderdetailsToJson(Orderdetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'isReviewed': instance.isReviewed,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'orderId': instance.orderId,
      'product': instance.product,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    json['id'],
    json['name'],
    json['image'],
    json['price'],
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
    };

UsedVoucher _$UsedVoucherFromJson(Map<String, dynamic> json) {
  return UsedVoucher(
    json['id'],
    json['orderId'],
    json['userId'],
    json['voucher'] == null
        ? null
        : Voucher.fromJson(json['voucher'] as Map<String, dynamic>),
    json['voucherId'],
  );
}

Map<String, dynamic> _$UsedVoucherToJson(UsedVoucher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'voucherId': instance.voucherId,
      'orderId': instance.orderId,
      'voucher': instance.voucher,
    };

Voucher _$VoucherFromJson(Map<String, dynamic> json) {
  return Voucher(
    json['id'],
    json['type'],
    json['code'],
    json['counter'],
    json['discount'],
    json['validity'],
  );
}

Map<String, dynamic> _$VoucherToJson(Voucher instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discount': instance.discount,
      'type': instance.type,
      'counter': instance.counter,
      'validity': instance.validity,
    };
