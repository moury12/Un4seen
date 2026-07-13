import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/utils/app_strings.dart';
import 'package:un4seen/src/features/bike_profiles/bike_profiles_export.dart';
import 'package:un4seen/src/features/bike_profiles/presentation/pages/members_page.dart';
import 'package:un4seen/src/features/chat/presentation/pages/search_chat_page.dart';
import 'package:un4seen/src/features/competitions/presentation/pages/entries_gallery_page.dart';
import 'package:un4seen/src/features/home/presentation/pages/notification_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/email_confirmation_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/profile/presentation/pages/setup_profile_page.dart';
import '../../features/profile/presentation/pages/setup_ride_page.dart';
import '../../features/navigation/presentation/pages/navigation_page.dart';
import '../../features/orders/presentation/pages/orders_page.dart';
import '../../features/subscription/presentation/pages/subscription_page.dart';
import '../../features/stories/presentation/pages/saved_stories_page.dart';
import '../../features/bike_profiles/presentation/pages/saved_bike_profiles_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/profile_setting_page.dart';
import '../../features/profile/presentation/pages/test_rider_program_page.dart';
import '../../features/stories/presentation/pages/story_full_page.dart';
import '../../features/profile/presentation/pages/change_password_page.dart';
import '../../features/profile/presentation/pages/refer_and_earn_page.dart';
import '../../features/profile/presentation/pages/about_us_page.dart';
import '../../features/profile/presentation/pages/privacy_policy_page.dart';
import '../../features/profile/presentation/pages/terms_and_conditions_page.dart';
import '../../features/bike_profiles/presentation/pages/my_bike_profile_page.dart';
import '../../features/bike_profiles/presentation/pages/bike_gallery_page.dart';
import '../../features/bike_profiles/presentation/pages/add_new_bike_page.dart';
import '../../features/bike_profiles/presentation/pages/single_bike_details_page.dart';
import '../../features/bike_profiles/presentation/pages/member_details_page.dart';
import '../../features/stories/presentation/pages/post_story_page.dart';
import '../../features/home/presentation/pages/ideas_feedback_page.dart';
import '../../features/home/presentation/pages/crew_choice_page.dart';
import '../../features/home/presentation/pages/un4seen_world_page.dart';
import '../../features/home/presentation/pages/rate_my_ride_page.dart';
import '../../features/home/presentation/pages/my_rides_page.dart';
import '../../features/home/presentation/pages/shop_page.dart';
import '../../features/chat/presentation/pages/channels_page.dart';
import '../../features/chat/presentation/pages/all_channels_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/channel_members_page.dart';
import '../../features/chat/presentation/pages/builds_mods_page.dart';

