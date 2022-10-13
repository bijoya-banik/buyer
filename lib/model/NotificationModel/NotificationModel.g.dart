// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    (json['notification'] as List)
        ?.map((e) =>
            e == null ? null : Notification.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notification': instance.notification,
    };

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return Notification(
    json['id'],
    json['msg'],
    json['orderId'],
    json['seen'],
    json['title'],
    json['type'],
    json['userId'],
  );
}

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'title': instance.title,
      'msg': instance.msg,
      'type': instance.type,
      'seen': instance.seen,
    };
