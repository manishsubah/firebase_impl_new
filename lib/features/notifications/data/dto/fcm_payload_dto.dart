import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification/features/notifications/data/models/notification_model.dart';

class FcmPayloadDto {
  static NotificationModel fromRemoteMessage(RemoteMessage message) {
    final data = message.data;
    final notification = message.notification;
    
    return NotificationModel(
      type: data['type'] as String? ?? 'unknown',
      title: notification?.title ?? data['title'] as String?,
      body: notification?.body ?? data['body'] as String?,
      data: data,
      equipmentId: data['equipment_id'] as String? ?? data['equipmentId'] as String?,
      inventoryId: data['inventory_id'] as String? ?? data['inventoryId'] as String?,
      userId: data['user_id'] as String? ?? data['userId'] as String?,
      timestamp: message.sentTime,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }
  
  static NotificationModel? fromInitialMessage(Map<String, dynamic>? data) {
    if (data == null) return null;
    
    return NotificationModel(
      type: data['type'] as String? ?? 'unknown',
      title: data['title'] as String?,
      body: data['body'] as String?,
      data: data,
      equipmentId: data['equipment_id'] as String? ?? data['equipmentId'] as String?,
      inventoryId: data['inventory_id'] as String? ?? data['inventoryId'] as String?,
      userId: data['user_id'] as String? ?? data['userId'] as String?,
      timestamp: DateTime.now(),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }
}
