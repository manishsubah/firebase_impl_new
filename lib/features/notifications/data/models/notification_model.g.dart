// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationModelImpl(
  type: json['type'] as String,
  title: json['title'] as String?,
  body: json['body'] as String?,
  data: json['data'] as Map<String, dynamic>?,
  equipmentId: json['equipmentId'] as String?,
  inventoryId: json['inventoryId'] as String?,
  userId: json['userId'] as String?,
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$NotificationModelImplToJson(
  _$NotificationModelImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'body': instance.body,
  'data': instance.data,
  'equipmentId': instance.equipmentId,
  'inventoryId': instance.inventoryId,
  'userId': instance.userId,
  'timestamp': instance.timestamp?.toIso8601String(),
  'metadata': instance.metadata,
};