class AppRouter {
  AppRouter._();
static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    navigatorKey: Get.key,
    
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
      // GoRoute(
      //   path: AppRoutes.register,
      //   name: 'register',
      //   builder: (context, state) => const RegisterPage(),
      // ),
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
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ResetPasswordPage(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.setupProfile,
        name: 'setupProfile',
        builder: (context, state) => const SetupProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.setupRide,
        name: 'setupRide',
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          return SetupRidePage(
            country: extraData?['country'] ?? '',
            dob: extraData?['dob'] ?? '',
          );
        },
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
        builder: (context, state) => ProfileSettingPage(),
      ),
      GoRoute(
        path: AppRoutes.testRiderProgram,
        name: 'testRiderProgram',
        builder: (context, state) => const TestRiderProgramPage(),
      ),
      GoRoute(
        path: AppRoutes.storyFull,
        name: 'storyFull',
        builder: (context, state) {
          int initialIndex = 0;
          bool isFromSaved = false;
          if (state.extra is int) {
            initialIndex = state.extra as int;
          } else if (state.extra is Map) {
            final args = state.extra as Map;
            initialIndex = args['initialIndex'] as int? ?? 0;
            isFromSaved = args['isFromSaved'] as bool? ?? false;
          }
          return StoryFullPage(
            initialIndex: initialIndex,
            isFromSaved: isFromSaved,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        name: 'changePassword',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.referAndEarn,
        name: 'referAndEarn',
        builder: (context, state) => const ReferAndEarnPage(),
      ),
      GoRoute(
        path: AppRoutes.aboutUs,
        name: 'aboutUs',
        builder: (context, state) => const AboutUsPage(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        name: 'privacyPolicy',
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: AppRoutes.termsAndConditions,
        name: 'termsAndConditions',
        builder: (context, state) => const TermsAndConditionsPage(),
      ),
      GoRoute(
        path: AppRoutes.myBikeProfile,
        name: 'myBikeProfile',
        builder: (context, state) => const MyBikeProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.bikeGallery,
        name: 'bikeGallery',
        builder: (context, state) {
          final bikeId = state.extra as String? ?? '';
          return BikeGalleryPage(bikeId: bikeId);
        },
      ),
      GoRoute(
        path: AppRoutes.addNewBike,
        name: 'addNewBike',
        builder: (context, state) {
          final bike = state.extra as BikeModel?;
          return AddNewBikePage(bikeToEdit: bike);
        },
      ),
      GoRoute(
        path: '${AppRoutes.singleBikeDetails}/:id',
        name: 'singleBikeDetails',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
           final extra = state.extra as Map<String, dynamic>;
           final fromMember = extra['fromMember'] ?? false;
          return SingleBikeDetailsPage(bikeId: id, fromMember: fromMember);
        },
      ),
      GoRoute(
        path: AppRoutes.postStory,
        name: 'postStory',
        builder: (context, state) => PostStoryPage(),
      ),
   GoRoute(
        path: AppRoutes.notification,
        name: 'notification',
        builder: (context, state) => const NotificationsPage(),
      ),
      // Add this inside the routes list
      GoRoute(
        path: AppRoutes.entriesGallery,
        name: 'entriesGallery',
        builder: (context, state) => const EntriesGalleryPage(),
      ),
      GoRoute(
        path: AppRoutes.ideasFeedback,
        name: 'ideasFeedback',
        builder: (context, state) => const IdeasFeedbackPage(),
      ),
      GoRoute(
        path: AppRoutes.crewChoice,
        name: 'crewChoice',
        builder: (context, state) => const CrewChoicePage(),
      ),
      GoRoute(
        path: AppRoutes.un4seenWorld,
        name: 'un4seenWorld',
        builder: (context, state) => const Un4seenWorldPage(),
      ),
      GoRoute(
        path: AppRoutes.rateMyRide,
        name: 'rateMyRide',
        builder: (context, state) => const RateRidePage(),
      ),
      GoRoute(
        path: AppRoutes.myRides,
        name: 'myRides',
        builder: (context, state) => const MyRidesPage(),
      ),
      GoRoute(
        path: AppRoutes.shop,
        name: 'shop',
        builder: (context, state) => const ShopPage(),
      ),
      GoRoute(
        path: AppRoutes.channels,
        name: 'channels',
        builder: (context, state) => const ChannelsPage(),
      ),
      GoRoute(
        path: AppRoutes.allChannels,
        name: 'allChannels',
        builder: (context, state) => const AllChannelsPage(),
      ),
      GoRoute(
        path: AppRoutes.buildsMods,
        name: 'buildsMods',
        builder: (context, state) {
           final extra = state.extra as Map<String, dynamic>;

          return BuildsModsPage(
            channelId: extra['channelId']??"",
            channelName: extra['channelName']??"",
          );
        },
      ),
      GoRoute(
        path: AppRoutes.chatSearch,
        name: 'chatSearch',
        builder: (context, state) => const SearchChatPage(),
      ),
      // Generic List Route
GoRoute(
  path: AppRoutes.members,
        name: 'members',
  builder: (context, state) {
    final extra = state.extra as Map<String, dynamic>;
    return MembersPage(
      title: extra['title'],
      users: extra['list'],
      onRefresh: extra['refresh'],
    );
  },
),

// Member Details updated to use ID
GoRoute(
  path: AppRoutes.memberDetails,
  name: 'memberDetails',
  builder: (context, state) {
    final userId = state.extra as String;
    return MemberDetailsPage(userId: userId);
  },
),
      GoRoute(
        path: AppRoutes.chat,
        name: 'chat',
        builder: (context, state) {
          final extra = state.extra;
          final args = extra is ChatPageArgs
              ? extra
              : ChatPageArgs.channel(
                  id: '',
                  title: extra as String? ?? AppStaticStrings.chat,
                );
          return ChatPage(args: args);
        },
      ),
      GoRoute(
        path: AppRoutes.channelMembers,
        name: 'channelMembers',
        builder: (context, state) {
          final channelId = state.extra as String? ?? '';
          return ChannelMembersPage(channelId: channelId);
        },
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
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Route not found: ${state.uri}'))),

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
