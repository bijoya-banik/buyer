import 'package:json_annotation/json_annotation.dart';
part 'addressModel.g.dart';

@JsonSerializable()
class AddressModel {
  List<Address> address;

  AddressModel(this.address);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

@JsonSerializable()
class Address {

  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic mobile;
  dynamic area;
  dynamic house;
  dynamic road;
  dynamic block;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic country_code;

  Address(this.id, this.userId, this.area, this.house, this.road, this.block,
      this.city, this.state, this.country,this.mobile, this.name,this.country_code);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
