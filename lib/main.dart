import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:un4seen/firebase_options.dart';
import 'package:un4seen/src/core/services/notification_service.dart';
import 'src/core/services/local_storage_service.dart';
import 'src/core/services/socket_service.dart';
import 'src/core/widgets/custom_snackbar.dart';
import 'src/features/auth/presentation/bindings/auth_binding.dart';
import 'src/features/home/presentation/bindings/home_binding.dart';
import 'src/core/theme/app_theme.dart';
import 'src/core/routes/app_router.dart';
import 'src/features/navigation/presentation/bindings/navigation_binding.dart';
import 'src/features/competitions/presentation/bindings/competitions_binding.dart';
import 'src/features/giveaway/presentation/bindings/giveaway_binding.dart';
import 'src/features/points/presentation/bindings/points_binding.dart';
import 'src/features/stories/presentation/bindings/stories_binding.dart';
import 'src/features/profile/presentation/bindings/profile_binding.dart';
import 'src/features/orders/presentation/bindings/orders_binding.dart';
import 'src/features/subscription/presentation/bindings/subscription_binding.dart';
import 'src/features/bike_profiles/presentation/bindings/bike_profiles_binding.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print(message.messageId);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler);
    await NotificationService().initialize();
    String? token = await FirebaseMessaging.instance.getToken();

print(token);
  final storage = await LocalStorageService().init();
  Get.put(storage, permanent: true);

  // Initialize Socket Service globally
  final socketService = Get.put(SocketService(), permanent: true);
  socketService.initSocket();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Bootstrap global bindings
    AuthBinding().dependencies();
    HomeBinding().dependencies();
    NavigationBinding().dependencies();
    CompetitionsBinding().dependencies();
    GiveawayBinding().dependencies();
    PointsBinding().dependencies();
    StoriesBinding().dependencies();
    ProfileBinding().dependencies();
    OrdersBinding().dependencies();
    SubscriptionBinding().dependencies();
    BikeProfilesBinding().dependencies();

    return GetMaterialApp.router(
      title: 'UN4SEEN',
      // scaffoldMessengerKey: CustomSnackbar.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      backButtonDispatcher: AppRouter.router.backButtonDispatcher,
    );
  }
}
