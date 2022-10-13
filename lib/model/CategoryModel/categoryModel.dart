import 'package:json_annotation/json_annotation.dart';
part 'categoryModel.g.dart';

@JsonSerializable()
class CategoryModel {
  List<Status> status;

  CategoryModel(this.status);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}

@JsonSerializable()
class Status {
  dynamic id;
  dynamic name;

  Status(this.name);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}