import 'package:flutter/material.dart';
import 'src/features/auth/presentation/bindings/auth_binding.dart';
import 'src/features/home/presentation/bindings/home_binding.dart';
import 'src/core/theme/app_theme.dart';
import 'src/core/routes/app_router.dart';

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

    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}
