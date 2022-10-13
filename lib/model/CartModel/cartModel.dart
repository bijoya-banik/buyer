import 'package:json_annotation/json_annotation.dart';
part 'cartModel.g.dart';

@JsonSerializable()
class CartModel {
  List<Cart> cart;
  dynamic isFlashsaleOrder;

  CartModel(this.cart, this.isFlashsaleOrder);

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}

@JsonSerializable()
class Cart {
  dynamic id;
  dynamic quantity;
  dynamic combinationId;
  dynamic combination;
  dynamic price;
  dynamic type;
  Product product;
  Allcombination allcombination;

  Cart(this.id, this.product, this.combinationId, this.combination,
      this.price, this.type,this.quantity);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}

@JsonSerializable()
class Product {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic price;
  dynamic stock;
  dynamic discount;
  FlashProduct flashProduct;

  Product(
      this.id, this.name, this.image, this.stock, this.price, this.discount, this.flashProduct);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@JsonSerializable()
class FlashProduct {
  dynamic id;
  dynamic flashsaleId;
  dynamic productId;
  dynamic discount;
  dynamic quantity;
  dynamic totalSale;

  FlashProduct(
      this.id, this.flashsaleId, this.productId, this.discount, this.quantity, this.totalSale);

  factory FlashProduct.fromJson(Map<String, dynamic> json) =>
      _$FlashProductFromJson(json);
}

@JsonSerializable()
class Allcombination {
  dynamic id;
  dynamic productId;
  dynamic combination;
  dynamic stock;

  Allcombination(
      this.id, this.productId, this.combination, this.stock);

  factory Allcombination.fromJson(Map<String, dynamic> json) =>
      _$AllcombinationFromJson(json);
}
