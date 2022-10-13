import 'package:json_annotation/json_annotation.dart';
part 'sellModel.g.dart';

@JsonSerializable()
class SellModel {
  Status status;

  SellModel(this.status);

  factory SellModel.fromJson(Map<String, dynamic> json) => _$SellModelFromJson(json);
}
@JsonSerializable()
class Status {

  dynamic id;
  dynamic name;
  dynamic startTime;
  dynamic endTime;
  List<Products> products;


  Status(this.id, this.name, this.startTime, this.endTime, this.products);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

@JsonSerializable()
class Products {

  dynamic id;
  dynamic flashsaleId;
  dynamic productId;
  dynamic discount;
  dynamic quantity;
  dynamic totalSale;
  Product product;

  Products(this.id, this.flashsaleId, this.productId, this.discount, this.quantity, this.totalSale, this.product);

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

}

@JsonSerializable()
class Product {

  dynamic id;
  dynamic name;
  dynamic image;
  dynamic stock;
  dynamic totalSale;
  dynamic photo;
  dynamic price;

  Product(this.id, this.name, this.image, this.stock, this.totalSale, this.photo, this.price);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

}