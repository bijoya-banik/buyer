import 'package:json_annotation/json_annotation.dart';
part 'NotificationOrderModel.g.dart';

@JsonSerializable()
class NotificationOrderModel {
  Order order;

  NotificationOrderModel(this.order);

  factory NotificationOrderModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationOrderModelFromJson(json);
}

@JsonSerializable()
class Order {
  dynamic id;
  dynamic date;
  dynamic status;
  dynamic discount;
  dynamic subTotal;
  dynamic paymentType;
  dynamic grandTotal;
  dynamic shippingPrice;
  dynamic orderType;
  dynamic area;
  dynamic house;
  dynamic road;
  dynamic block;
  dynamic city;
  dynamic state;
  dynamic country;
  List<Orderdetails> orderdetails;
  UsedVoucher used_vaoucher;

  Order(
      this.id,
      this.date,
      this.status,
      this.discount,
      this.subTotal,
      this.paymentType,
      this.grandTotal,
      this.shippingPrice,
      this.orderType,
      this.area,
      this.house,
      this.road,
      this.block,
      this.city,
      this.state,
      this.country,
      this.orderdetails, this.used_vaoucher);

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@JsonSerializable()
class Orderdetails {
  dynamic id;
  dynamic price;
  dynamic isReviewed;
  dynamic quantity;
  dynamic totalPrice;
  dynamic orderId;
  Product product;

  Orderdetails(this.id, this.price, this.isReviewed, this.quantity,
      this.totalPrice, this.orderId, this.product);

  factory Orderdetails.fromJson(Map<String, dynamic> json) =>
      _$OrderdetailsFromJson(json);
}

@JsonSerializable()
class Product {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic price;

  Product(this.id, this.name, this.image, this.price);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@JsonSerializable()
class UsedVoucher {
  dynamic id;
  dynamic userId;
  dynamic voucherId;
  dynamic orderId;
  Voucher voucher;
  UsedVoucher(
    this.id,
    this.orderId, this.userId, this.voucher, this.voucherId
  );
  factory UsedVoucher.fromJson(Map<String, dynamic> json) =>
      _$UsedVoucherFromJson(json);
}

@JsonSerializable()
class Voucher {
  dynamic id;
  dynamic code;
  dynamic discount;
  dynamic type;
  dynamic counter;
  dynamic validity;
  Voucher(
    this.id,
   this.type, this.code, this.counter, this.discount, this.validity
  );
  factory Voucher.fromJson(Map<String, dynamic> json) =>
      _$VoucherFromJson(json);
}
