import 'package:json_annotation/json_annotation.dart';
part 'allProductModel.g.dart';

@JsonSerializable()
class AllProductModel {
  List<Product> product;

  AllProductModel(this.product);

  factory AllProductModel.fromJson(Map<String, dynamic> json) =>
      _$AllProductModelFromJson(json);
}

@JsonSerializable()
class Product {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic image;
  dynamic discount;
  dynamic stock;
  dynamic totalSale;
  Average average;

  Product(
      this.id, this.name, this.price, this.image, this.discount, this.stock, this.totalSale, this.average);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@JsonSerializable()
class Average {
  dynamic averageRating;

  Average(this.averageRating);

  factory Average.fromJson(Map<String, dynamic> json) =>
      _$AverageFromJson(json);
}