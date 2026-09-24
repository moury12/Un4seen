import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/features/auth/presentation/auth_presentation_export.dart';
import 'package:un4seen/src/features/profile/presentation/controllers/un4seen_updates_controller.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/point_blance_card_widget.dart';
import '../../../../core/core_export.dart';
import '../widgets/profile_menu_tile.dart';
import '../widgets/profile_header_widget.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AuthController>();

    final profileCtrl = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());

    final updatesCtrl = Get.isRegistered<Un4seenUpdatesController>()
        ? Get.find<Un4seenUpdatesController>()
        : Get.put(Un4seenUpdatesController(), permanent: true);

    return CustomScaffold(
      // isPaddingNeeded: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              profileCtrl.fetchProfile(),
              updatesCtrl.fetchAnnouncements(isRefresh: true),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppPadding.getPadding12H(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => ProfileHeaderWidget(
                    name: profileCtrl.userProfile.value.fullName ?? 'Unknown',
                    image: profileCtrl.userProfile.value.profilePicture ?? "",
                    location:
                        '${profileCtrl.cityController.text}, ${profileCtrl.stateController.text}',
                    syndicateId: profileCtrl.memberNumber.value,
                    memberType: 'Exclusive Syndicate Member',
                    points: profileCtrl.shredPoints.value.toString(),
                    followers: profileCtrl.followerCount.value.toString(),
                    following: profileCtrl.followingCount.value.toString(),
                    isCurrentUser: true,
                    userId: profileCtrl.userProfile.value.id,
                    onProfileTap: () {
                      final userId = profileCtrl.userProfile.value.id;
                      if (userId != null && userId.isNotEmpty) {
                        context.push(AppRoutes.memberDetails, extra: userId);
                      }
                    },
                  ),
                ),
                space4H,
                // ── Points balance card ───────────────────
                Obx(
                  () => PointsBalanceCardWidget(
                    point: profileCtrl.shredPoints.value.toString(),
                  ),
                ),

                space8H,

                // ── Menu tiles ────────────────────────────
                Obx(
                  () => ProfileMenuTile(
                    title: AppStaticStrings.un4seenUpdates.tr,
                    iconWidget: const Icon(
                      Icons.campaign,
                      color: AppColors.kPrimaryColor,
                      size: 24,
                    ),
                    showBadge: updatesCtrl.hasUnreadUpdates.value,
                    onTap: () => context.push(AppRoutes.un4seenUpdates),
                  ),
                ),
                ProfileMenuTile(
                  title: AppStaticStrings.myOrders,
                  icon: AppIcons.cell,
                  onTap: () => context.push(AppRoutes.orders),
                ),
                ProfileMenuTile(
                  title: AppStaticStrings.referAndEarn.tr,
                  icon: AppIcons.share,
                  onTap: () => context.push(AppRoutes.referAndEarn),
                ),
                // ProfileMenuTile(
                //   title: AppStaticStrings.manageSubscription,
                //   icon: AppIcons.subscription,
                //   onTap: () => context.push(AppRoutes.subscription),
                // ),
                ProfileMenuTile(
                  title: AppStaticStrings.savedStories,
                  icon: AppIcons.bookmark,
                  onTap: () => context.push(AppRoutes.savedStories),
                ),
                ProfileMenuTile(
                  title: AppStaticStrings.savedBikeProfiles,
                  icon: AppIcons.bookmark,
                  onTap: () => context.push(AppRoutes.bikeProfiles),
                ),
                ProfileMenuTile(
                  title: AppStaticStrings.testRider,
                  icon: AppIcons.ride,
                  onTap: () => context.push(AppRoutes.testRiderProgram),
                ),

                const SizedBox(height: 8),

                // ── Log Out button ────────────────────────
                CustomButton(
                  isOutlined: true,
                  textColor: AppColors.kRedColor,
                  borderColor: AppColors.kRedColor,
                  text: AppStaticStrings.logOut.tr,
                  onPressed: () => ctrl.logout(),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
