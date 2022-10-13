import 'package:json_annotation/json_annotation.dart';
part 'preorderModel.g.dart';

@JsonSerializable()
class PreorderModel {
  List<Reservation> reservation;

  PreorderModel(this.reservation);

  factory PreorderModel.fromJson(Map<String, dynamic> json) =>
      _$PreorderModelFromJson(json);
}

@JsonSerializable()
class Reservation {
  dynamic id;
  dynamic userId;
  dynamic productId;
  dynamic quantity;
  dynamic combinationId;
  dynamic status;
  Products product;

  Reservation(this.id, this.userId, this.productId, this.quantity,
      this.combinationId, this.status, this.product);

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
}

@JsonSerializable()
class Products {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic description;
  dynamic price;
  dynamic discount;
  dynamic stock;
  dynamic totalSale;
  List<Photo> photo;
  List<Video> video;
  Average average;
  List<Review> review;
  List<Product_vc> product_vc;
  List<Product_variable> product_variable;

  Products(
      this.id,
      this.name,
      this.image,
      this.description,
      this.price,
      this.discount,
      this.stock,
      this.totalSale,
      this.photo,
      this.video,
      this.average,
      this.review,
      this.product_vc,
      this.product_variable);

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
}

@JsonSerializable()
class Photo {
  dynamic id;
  dynamic link;

  Photo(this.id, this.link);

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@JsonSerializable()
class Video {
  dynamic id;
  dynamic link;

  Video(this.id, this.link);

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}

@JsonSerializable()
class Average {
  dynamic productId;
  dynamic averageRating;

  Average(this.productId, this.averageRating);

  factory Average.fromJson(Map<String, dynamic> json) =>
      _$AverageFromJson(json);
}

@JsonSerializable()
class Review {
  dynamic id;
  dynamic userId;
  dynamic review;
  dynamic rating;
  User user;

  Review(this.id, this.userId, this.review, this.rating, this.user);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

@JsonSerializable()
class User {
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic profilepic;

  User(this.id, this.firstName, this.lastName, this.profilepic);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Product_vc {
  dynamic id;
  dynamic productId;
  dynamic combination;
  dynamic stock;

  Product_vc(this.id, this.productId, this.combination, this.stock);

  factory Product_vc.fromJson(Map<String, dynamic> json) =>
      _$Product_vcFromJson(json);
}

@JsonSerializable()
class Product_variable {
  dynamic id;
  dynamic productId;
  dynamic name;
  List<Values> values;

  Product_variable(this.id, this.productId, this.name, this.values);

  factory Product_variable.fromJson(Map<String, dynamic> json) =>
      _$Product_variableFromJson(json);
}

@JsonSerializable()
class Values {
  dynamic id;
  dynamic productId;
  dynamic variationId;
  dynamic value;

  Values(this.id, this.productId, this.variationId, this.value);

  factory Values.fromJson(Map<String, dynamic> json) => _$ValuesFromJson(json);
}
