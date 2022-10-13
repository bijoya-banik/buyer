import 'package:json_annotation/json_annotation.dart';
part 'flashCheckModel.g.dart';

@JsonSerializable()
class FlashCheckModel {
  List<Status> status;

  FlashCheckModel(this.status);

  factory FlashCheckModel.fromJson(Map<String, dynamic> json) => _$FlashCheckModelFromJson(json);
}
@JsonSerializable()
class Status {

  dynamic id;
  dynamic name;
  dynamic startTime;
  dynamic endTime;
  Product product;


  Status(this.id, this.name, this.startTime, this.endTime, this.product);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}

@JsonSerializable()
class Product {

  dynamic id;
  dynamic flashsaleId;
  dynamic discount;
  dynamic quantity;
  dynamic totalSale;

  Product(this.id, this.flashsaleId, this.discount, this.quantity, this.totalSale);

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

}