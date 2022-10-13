// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return AddressModel(
    (json['address'] as List)
        ?.map((e) =>
            e == null ? null : Address.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['id'],
    json['userId'],
    json['area'],
    json['house'],
    json['road'],
    json['block'],
    json['city'],
    json['state'],
    json['country'],
    json['mobile'],
    json['name'],
    json['country_code'],
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'mobile': instance.mobile,
      'area': instance.area,
      'house': instance.house,
      'road': instance.road,
      'block': instance.block,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'country_code': instance.country_code,
    };
