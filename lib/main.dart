import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'features/notifications/presentation/services/fcm_service.dart';
import 'features/navigation/navigation_service.dart';

final navigationService = NavigationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize FCM (non-blocking - will complete in background)
  final fcmService = FcmService();
  // Don't await - let app start while FCM initializes
  fcmService.initialize().catchError((error) {
    // Log error but don't block app startup
    print('FCM initialization error: $error');
  });
  
  runApp(MyApp(fcmService: fcmService));
}

class MyApp extends StatefulWidget {
  final FcmService fcmService;
  
  const MyApp({super.key, required this.fcmService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Process any pending notifications after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigation will be handled by FCM service when notification is opened
    });
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = navigationService.router;
    
    print('Building MyApp widget...'); // Debug log
    
    return MaterialApp.router(
      title: 'Flutter Notification',
      routerConfig: appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
