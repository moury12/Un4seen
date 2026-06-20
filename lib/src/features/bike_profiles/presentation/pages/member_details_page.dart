import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:un4seen/src/features/profile/data/models/user_profile_model.dart';
import '../../../../core/core_export.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../widgets/syndicate_journey_widget.dart';
import '../widgets/about_me_widget.dart';
import '../widgets/connect_section_widget.dart';
import '../widgets/bike_profile_tile_widget.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

class MemberDetailsPage extends StatelessWidget {
  final String userId;

  const MemberDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    // Fetch fresh details for this specific user on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMemberDetails(userId);
    });

    // Colors based on your design
    const Color cardBg = AppColors.kPrimaryDarkColor3;
    const Color highlightBlue = AppColors.kPrimaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStaticStrings.details.tr),
        
      ),
      body: SafeArea(
        child: Obx(() {
          // 1. Show loading state
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = controller.targetMemberDetails.value;

          // 2. Handle empty/error state
          if (user == null) {
            return Center(child: CustomText("User details not found".tr));
          }

          // 3. Dynamic UI mapped to your design
          return RefreshIndicator(
            onRefresh: () => controller.fetchMemberDetails(userId),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppPadding.getPadding12H(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dynamic Header
                  ProfileHeaderWidget(
                    name: user.fullName ?? 'Unknown',
                    image: user.image ?? '',
                    location: user.country ?? '',
                    syndicateId: user.memberNumber ?? '',
                    memberType: user.role ?? 'Member',
                    points: user.shredPoints.toString(),
                    followers: user.followerCount.toString(),
                    following: user.followingCount.toString(),
                    isCurrentUser: false,
                    isFollowing: user.isFollowing,
                    userId: user.id,
                  ),
                  space8H,

                  // --- DYNAMIC SYNDICATE JOURNEY ---
                  _buildDynamicJourney(user, cardBg, highlightBlue),
                  space8H,

                  // --- DYNAMIC ABOUT ME ---
                  AboutMeWidget(
                    bgColor: cardBg,
                    // If aboutMe is empty, showing a default placeholder
                    aboutMe: user.aboutMe?.isNotEmpty == true
                        ? user.aboutMe!
                        : (user.createdAt != null
                              ? "Syndicate member since ${DateFormat.yMMMM().format(DateTime.parse(user.createdAt!))}"
                              : "Syndicate member"),
                  ),
                  space8H,

                  // --- CONNECT SECTION (Uses URLs from API) ---
                  ConnectSectionWidget(
                    bgColor: cardBg,
                    facebookUrl: user.facebookURL,
                    instagramUrl: user.instagramURL,
                    tiktokUrl: user.tiktokURL,
                  ),
                  space8H,

                  // --- BIKE PROFILE SECTION ---
                  BikeProfileTileWidget(
                    bgColor: cardBg,
                    accentColor: highlightBlue,
                    activeBike: user.activeBike,

                  ),
                  space8H,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Internal helper to handle the dynamic date string for the Journey widget
  Widget _buildDynamicJourney(UserProfileModel user, Color bg, Color accent) {
    return SyndicateJourneyWidget(
      bgColor: bg,
      accentColor: accent,
      journey: user.journey,
    );
  }
}
