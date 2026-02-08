import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String type,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? equipmentId,
    String? inventoryId,
    String? userId,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}

// Extension for type-safe navigation
extension NotificationModelExtension on NotificationModel {
  bool get isHome => type == 'home';
  bool get isInventory => type == 'inventory';
  bool get isEquipment => type == 'equipment';
  bool get isEquipmentMenu => type == 'equipment_menu';
  
  String get deepLinkPath {
    switch (type) {
      case 'home':
        return '/home';
      case 'inventory':
        return '/inventory';
      case 'equipment':
        return '/equipment/${equipmentId ?? ''}';
      case 'equipment_menu':
        return '/equipment/menu/${equipmentId ?? ''}';
      default:
        return '/home';
    }
  }
  
  String get deepLinkUri {
    if (equipmentId != null && (type == 'equipment' || type == 'equipment_menu')) {
      return 'myapp://notification/$type/$equipmentId';
    }
    return 'myapp://notification/$type';
  }
}
