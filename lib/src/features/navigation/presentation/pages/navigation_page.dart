import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';

import '../controllers/navigation_controller.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../competitions/presentation/pages/competitions_page.dart';
import '../../../giveaway/presentation/pages/giveaway_page.dart';
import '../../../points/presentation/pages/points_page.dart';
import '../../../stories/presentation/pages/stories_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class NavigationPage extends GetView<NavigationController> {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const CompetitionsPage(),
      const GiveawayPage(),
      const PointsPage(),
      const StoriesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex]),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: 80,
          decoration: const BoxDecoration(color: AppColors.kPrimaryDarkColor2),
          child: Row(
            children: [
              _buildNavItem(0, AppIcons.home, AppStaticStrings.home, context),
              _buildNavItem(
                1,
                AppIcons.reward,
                AppStaticStrings.competitions,
                context,
              ),
              _buildNavItem(
                2,
                AppIcons.pointsEarned,
                AppStaticStrings.giveaway,
                context,
              ),
              _buildNavItem(
                3,
                AppIcons.badge,
                AppStaticStrings.points,
                context,
              ),
              _buildNavItem(
                4,
                AppIcons.camera,
                AppStaticStrings.stories,
                context,
              ),
              _buildNavItem(
                5,
                AppIcons.person,
                AppStaticStrings.profile,
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    String icon,
    String label,
    BuildContext context,
  ) {
    return Expanded(
      child: Obx(() {
        final isSelected = controller.currentIndex == index;
        return ButtonTapWidget(
          onTap: () => controller.changeIndex(index),
          child: Container(
            decoration: isSelected
                ? const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.kPrimaryColor,
                        AppColors.kPrimaryDarkColor,
                      ],
                    ),
                  )
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 24,
                ),
                if (isSelected) ...[
                  const SizedBox(height: 4),
                  AutoSizeText(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    maxFontSize: 13,
                    minFontSize: 9,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.kWhiteTextColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
