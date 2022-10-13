import 'package:json_annotation/json_annotation.dart';
part 'bestSellerModel.g.dart';

@JsonSerializable()
class BestSellerModel {
  List<Product> product;

  BestSellerModel(this.product);

  factory BestSellerModel.fromJson(Map<String, dynamic> json) =>
      _$BestSellerModelFromJson(json);
}

@JsonSerializable()
class Product {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic image;
  dynamic discount;
  Average average;

  Product(
      this.id, this.name, this.price, this.image, this.discount, this.average);

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
