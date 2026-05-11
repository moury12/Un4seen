import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/email_confirmation_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/setup_profile_page.dart';
import '../../features/auth/presentation/pages/setup_ride_page.dart';
import '../../features/navigation/presentation/pages/navigation_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
import '../../features/stories/presentation/pages/saved_stories_page.dart';
import '../../features/bike_profiles/presentation/pages/bike_profiles_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/profile_setting_page.dart';
import '../../features/profile/presentation/pages/test_rider_program_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
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
        path: AppRoutes.navigation,
        name: 'navigation',
        builder: (context, state) => const NavigationPage(),
      ),
      GoRoute(
        path: AppRoutes.orders,
        name: 'orders',
        builder: (context, state) => const OrdersPage(),
      ),
      GoRoute(
        path: AppRoutes.subscription,
        name: 'subscription',
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(
        path: AppRoutes.savedStories,
        name: 'savedStories',
        builder: (context, state) => const SavedStoriesPage(),
      ),
      GoRoute(
        path: AppRoutes.bikeProfiles,
        name: 'bikeProfiles',
        builder: (context, state) => const SavedBikeProfilesPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.profileSetting,
        name: 'profileSetting',
        builder: (context, state) => const ProfileSettingPage(),
      ),
      GoRoute(
        path: AppRoutes.testRiderProgram,
        name: 'testRiderProgram',
        builder: (context, state) => const TestRiderProgramPage(),
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
