import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/features/auth/presentation/auth_presentation_export.dart';
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

    return CustomScaffold(
      // isPaddingNeeded: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await profileCtrl.fetchProfile();
          },
          child: SingleChildScrollView(
            padding: AppPadding.getPadding12H(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => ProfileHeaderWidget(
                    name: profileCtrl.userProfile.value.fullName ?? 'Unknown',
                    image: 'https://i.pravatar.cc/150?img=11',
                    location:
                        '${profileCtrl.cityController.text}, ${profileCtrl.stateController.text}',
                    syndicateId: profileCtrl.memberNumber.value,
                    memberType: 'Exclusive Syndicate Member',
                    points: profileCtrl.shredPoints.value.toString(),
                    followers: profileCtrl.followerCount.value.toString(),
                    following: profileCtrl.followingCount.value.toString(),
                    isCurrentUser: true,
                  ),
                ),
                space4H,
                // ── Points balance card ───────────────────
                const PointsBalanceCardWidget(),

                space8H,

                // ── Menu tiles ────────────────────────────
                ProfileMenuTile(
                  title: AppStaticStrings.myOrders,
                  icon: AppIcons.cell,
                  onTap: () => context.push(AppRoutes.orders),
                ),
                ProfileMenuTile(
                  title: AppStaticStrings.manageSubscription,
                  icon: AppIcons.subscription,
                  onTap: () => context.push(AppRoutes.subscription),
                ),
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
