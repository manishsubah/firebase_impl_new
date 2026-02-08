import 'package:logger/logger.dart';
import 'package:flutter_notification/core/constants/app_constants.dart';
import 'package:flutter_notification/features/notifications/data/models/notification_model.dart';

class DeepLinkService {
  final Logger _logger = Logger();
  
  /// Parse deep link URI to NotificationModel
  NotificationModel? parseDeepLink(String? uri) {
    if (uri == null || uri.isEmpty) return null;
    
    try {
      final uriParsed = Uri.parse(uri);
      
      if (uriParsed.scheme != AppConstants.deepLinkScheme ||
          uriParsed.host != AppConstants.deepLinkHost) {
        return null;
      }
      
      final pathSegments = uriParsed.pathSegments;
      if (pathSegments.isEmpty) return null;
      
      final type = pathSegments[0];
      final id = pathSegments.length > 1 ? pathSegments[1] : null;
      
      return NotificationModel(
        type: type,
        equipmentId: type.contains('equipment') ? id : null,
        inventoryId: type == 'inventory' ? id : null,
        data: uriParsed.queryParameters,
      );
    } catch (e) {
      _logger.e('Error parsing deep link: $e');
      return null;
    }
  }
  
  /// Generate deep link URI from NotificationModel
  String generateDeepLink(NotificationModel notification) {
    return notification.deepLinkUri;
  }
  
  /// Extract route path from NotificationModel
  String getRoutePath(NotificationModel notification) {
    return notification.deepLinkPath;
  }
}
