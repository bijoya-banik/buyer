import 'package:json_annotation/json_annotation.dart';
part 'flashAllModel.g.dart';

@JsonSerializable()
class FlashAllModel {

  List<Products> product;


  FlashAllModel(this.product);

  factory FlashAllModel.fromJson(Map<String, dynamic> json) => _$FlashAllModelFromJson(json);
}

@JsonSerializable()
class Products {

  dynamic id;
  dynamic flashsaleId;
  dynamic productId;
  dynamic discount;
  dynamic quantity;
  dynamic totalsale;
  Product product;

  Products(this.id, this.flashsaleId, this.productId, this.discount, this.quantity, this.totalsale, this.product);

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);

}

@JsonSerializable()
class Product {

  dynamic id;
  dynamic name;
  dynamic image;
  dynamic photo;
  dynamic price;

  Product(this.id, this.name, this.image, this.photo, this.price);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

}