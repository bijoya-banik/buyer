import 'package:json_annotation/json_annotation.dart';

part 'NotificationModel.g.dart';

@JsonSerializable()
class NotificationModel {
  List<Notification> notification;

  NotificationModel(this.notification);

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}


@JsonSerializable()
class Notification {
 
 dynamic id;
 dynamic userId;
 dynamic orderId;
 dynamic title;
 dynamic msg;
 dynamic type;
 dynamic seen;

  Notification(this.id, this.msg, this.orderId, this.seen, this.title, this.type, this.userId);

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}