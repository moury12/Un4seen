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
    final homeController = Get.find<HomeController>();

    return CustomScaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Obx(() {
            return CustomNetworkImage(
              height: 40,
              width: 40,
              imageUrl: homeController.homeFeedData.value?.user?.image ?? "",
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
                homeController.homeFeedData.value?.user?.fullName ??
                    "Loading...",
                fontWeight: FontWeight.bold,
                fontSize: 16,
              );
            }),
            Obx(() {
              final isSyndicate =
                  homeController.homeFeedData.value?.user?.isSyndicateMember ??
                  false;
              if (!isSyndicate) return const SizedBox.shrink();
              return Row(
                spacing: 6,
                children: [
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
                      profileController.userProfile.value.memberNumber
                          .toString(),
                      color: Colors.white,
                      variant: TextVariant.labelSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00A6FF), Color(0xFF0066CC)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CustomText(
                        isSyndicate
                            ? AppStaticStrings.exclusiveSyndicateMember.tr
                            : "Guest Member",
                        color: Colors.white,
                        variant: TextVariant.labelSmall,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
        actions: [
          ButtonTapWidget(
            onTap: () {
              context.push(AppRoutes.notification);
            },
            child: Container(
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
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await homeController.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppPadding.getPadding12(context),
            child: Obx(() {
              if (homeController.isLoading.value) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: double.infinity,
                  child: _buildShimmerLoading(),
                );
              }

              final homeData = homeController.homeFeedData.value;
              if (homeData == null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: const Center(child: Text("No data available")),
                );
              }

              return Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeaderWidget(),
                  // We still use giveawayController for currentWeekly as requested
                  Obx(() {
                    if (giveawayController.isLoading.value) {
                      return _shimmerBox(
                        height: 120,
                        width: double.infinity,
                        color: AppColors.kPrimaryDarkColor.withValues(
                          alpha: 0.3,
                        ),
                      );
                    }
                    final gData = giveawayController.pageData.value;
                    if (gData == null || gData.currentWeekly == null)
                      return const SizedBox.shrink();
                    return WeeklyPrizeCardWidget(
                      giveaway: gData.currentWeekly!,
                    );
                  }),

                  const QuickActionRowWidget(),
                  const BikeOfTheWeekWidget(),

                  CustomButton(
                    text: AppStaticStrings.rateMyRide.tr,
                    onPressed: () => context.push(AppRoutes.rateMyRide),
                    rightIcon: Icons.chevron_right,
                    backgroundColor: AppColors.kPrimaryDarkColor3,
                  ),

                  if (homeData.majorGiveaway != null)
                    MajorGiveawayCardWidget(giveaway: homeData.majorGiveaway!),

                  if (homeData.recentWinners.isNotEmpty) ...[
                    CustomText(
                      AppStaticStrings.recentWeeklyWinners.tr,
                      variant: TextVariant.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    ...homeData.recentWinners.map(
                      (winner) => WeeklyWinnerCardWidget(
                        week: "WEEK ${winner.weekNumber} WINNER",
                        name: winner.winner?.fullName ?? "",
                        prize: winner.title,
                        image:
                            winner.winner?.image ?? "https://i.pravatar.cc/150",
                        onTap: () {
                          context.push(
                            AppRoutes.memberDetails,
                            extra: winner.winner?.id,
                          );
                        },
                      ),
                    ),
                  ],

                  if (homeData.thisWeekStats != null) ...[
                    CustomText(
                      AppStaticStrings.thisWeek.tr,
                      variant: TextVariant.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    ActivitySummaryTileWidget(
                      icon: AppIcons.badge,
                      title:
                          "+${homeData.thisWeekStats!.pointsEarned} points earned",
                      subtitle: AppStaticStrings.keepShredding.tr,
                    ),
                    ActivitySummaryTileWidget(
                      icon: AppIcons.camera,
                      title:
                          "${homeData.thisWeekStats!.newStoriesPosted} ${AppStaticStrings.newStoriesPosted.tr}",
                      subtitle: AppStaticStrings.checkOutLatestStories.tr,
                    ),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    final Color baseColor = AppColors.kPrimaryDarkColor.withValues(alpha: 0.3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerBox(height: 100, width: double.infinity, color: baseColor),
        space8H,
        _shimmerBox(
          height: 140,
          width: double.infinity,
          borderRadius: 20,
          color: baseColor,
        ),
        space12H,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _shimmerBox(
              height: 60,
              width: 80,
              borderRadius: 12,
              color: baseColor,
            ),
            _shimmerBox(
              height: 60,
              width: 80,
              borderRadius: 12,
              color: baseColor,
            ),
            _shimmerBox(
              height: 60,
              width: 80,
              borderRadius: 12,
              color: baseColor,
            ),
            _shimmerBox(
              height: 60,
              width: 80,
              borderRadius: 12,
              color: baseColor,
            ),
          ],
        ),
        space12H,
        _shimmerBox(
          height: 200,
          width: double.infinity,
          borderRadius: 16,
          color: baseColor,
        ),
        space12H,
        _shimmerBox(
          height: 50,
          width: double.infinity,
          borderRadius: 12,
          color: baseColor,
        ),
        space12H,
        _shimmerBox(
          height: 250,
          width: double.infinity,
          borderRadius: 16,
          color: baseColor,
        ),
      ],
    );
  }

  Widget _shimmerBox({
    required double height,
    required double width,
    double borderRadius = 8,
    required Color color,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
