import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_notification/main.dart';
import 'package:flutter_notification/features/home/presentation/pages/home_page.dart';
import 'package:flutter_notification/features/inventory/presentation/pages/inventory_page.dart';
import 'package:flutter_notification/features/equipment/presentation/pages/equipment_page.dart';
import 'package:flutter_notification/features/equipment/presentation/pages/equipment_menu_page.dart';
import 'package:flutter_notification/features/notifications/data/models/notification_model.dart';
import 'package:flutter_notification/features/notifications/presentation/services/deep_link_service.dart';
import 'package:flutter_notification/features/notifications/presentation/services/fcm_service.dart';
import 'helpers/firebase_test_helper.dart';

// Mock FCM Service for testing
class MockFcmService extends FcmService {
  @override
  Future<void> initialize() async {
    // Mock implementation - do nothing
  }

  @override
  Future<String?> getToken() async {
    return 'mock-fcm-token';
  }
}

void main() {
  // Setup Firebase for testing
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await setupFirebaseForTesting();
  });

  group('App Widget Tests', () {
    testWidgets('MyApp renders correctly', (WidgetTester tester) async {
      // Create a mock FCM service
      final mockFcmService = MockFcmService();

      // Build our app and trigger a frame
      await tester.pumpWidget(MyApp(fcmService: mockFcmService));
      await tester.pumpAndSettle();

      // Verify that the app title is present
      expect(find.text('Flutter Notification'), findsNothing); // Title is in MaterialApp, not visible
      
      // Verify that the initial route (Home) is displayed
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget); // AppBar title
    });

    testWidgets('App has correct theme', (WidgetTester tester) async {
      final mockFcmService = MockFcmService();
      
      await tester.pumpWidget(MyApp(fcmService: mockFcmService));
      await tester.pumpAndSettle();

      // Verify MaterialApp is present
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.title, equals('Flutter Notification'));
      expect(materialApp.theme, isNotNull);
    });
  });

  group('Home Page Tests', () {
    testWidgets('HomePage displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const HomePage(),
        ),
      );

      // Verify HomePage content
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Inventory Page Tests', () {
    testWidgets('InventoryPage displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: const InventoryPage(),
        ),
      );

      // Verify InventoryPage content
      expect(find.text('Inventory'), findsOneWidget);
      expect(find.text('Inventory Page'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Equipment Page Tests', () {
    testWidgets('EquipmentPage displays correctly with equipmentId', (WidgetTester tester) async {
      const equipmentId = 'equipment-123';
      
      await tester.pumpWidget(
        MaterialApp(
          home: EquipmentPage(equipmentId: equipmentId),
        ),
      );

      // Verify EquipmentPage content
      expect(find.text('Equipment: $equipmentId'), findsOneWidget);
      expect(find.text('Equipment Page: $equipmentId'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Equipment Menu Page Tests', () {
    testWidgets('EquipmentMenuPage displays correctly with equipmentId', (WidgetTester tester) async {
      const equipmentId = 'equipment-456';
      
      await tester.pumpWidget(
        MaterialApp(
          home: EquipmentMenuPage(equipmentId: equipmentId),
        ),
      );

      // Verify EquipmentMenuPage content
      expect(find.text('Equipment Menu: $equipmentId'), findsOneWidget);
      expect(find.text('Equipment Menu Page: $equipmentId'), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('NotificationModel Tests', () {
    test('NotificationModel creates correctly with all fields', () {
      final notification = NotificationModel(
        type: 'equipment',
        title: 'Test Title',
        body: 'Test Body',
        equipmentId: 'eq-123',
        userId: 'user-456',
        timestamp: DateTime(2024, 1, 1),
        metadata: {'key': 'value'},
      );

      expect(notification.type, equals('equipment'));
      expect(notification.title, equals('Test Title'));
      expect(notification.body, equals('Test Body'));
      expect(notification.equipmentId, equals('eq-123'));
      expect(notification.userId, equals('user-456'));
      expect(notification.metadata, equals({'key': 'value'}));
    });

    test('NotificationModel extension methods work correctly', () {
      final homeNotification = NotificationModel(type: 'home');
      final inventoryNotification = NotificationModel(type: 'inventory');
      final equipmentNotification = NotificationModel(
        type: 'equipment',
        equipmentId: 'eq-123',
      );
      final equipmentMenuNotification = NotificationModel(
        type: 'equipment_menu',
        equipmentId: 'eq-456',
      );

      // Test type checks
      expect(homeNotification.isHome, isTrue);
      expect(homeNotification.isInventory, isFalse);
      expect(inventoryNotification.isInventory, isTrue);
      expect(equipmentNotification.isEquipment, isTrue);
      expect(equipmentMenuNotification.isEquipmentMenu, isTrue);

      // Test deep link paths
      expect(homeNotification.deepLinkPath, equals('/home'));
      expect(inventoryNotification.deepLinkPath, equals('/inventory'));
      expect(equipmentNotification.deepLinkPath, equals('/equipment/eq-123'));
      expect(equipmentMenuNotification.deepLinkPath, equals('/equipment/menu/eq-456'));

      // Test deep link URIs
      expect(homeNotification.deepLinkUri, equals('myapp://notification/home'));
      expect(inventoryNotification.deepLinkUri, equals('myapp://notification/inventory'));
      expect(equipmentNotification.deepLinkUri, equals('myapp://notification/equipment/eq-123'));
      expect(equipmentMenuNotification.deepLinkUri, equals('myapp://notification/equipment_menu/eq-456'));
    });

    test('NotificationModel fromJson works correctly', () {
      final json = {
        'type': 'equipment',
        'title': 'Test Title',
        'body': 'Test Body',
        'equipment_id': 'eq-123',
        'user_id': 'user-456',
        'metadata': {'key': 'value'},
      };

      final notification = NotificationModel.fromJson(json);

      expect(notification.type, equals('equipment'));
      expect(notification.title, equals('Test Title'));
      expect(notification.body, equals('Test Body'));
      expect(notification.equipmentId, equals('eq-123'));
      expect(notification.userId, equals('user-456'));
      expect(notification.metadata, equals({'key': 'value'}));
    });
  });

  group('DeepLinkService Tests', () {
    late DeepLinkService deepLinkService;

    setUp(() {
      deepLinkService = DeepLinkService();
    });

    test('parseDeepLink parses valid home deep link', () {
      const uri = 'myapp://notification/home';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNotNull);
      expect(notification!.type, equals('home'));
    });

    test('parseDeepLink parses valid inventory deep link', () {
      const uri = 'myapp://notification/inventory';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNotNull);
      expect(notification!.type, equals('inventory'));
    });

    test('parseDeepLink parses valid equipment deep link with ID', () {
      const uri = 'myapp://notification/equipment/eq-123';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNotNull);
      expect(notification!.type, equals('equipment'));
      expect(notification.equipmentId, equals('eq-123'));
    });

    test('parseDeepLink parses valid equipment_menu deep link with ID', () {
      const uri = 'myapp://notification/equipment_menu/eq-456';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNotNull);
      expect(notification!.type, equals('equipment_menu'));
      expect(notification.equipmentId, equals('eq-456'));
    });

    test('parseDeepLink returns null for invalid scheme', () {
      const uri = 'invalid://notification/home';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNull);
    });

    test('parseDeepLink returns null for invalid host', () {
      const uri = 'myapp://invalid/home';
      final notification = deepLinkService.parseDeepLink(uri);

      expect(notification, isNull);
    });

    test('parseDeepLink returns null for null or empty URI', () {
      expect(deepLinkService.parseDeepLink(null), isNull);
      expect(deepLinkService.parseDeepLink(''), isNull);
    });

    test('generateDeepLink generates correct URI', () {
      final notification = NotificationModel(
        type: 'equipment',
        equipmentId: 'eq-123',
      );

      final uri = deepLinkService.generateDeepLink(notification);
      expect(uri, equals('myapp://notification/equipment/eq-123'));
    });

    test('getRoutePath returns correct path', () {
      final notification = NotificationModel(
        type: 'equipment',
        equipmentId: 'eq-123',
      );

      final path = deepLinkService.getRoutePath(notification);
      expect(path, equals('/equipment/eq-123'));
    });
  });

  group('Navigation Tests', () {
    testWidgets('App navigates to home route initially', (WidgetTester tester) async {
      final mockFcmService = MockFcmService();
      
      await tester.pumpWidget(MyApp(fcmService: mockFcmService));
      await tester.pumpAndSettle();

      // Verify home page is displayed
      expect(find.text('Home Page'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('Integration Tests', () {
    testWidgets('Complete app flow works correctly', (WidgetTester tester) async {
      final mockFcmService = MockFcmService();
      
      await tester.pumpWidget(MyApp(fcmService: mockFcmService));
      await tester.pumpAndSettle();

      // Verify app is running
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Home Page'), findsOneWidget);
    });
  });
}
