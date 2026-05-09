import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/email_confirmation_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/setup_profile_page.dart';
import '../../features/auth/presentation/pages/setup_ride_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        name: 'otpVerification',

        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return OtpVerificationPage(
            email: extraData?['email'] ?? '',
            isForResetPass: extraData?['isForResetPass'] ?? false,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.emailConfirmation,
        name: 'emailConfirmation',
        builder: (context, state) => const EmailConfirmationPage(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.setupProfile,
        name: 'setupProfile',
        builder: (context, state) => const SetupProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.setupRide,
        name: 'setupRide',
        builder: (context, state) => const SetupRidePage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'detail/:id',
            name: 'detail',
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '';
              return DetailPage(id: id);
            },
          ),
        ],
      ),
    ],

    // Global error page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Route not found: ${state.uri}'),
      ),
    ),

    // Redirect logic (e.g. auth guard)
    redirect: (context, state) {
      // TODO: inject AuthController and check isLoggedIn
      // final auth = Get.find<AuthController>();
      // final loggedIn = auth.isLoggedIn.value;
      // if (!loggedIn && state.uri.toString() != AppRoutes.login) {
      //   return AppRoutes.login;
      // }
      return null;
    },
  );
}

// ── Placeholder detail page ───────────────────────────────
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail — $id')),
      body: Center(child: Text('Item ID: $id')),
    );
  }
}
