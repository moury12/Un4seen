import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class GiveawayPage extends StatelessWidget {
  const GiveawayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GiveawayController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            SvgPicture.asset(
              AppIcons.reward,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            space8W,
            CustomText(
              AppStaticStrings.winEveryWeekTitle.tr,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchPageData(),
        child: Obx(() {
          // 1. Loading State
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.pageData.value;

          return CustomScrollView(
            // AlwaysScrollableScrollPhysics is key to making RefreshIndicator work
            // even when there is no content.
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // 2. Empty State (handled as a sliver)
              if (data == null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CustomText(
                      "There is no running giveaway".tr,
                      variant: TextVariant.bodyMedium,
                      color: AppColors.kTextColor,
                    ),
                  ),
                )
              else ...[
                // 3. Main Content
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // space12H,
                      CustomText(
                        AppStaticStrings.newPrizeEveryWeek.tr,
                        color: AppColors.kSecondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        AppStaticStrings.drawnFridays.tr,
                        color: AppColors.kSecondaryTextColor,
                        fontSize: 11,
                      ),
                      space8H,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomText(
                            "Week ${data.currentWeekly?.weekNumber ?? 18} of 52",
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      space12H,

                      // Weekly Prize Card
                      if (data.currentWeekly != null) ...[
                        WeeklyPrizeCardWidget(giveaway: data.currentWeekly!),
                        space16H,
                      ],

                      // Major Giveaway Card
                      if (data.majorGiveaways.isNotEmpty) ...[
                        MajorGiveawayCardWidget(
                          giveaway: data.majorGiveaways.first,
                        ),
                        space24H,
                      ],

                      // Coming Up Header
                      CustomText(
                        AppStaticStrings.giveawaysComingUp.tr,
                        variant: TextVariant.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                      space12H,
                    ]),
                  ),
                ),

                // 4. Dynamic Upcoming List
                SliverPadding(
                  padding: AppPadding.getPadding12H(context),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = data.upcoming[index];
                      return UpcomingGiveawayTileWidget(
                        title: item.title,
                        week: "Week ${item.weekNumber}",
                        price: "\$${item.valueInNzd}.00nzd",
                      );
                    }, childCount: data.upcoming.length),
                  ),
                ),

                // 5. Bottom Spacing
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ],
          );
        }),
      ),
    );
  }
}
