import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/core_export.dart';
import '../../../../core/widgets/gradient_container.dart';
import '../../../profile/presentation/widgets/point_blance_card_widget.dart';
import '../widgets/points_action_card.dart';
import '../widgets/social_share_tile.dart';


class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStaticStrings.shredPoints.tr, ),
      ),
      body: ListView(
        padding: AppPadding.getPadding12H(context),
        physics: const BouncingScrollPhysics(),
        children: [
          CustomText(AppStaticStrings.earnPointsUnlockRewards.tr, color: AppColors.kSecondaryTextColor, fontSize: 12),
          space8H,
          const PointsBalanceCardWidget(),
          space8H,

          // Daily Login Card
          GradientContainer(
            gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
            child: Column(
              children: [
                CustomText(AppStaticStrings.dailyLoginRedeem.tr, color: Colors.white, fontWeight: FontWeight.bold),
                space8H,
                  CustomButton(text: AppStaticStrings.claimLoginPoints.tr, onPressed: () {}, backgroundColor: Colors.white.withValues(alpha: 0.2)),
              ],
            ),
          ),
          space8H,

          CustomText(AppStaticStrings.earnPoints.tr, variant: TextVariant.headlineSmall,
           fontWeight: FontWeight.bold),
          CustomText(AppStaticStrings.stackShredPoints.tr, fontSize: 12, color: AppColors.kSecondaryTextColor),
          space8H,

          // Share Card
          GradientContainer(
            gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.share, color: Colors.white, size: 18),
                    space8W,
                    CustomText(AppStaticStrings.shareUn4seen.tr, color: Colors.white, fontWeight: FontWeight.bold,variant: TextVariant.labelLarge,),
                  ],
                ),
                space8H,
                CustomText(AppStaticStrings.createPostSocial.tr, color: Colors.white, fontSize: 10),
                space8H,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _socialBtn(AppIcons.fb, "Facebook"),
                    _socialBtn(AppIcons.ig, "Instagram"),
                    _socialBtn(AppIcons.tictok, "TikTok"),
                  ],
                )
              ],
            ),
          ),
          space8H,

          PointsActionCard(
            title: AppStaticStrings.completeYourProfile.tr,
            subtitle: "+100 points",
            icon: AppIcons.statics,
            trailing: const Icon(Icons.check_circle_outline, color: Colors.white),
          ),
          PointsActionCard(
            title: AppStaticStrings.referralBonus.tr,
            subtitle: AppStaticStrings.referralBonusDesc.tr,
            icon: AppIcons.share,
          ),
          space8H,

          CustomText(AppStaticStrings.followLikeSocials.tr, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold),
          space8H,
          SocialShareTile(title: AppStaticStrings.shareOnFacebook.tr, subtitle: AppStaticStrings.earn100Points.tr, icon: AppIcons.fb, points: "100"),
          SocialShareTile(title: AppStaticStrings.shareOnInstagram.tr, subtitle: AppStaticStrings.earn100Points.tr, icon: AppIcons.ig, points: "100"),
          SocialShareTile(title: AppStaticStrings.shareOnTikTok.tr, subtitle: AppStaticStrings.earn100Points.tr, icon: AppIcons.tictok, points: "100"),
          space8H,

          // Scholarship/Info Section
          _infoCard(AppStaticStrings.scholarshipTitle.tr, AppStaticStrings.scholarshipDesc.tr),
          space8H,
          _infoCard(AppStaticStrings.resilienceSupportTitle.tr, AppStaticStrings.resilienceSupportDesc.tr),
          // space8H,

          // const MilestoneProgressCard(),
          // space8H,

          // CustomText(AppStaticStrings.milestoneRewards.tr, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold),
          // space8H,
          // _milestoneRewardTile(AppIcons.reward, AppStaticStrings.stickerPack.tr, AppStaticStrings.points1000.tr),
          // _milestoneRewardTile(AppIcons.reward, AppStaticStrings.tShirt.tr, AppStaticStrings.points2500.tr),
          // space8H,

          // CustomText(AppStaticStrings.recentActivity.tr, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold),
          // space8H,
          // const ActivityLogTile(title: "Profile completed", date: "4/20/2026", points: "100"),
          // const ActivityLogTile(title: "Shared on Instagram", date: "4/21/2026", points: "200"),
          // const ActivityLogTile(title: "Bike of the Week winner 🏆", date: "4/24/2026", points: "500"),
          // space24H,
        ],
      ),
    );
  }

  Widget _socialBtn(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          SvgPicture.asset(icon, height: 24),
          space4H,
          CustomText(label, color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String desc) {
    return GradientContainer(
      gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title, color: Colors.white, fontWeight: FontWeight.bold),
          space8H,
          CustomText(desc, color: Colors.white70, fontSize: 10),
          space8H,
          CustomButton(text: AppStaticStrings.moreInfoSoon.tr, onPressed: () {}, backgroundColor: const Color(0xFF001F2D), borderRadius: 20),
        ],
      ),
    );
  }

  Widget _milestoneRewardTile(String icon, String title, String points) {
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
      child: Row(
        children: [
          SvgPicture.asset(icon, height: 24, colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
          space12W,
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CustomText(title, color: Colors.white, fontWeight: FontWeight.bold),
              CustomText(points, color: Colors.white70, fontSize: 10),
            ]),
          ),
          CustomButton(text: "Claim", onPressed: () {}, isExpanding: false, borderRadius: 20),
        ],
      ),
    );
  }
}
