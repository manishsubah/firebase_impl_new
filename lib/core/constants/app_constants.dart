class AppConstants {
  // Deep link scheme
  static const String deepLinkScheme = 'myapp';
  static const String deepLinkHost = 'notification';
  
  // Notification types
  static const String notificationTypeHome = 'home';
  static const String notificationTypeInventory = 'inventory';
  static const String notificationTypeEquipment = 'equipment';
  static const String notificationTypeEquipmentMenu = 'equipment_menu';
  
  // Deep link patterns
  static const String deepLinkPattern = '$deepLinkScheme://$deepLinkHost';
  
  // Route paths
  static const String routeHome = '/home';
  static const String routeInventory = '/inventory';
  static const String routeEquipment = '/equipment';
  static const String routeEquipmentMenu = '/equipment/menu';
}
