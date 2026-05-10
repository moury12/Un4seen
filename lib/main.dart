import 'package:flutter/material.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
