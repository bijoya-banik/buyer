import 'package:json_annotation/json_annotation.dart';
part 'subCategoryModel.g.dart';

@JsonSerializable()
class SubCategoryModel {
  List<Status> status;

  SubCategoryModel(this.status);

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => _$SubCategoryModelFromJson(json);
}

@JsonSerializable()
class Status {
  dynamic id;
  dynamic name;

  Status(this.id, this.name);

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
}