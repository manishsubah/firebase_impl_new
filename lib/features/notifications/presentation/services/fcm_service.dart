import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:flutter_notification/features/notifications/data/dto/fcm_payload_dto.dart';
import 'notification_handler.dart';

/// Top-level function for background message handling
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final handler = NotificationHandler();
  final notification = FcmPayloadDto.fromRemoteMessage(message);
  await handler.handleBackgroundNotification(notification);
}

class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final NotificationHandler _handler = NotificationHandler();
  final Logger _logger = Logger();
  
  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<String>? _onTokenRefreshSubscription;
  
  /// Initialize FCM service
  Future<void> initialize() async {
    try {
      _logger.i('Starting FCM initialization...');
      
      // Request permissions (this may show a dialog on iOS)
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      
      _logger.i('Notification permission: ${settings.authorizationStatus}');
      
      // Get FCM token
      final token = await _messaging.getToken();
      _logger.i('FCM Token: $token');
      print('FCM Token: $token'); // Also print to console for debugging
      // TODO: Send token to backend
      
      // Setup background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
      // Listen for foreground messages
      _onMessageSubscription = FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
      
      // Listen for token refresh
      _onTokenRefreshSubscription = _messaging.onTokenRefresh.listen(_handleTokenRefresh);
      
      // Handle notification when app is opened from terminated state
      final initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleInitialMessage(initialMessage);
      }
      
      // Handle notification when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
      
      _logger.i('FCM initialization completed successfully');
      
    } catch (e, stackTrace) {
      _logger.e('Error initializing FCM: $e', error: e, stackTrace: stackTrace);
      print('FCM initialization error: $e');
      // Don't rethrow - allow app to continue
    }
  }
  
  /// Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    _logger.i('Foreground message received: ${message.messageId}');
    final notification = FcmPayloadDto.fromRemoteMessage(message);
    _handler.handleForegroundNotification(notification);
  }
  
  /// Handle initial message (app opened from terminated state)
  void _handleInitialMessage(RemoteMessage message) {
    _logger.i('Initial message received: ${message.messageId}');
    final notification = FcmPayloadDto.fromRemoteMessage(message);
    _handler.handleInitialNotification(notification);
  }
  
  /// Handle message opened from background
  void _handleMessageOpenedApp(RemoteMessage message) {
    _logger.i('Message opened from background: ${message.messageId}');
    final notification = FcmPayloadDto.fromRemoteMessage(message);
    _handler.handleBackgroundOpenedNotification(notification);
  }
  
  /// Handle token refresh
  void _handleTokenRefresh(String token) {
    _logger.i('FCM Token refreshed: $token');
    // TODO: Send updated token to backend
  }
  
  /// Get current FCM token
  Future<String?> getToken() async {
    return await _messaging.getToken();
  }
  
  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    _logger.i('Subscribed to topic: $topic');
  }
  
  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    _logger.i('Unsubscribed from topic: $topic');
  }
  
  /// Dispose resources
  void dispose() {
    _onMessageSubscription?.cancel();
    _onTokenRefreshSubscription?.cancel();
  }
}
