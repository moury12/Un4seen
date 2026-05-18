import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/core/widgets/logout_dialog.dart';
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
                text: AppStaticStrings.logOut.tr,
                onPressed: () => context.go(AppRoutes.login),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
