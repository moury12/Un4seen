import 'package:un4seen/src/core/widgets/custom_scaffold.dart';
import 'package:un4seen/src/features/home/presentation/widgets/activity_summary_tile_widget.dart';
import 'package:un4seen/src/features/home/presentation/widgets/bike_of_the_week_widget.dart';
import 'package:un4seen/src/features/home/presentation/widgets/quick_action_row_widget.dart';
import 'package:un4seen/src/features/home/presentation/widgets/weekly_winner_card_widget.dart';

import '../../../../src_export.dart';

import '../widgets/home_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final giveawayController = Get.find<GiveawayController>();
    final profileController = Get.find<ProfileController>();
    return CustomScaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Obx(() {
            return CustomNetworkImage(
              height: 40,
              width: 40,

              imageUrl:
                  profileController.userProfile.value.profilePicture ?? "",
              boxShape: BoxShape.circle,
            );
          }),
        ),

        centerTitle: false,
        title: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return CustomText(
                profileController.userProfile.value.fullName ??
                    "no data provided",
                fontWeight: FontWeight.bold,
                fontSize: 16,
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomText(
                AppStaticStrings.exclusiveSyndicateMember.tr,
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),

            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.kPrimaryColor.withValues(alpha: .8),
                  AppColors.kPrimaryDarkColor,
                ],
              ),
              borderRadius: BorderRadius.circular(appRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.kTextColor.withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeaderWidget(),
              // space8H,
              Obx(() {
                if (giveawayController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = giveawayController.pageData.value;
                if (data == null || data.currentWeekly == null)
                  return const SizedBox.shrink();
                return WeeklyPrizeCardWidget(giveaway: data.currentWeekly!);
              }),

              // space8H,
              const QuickActionRowWidget(),
              // space8H,
              const BikeOfTheWeekWidget(),
              // space12H,
              CustomButton(
                text: AppStaticStrings.rateMyRide.tr,
                onPressed: () => context.push(AppRoutes.rateMyRide),
                rightIcon: Icons.chevron_right,
                backgroundColor: AppColors.kPrimaryDarkColor3,
              ),

              Obx(() {
                if (giveawayController.isLoading.value) {
                  return const SizedBox.shrink();
                }
                final data = giveawayController.pageData.value;
                if (data == null || data.majorGiveaways.isEmpty)
                  return const SizedBox.shrink();
                return MajorGiveawayCardWidget(
                  giveaway: data.majorGiveaways.first,
                );
              }),
              // space24H,
              CustomText(
                AppStaticStrings.recentWeeklyWinners.tr,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),
              // space12H,
              const WeeklyWinnerCardWidget(
                week: "WEEK 17 WINNER",
                name: "Jake Thompson 🇺🇸",
                prize: "Premium Decal Kit + T-Shirt",
                image: "https://i.pravatar.cc/150?img=12",
              ),
              const WeeklyWinnerCardWidget(
                week: "WEEK 16 WINNER",
                name: "Sarah Martinez 🇨🇦",
                prize: "Custom Grip Tape Set",
                image: "https://i.pravatar.cc/150?img=25",
              ),
              // const WeeklyWinnerCardWidget(week: "WEEK 15 WINNER", name: "Alex Rivera 🇲🇽", prize: "Syndicate Sticker Pack", image: "https://i.pravatar.cc/150?img=33"),
              // space24H,
              CustomText(
                AppStaticStrings.thisWeek.tr,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),
              // space12H,
              ActivitySummaryTileWidget(
                icon: AppIcons.badge,
                title: "+500 points earned",
                subtitle: AppStaticStrings.keepShredding.tr,
              ),
              ActivitySummaryTileWidget(
                icon: AppIcons.camera,
                title: AppStaticStrings.newStoriesPosted.tr,
                subtitle: AppStaticStrings.checkOutLatestStories.tr,
              ),
              // space24H,
            ],
          ),
        ),
      ),
    );
  }
}
