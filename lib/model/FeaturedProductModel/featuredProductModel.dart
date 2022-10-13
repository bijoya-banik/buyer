import 'package:json_annotation/json_annotation.dart';
part 'featuredProductModel.g.dart';

@JsonSerializable()
class FeaturedProductModel {
  List <FeaturedProducts> product;

  FeaturedProductModel(this.product);

  factory FeaturedProductModel.fromJson(Map<String, dynamic> json) => _$FeaturedProductModelFromJson(json);
}
@JsonSerializable()
class FeaturedProducts {

  dynamic name;
  dynamic price;


  FeaturedProducts(this.name, this.price);

  factory FeaturedProducts.fromJson(Map<String, dynamic> json) => _$FeaturedProductsFromJson(json);

}