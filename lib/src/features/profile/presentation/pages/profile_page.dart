import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/core/widgets/custom_shape.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/point_blance_card_widget.dart';
import '../../../../core/core_export.dart';
import '../widgets/profile_menu_tile.dart';
import '../widgets/profile_header_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // isPaddingNeeded: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeaderWidget(
                name: 'Nahid Hossain',
                image: 'https://i.pravatar.cc/150?img=11',
                location: 'Los Angeles, CA  •  MX',
                syndicateId: '#SYN-2847',
                memberType: 'Exclusive Syndicate Member',
                points: '3890',
                followers: '342',
                following: '156',
                isCurrentUser: true,
              ),
              space4H,
              // ── Points balance card ───────────────────
              PointsBalanceCardWidget(),

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
                text: AppStaticStrings.logOut,
                onPressed: () => _showLogoutDialog(context),

                // onPressed: () => showDialog(
                //   context: context,
                //   builder: (context) => const LogoutDialog(),
                // ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.kPrimaryColor, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 50, color: AppColors.kPrimaryColor),
            const SizedBox(height: 16),
            Text(
              AppStaticStrings.logOut.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStaticStrings.areYouSureLogout.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.no.tr,
                    backgroundColor: Colors.transparent,
                    borderColor: Colors.grey,
                    textColor: Colors.white,
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.yes.tr,
                    onPressed: () {
                      // TODO: Implement logout logic
                      Get.back(); // Close dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out successfully')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

}
