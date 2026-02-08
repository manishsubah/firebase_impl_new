import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

// Mock Firebase for testing
class MockFirebasePlatform extends FirebasePlatform {
  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) {
    throw UnimplementedError();
  }

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async {
    return MockFirebaseApp();
  }

  @override
  List<FirebaseAppPlatform> get apps => [MockFirebaseApp()];
}

class MockFirebaseApp extends FirebaseAppPlatform {
  MockFirebaseApp() : super('test', MockFirebaseOptions());

  @override
  bool get isAutomaticDataCollectionEnabled => false;

  @override
  String get name => 'test';

  @override
  FirebaseOptions get options => MockFirebaseOptions();
}

class MockFirebaseOptions extends FirebaseOptions {
  MockFirebaseOptions()
      : super(
          apiKey: 'test-api-key',
          appId: 'test-app-id',
          messagingSenderId: 'test-sender-id',
          projectId: 'test-project-id',
        );
}

/// Setup Firebase for testing
Future<void> setupFirebaseForTesting() async {
  FirebasePlatform.instance = MockFirebasePlatform();
  await Firebase.initializeApp();
}
