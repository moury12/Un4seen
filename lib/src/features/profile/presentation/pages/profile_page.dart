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
              Row(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=11',
                      ),
                    ),
                  ),

                  // Name + flag
                  Expanded(
                    child: Column(
                      // spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            CustomText(
                              'Nahid Hossain',
                              fontSize: 18,
                              variant: TextVariant.headlineMedium,
                              fontWeight: FontWeight.bold,
                            ),

                            CustomText('🇺🇸', fontSize: 16),
                            Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.settings_outlined,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: AppPadding.getPadding4(context),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.kPrimaryColor,
                                AppColors.kPrimaryDarkColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(appRadius6),
                          ),
                          child: ButtonTapWidget(
                            radius: appRadius6,

                            child: Row(
                              spacing: 6,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(AppIcons.chat, height: 15),
                                CustomText(
                                  AppStaticStrings.messageUn4seen.tr,
                                  variant: TextVariant.labelSmall,
                                  color: AppColors.kWhiteTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        space4H,
                        Row(
                          spacing: 6,
                          children: [
                            // Grey pill
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomText(
                                '#SYN-2847',
                                color: Colors.white,
                                variant: TextVariant.labelSmall,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Blue gradient pill
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF00A6FF),
                                      Color(0xFF0066CC),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  'Exclusive Syndicate Member',
                                  color: Colors.white,
                                  variant: TextVariant.labelSmall,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        space4H,
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.kTextColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              'Los Angeles, CA  •  MX',
                              variant: TextVariant.labelMedium,
                            ),
                          ],
                        ),
                        space4H,
                        Row(
                          spacing: 5,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              AppIcons.pointsEarned,
                              height: 18,
                              width: 18,
                              colorFilter: const ColorFilter.mode(
                                AppColors.kTextColor,
                                BlendMode.srcIn,
                              ),
                            ),
                            _buildStat('3890', 'Points'),
                            _buildStatDivider(),
                            _buildStat('342', 'Followers'),
                            _buildStatDivider(),
                            _buildStat('156', 'Following'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
                onTap: () {},
              ),

              const SizedBox(height: 8),

              // ── Log Out button ────────────────────────
              CustomButton(
                isOutlined: true,
                textColor: AppColors.kRedColor,
                borderColor: AppColors.kRedColor,
                text: AppStaticStrings.logOut,
                onPressed: () => context.go(AppRoutes.login),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        CustomText(
          value,
          variant: TextVariant.labelMedium,
          color: AppColors.kTextColor,
          fontWeight: FontWeight.w600,
        ),

        CustomText(
          label,
          variant: TextVariant.labelSmall,
          color: AppColors.kSecondaryTextColor,
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 29,
      width: 1,
      color: Colors.black.withValues(alpha: 0.2),
    );
  }
}
