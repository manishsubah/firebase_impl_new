import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification/app/app_router.dart';
import 'package:flutter_notification/features/notifications/data/models/notification_model.dart';

class NavigationService {
  final AppRouter _router = AppRouter();
  
  /// Navigate to route based on path
  void navigateToRoute(String routePath, {NotificationModel? arguments}) {
    // This method requires a BuildContext, use navigateToRouteWithContext instead
  }
  
  /// Navigate using router context
  void navigateToRouteWithContext(BuildContext context, String routePath, {NotificationModel? arguments}) {
    try {
      final router = context.router;
      
      if (routePath.startsWith('/equipment/menu/')) {
        final equipmentId = routePath.split('/').last;
        final finalId = equipmentId.isNotEmpty ? equipmentId : (arguments?.equipmentId ?? '');
        if (finalId.isNotEmpty) {
          router.replaceAll([EquipmentMenuRoute(equipmentId: finalId)]);
          return;
        }
      } else if (routePath.startsWith('/equipment/')) {
        final parts = routePath.split('/');
        final equipmentId = parts.length >= 3 && parts[2].isNotEmpty 
            ? parts[2] 
            : (arguments?.equipmentId ?? '');
        if (equipmentId.isNotEmpty) {
          router.replaceAll([EquipmentRoute(equipmentId: equipmentId)]);
          return;
        }
      }
      
      switch (routePath) {
        case '/home':
          router.replaceAll([const HomeRoute()]);
          break;
        case '/inventory':
          router.replaceAll([const InventoryRoute()]);
          break;
        default:
          router.replaceAll([const HomeRoute()]);
      }
    } catch (e) {
      // Fallback to home
      context.router.replaceAll([const HomeRoute()]);
    }
  }
  
  AppRouter get router => _router;
}
