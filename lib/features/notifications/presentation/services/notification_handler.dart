import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_notification/features/notifications/data/models/notification_model.dart';
import 'deep_link_service.dart';
import 'package:flutter_notification/features/navigation/navigation_service.dart';

class NotificationHandler {
  final DeepLinkService _deepLinkService = DeepLinkService();
  final NavigationService _navigationService = NavigationService();
  final Logger _logger = Logger();
  NotificationModel? _pendingNotification;
  
  /// Handle notification when app is in foreground
  void handleForegroundNotification(NotificationModel notification) {
    _logger.i('Handling foreground notification: ${notification.type}');
    
    // Show local notification or in-app banner
    // You can use flutter_local_notifications for this
    // For now, we'll just log it
    _logger.d('Notification data: ${notification.data}');
    
    // Optionally show a snackbar or dialog
    // _showInAppNotification(notification);
  }
  
  /// Handle notification when app is opened from terminated state
  void handleInitialNotification(NotificationModel notification) {
    _logger.i('Handling initial notification: ${notification.type}');
    _navigateFromNotification(notification);
  }
  
  /// Handle notification when app is opened from background
  void handleBackgroundOpenedNotification(NotificationModel notification) {
    _logger.i('Handling background opened notification: ${notification.type}');
    _navigateFromNotification(notification);
  }
  
  /// Handle notification in background (isolate)
  Future<void> handleBackgroundNotification(NotificationModel notification) async {
    _logger.i('Handling background notification: ${notification.type}');
    // Perform any background processing here
    // Note: Navigation is not possible in background isolate
  }
  
  /// Navigate based on notification type
  void _navigateFromNotification(NotificationModel notification) {
    final routePath = _deepLinkService.getRoutePath(notification);
    _logger.i('Navigating to: $routePath');
    
    // Store pending notification
    _pendingNotification = notification;
    
    // Try to navigate when context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigation will be handled when app opens or context becomes available
      // The FCM service will call this when notification is opened
    });
  }
  
  /// Process pending notification when app is ready
  void processPendingNotification() {
    if (_pendingNotification != null) {
      final notification = _pendingNotification!;
      _pendingNotification = null;
      _navigateFromNotification(notification);
    }
  }
  
  /// Navigate with context (called from app when notification opens)
  void navigateWithContext(BuildContext context, NotificationModel notification) {
    final routePath = _deepLinkService.getRoutePath(notification);
    _logger.i('Navigating to: $routePath');
    _navigationService.navigateToRouteWithContext(
      context,
      routePath,
      arguments: notification,
    );
  }
  
}
