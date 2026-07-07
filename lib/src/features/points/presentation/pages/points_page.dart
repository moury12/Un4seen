import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/core/utils/url_launcher_utils.dart';
import 'package:un4seen/src/features/points/points_export.dart';
import 'package:un4seen/src/features/points/presentation/widgets/activity_log_tile.dart';
import 'package:un4seen/src/features/points/presentation/widgets/milestone_progress_card.dart';
import 'package:un4seen/src/features/points/presentation/widgets/milestone_reward.dart';
import 'package:un4seen/src/features/points/presentation/widgets/points_shimmer_loading.dart';
import '../../../../core/core_export.dart';
import '../../../../core/widgets/gradient_container.dart';
import '../../../profile/presentation/widgets/point_blance_card_widget.dart';
import '../widgets/points_action_card.dart';
import '../widgets/social_share_tile.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  final TextEditingController _platformCtrl = TextEditingController();
  final TextEditingController _postLinkCtrl = TextEditingController();

  @override
  void dispose() {
    _platformCtrl.dispose();
    _postLinkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PointsController());

    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.shredPoints.tr)),
      body: RefreshIndicator(
        onRefresh: controller.fetchDashboard,
        child: Obx(() {
          final data = controller.dashboardData.value;
          final bool isInitialLoading =
              controller.isLoading.value && data == null;

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),

            slivers: [
              if (isInitialLoading)
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: const SliverToBoxAdapter(
                    child: PointsShimmerLoading(),
                  ),
                )
              else if (data == null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_off,
                          size: 48,
                          color: AppColors.kSecondaryTextColor.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        space12H,
                        CustomText("Failed to load points".tr),
                      ],
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      CustomText(
                        AppStaticStrings.earnPointsUnlockRewards.tr,
                        color: AppColors.kSecondaryTextColor,
                        fontSize: 12,
                      ),
                      space8H,
                      PointsBalanceCardWidget(
                        point: data.userStats.totalPoints.toString(),
                      ),
                      space8H,

                      // Daily Login Card
                      if (data.dailyLogin.canClaimDaily)
                        GradientContainer(
                          gradientColors: const [
                            AppColors.kPrimaryDarkColor,
                            AppColors.kPrimaryColor,
                          ],
                          child: Column(
                            children: [
                              CustomText(
                                AppStaticStrings.dailyLoginRedeem.tr,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              space8H,
                              CustomButton(
                                text: AppStaticStrings.claimLoginPoints.tr,
                                onPressed: controller.claimDaily,
                                backgroundColor: Colors.white.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      space8H,

                      CustomText(
                        AppStaticStrings.earnPoints.tr,
                        variant: TextVariant.headlineSmall,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        AppStaticStrings.stackShredPoints.tr,
                        fontSize: 12,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      space8H,

                      // Share Card
                      GradientContainer(
                        gradientColors: const [
                          AppColors.kPrimaryDarkColor,
                          AppColors.kPrimaryColor,
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                space8W,
                                CustomText(
                                  AppStaticStrings.shareUn4seen.tr,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  variant: TextVariant.labelLarge,
                                ),
                              ],
                            ),
                            space8H,
                            CustomText(
                              AppStaticStrings.createPostSocial.tr,
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            space8H,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _socialBtn(AppIcons.fb, "Facebook"),
                                _socialBtn(AppIcons.ig, "Instagram"),
                                _socialBtn(AppIcons.tictok, "TikTok"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      space8H,

                      PointsActionCard(
                        title: AppStaticStrings.completeYourProfile.tr,
                        subtitle: "+100 points",
                        icon: AppIcons.statics,
                        trailing:
                            data.profileCompletion.isClaimed ||
                                !data.profileCompletion.isComplete
                            ? data.profileCompletion.isClaimed
                                  ? const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                    )
                                  : null
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ButtonTapWidget(
                                  onTap: () {
                                    controller.claimProfileBonus();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(
                                      AppStaticStrings.claim.tr,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.kPrimaryDarkColor3,
                                      variant: TextVariant.labelLarge,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.referAndEarn),
                        child: PointsActionCard(
                          title: AppStaticStrings.referralBonus.tr,
                          subtitle: AppStaticStrings.referralBonusDesc.tr,
                          icon: AppIcons.share,
                        ),
                      ),
                      space8H,

                      CustomText(
                        AppStaticStrings.followLikeSocials.tr,
                        variant: TextVariant.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      space8H,
                      SocialShareTile(
                        onTap: () {
                          UrlLauncherUtils.launchExternalUrl(
                            UrlLauncherUtils.facebookUrl,
                          );
                        },
                        title: AppStaticStrings.shareOnFacebook.tr,
                        subtitle: AppStaticStrings.earn100Points.tr,
                        icon: AppIcons.fb,
                        points: "100",
                      ),
                      SocialShareTile(
                        onTap: () {
                          UrlLauncherUtils.launchExternalUrl(
                            UrlLauncherUtils.instagramUrl,
                          );
                        },
                        title: AppStaticStrings.shareOnInstagram.tr,
                        subtitle: AppStaticStrings.earn100Points.tr,
                        icon: AppIcons.ig,
                        points: "100",
                      ),
                      SocialShareTile(
                        onTap: () {
                          UrlLauncherUtils.launchExternalUrl(
                            UrlLauncherUtils.tiktokUrl,
                          );
                        },
                        title: AppStaticStrings.shareOnTikTok.tr,
                        subtitle: AppStaticStrings.earn100Points.tr,
                        icon: AppIcons.tictok,
                        points: "100",
                      ),
                      space8H,

                      // Scholarship/Info Section
                      _infoCard(
                        AppStaticStrings.scholarshipTitle.tr,
                        AppStaticStrings.scholarshipDesc.tr,
                      ),
                      space8H,
                      _infoCard(
                        AppStaticStrings.resilienceSupportTitle.tr,
                        AppStaticStrings.resilienceSupportDesc.tr,
                      ),
                      space8H,

                      ...List.generate(data.communityMilestones.length, (
                        index,
                      ) {
                        final milestone = data.communityMilestones[index];
                        return MilestoneProgressCard(model: milestone);
                      }),
                      space8H,
                      CustomText(
                        AppStaticStrings.helpGrowGoogleReview.tr,
                        variant: TextVariant.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      space8H,
                      GestureDetector(
                        onTap: () {
                          UrlLauncherUtils.launchExternalUrl(
                            "https://maps.app.goo.gl/onunNcUsNmj7EJGn9",
                          );
                        },
                        child: _milestoneRewardTile(
                          AppIcons.google,

                          AppStaticStrings.storeCreditTitle.tr,
                          AppStaticStrings.reviewComplete.tr,
                          () {
                            showDialog(
                              context: context,
                              builder: (context) => SubmitProofDialog(
                                platformCtrl: _platformCtrl,
                                postLinkCtrl: _postLinkCtrl,
                                hint: "Google Review.",
                              ),
                            );
                          },
                        ),
                      ),

                      CustomText(
                        AppStaticStrings.milestoneRewards.tr,
                        variant: TextVariant.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      space8H,
                      ...List.generate(data.individualMilestones.length, (
                        index,
                      ) {
                        final reward = data.individualMilestones[index];
                        return MilestoneRewardWidget(data: reward);
                      }),

                      space8H,

                      CustomText(
                        AppStaticStrings.recentActivity.tr,
                        variant: TextVariant.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      space8H,
                      ...List.generate(data.recentActivity.length, (index) {
                        final log = data.recentActivity[index];
                        return ActivityLogTile(
                          title: log.description,
                          date: formatDate(log.updatedAt),
                          points: log.points.toString(),
                        );
                      }),

                      space24H,
                    ]),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _socialBtn(String icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ButtonTapWidget(
        onTap: () {
          if (label == "Facebook") {
            UrlLauncherUtils.launchExternalUrl(UrlLauncherUtils.facebookUrl);
          } else if (label == "Instagram") {
            UrlLauncherUtils.launchExternalUrl(UrlLauncherUtils.instagramUrl);
          } else if (label == "TikTok") {
            UrlLauncherUtils.launchExternalUrl(UrlLauncherUtils.tiktokUrl);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              SvgPicture.asset(icon, height: 24),
              space4H,
              CustomText(
                label,
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String title, String desc) {
    return GradientContainer(
      gradientColors: const [
        AppColors.kPrimaryDarkColor,
        AppColors.kPrimaryColor,
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title, color: Colors.white, fontWeight: FontWeight.bold),
          space8H,
          CustomText(desc, color: Colors.white70, fontSize: 10),
          space8H,
          CustomButton(
            text: AppStaticStrings.moreInfoSoon.tr,
            onPressed: () {},
            backgroundColor: const Color(0xFF001F2D),
            borderRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _milestoneRewardTile(
    String icon,
    String title,
    String points,
    VoidCallback? onTap,
  ) {
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      gradientColors: const [
        AppColors.kPrimaryDarkColor,
        AppColors.kPrimaryColor,
      ],
      child: Column(
        spacing: 8,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    CustomText(points, color: Colors.white70, fontSize: 12),
                  ],
                ),
              ),
              ButtonTapWidget(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomText(
                    AppStaticStrings.claim.tr,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: onTap,
              ),
              //  CustomButton(text: "Claim", onPressed: () {}, isExpanding: true, borderRadius: 20),
            ],
          ),
        ],
      ),
    );
  }
}
