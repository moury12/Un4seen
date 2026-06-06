import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src_export.dart';
import '../widgets/widget_export.dart';

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
              colorFilter: ColorFilter.mode(
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
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = controller.pageData.value;
            if (data == null) {
              return const Center(
                child: CustomText("There is no running giveaway"),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    "Week ${data.currentWeekly?.weekNumber ?? 18} of 52",
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space8H,

                // Weekly Prize Card
                if (data.currentWeekly != null)
                  WeeklyPrizeCardWidget(giveaway: data.currentWeekly!),
                space8H,

                // Major Giveaway Card
                if (data.majorGiveaways.isNotEmpty)
                  MajorGiveawayCardWidget(giveaway: data.majorGiveaways.first),
                space8H,

                // Coming Up Section
                CustomText(
                  AppStaticStrings.giveawaysComingUp.tr,
                  variant: TextVariant.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
                space12H,

                // Dynamic Upcoming List
                ...data.upcoming.map(
                  (item) => UpcomingGiveawayTileWidget(
                    title: item.title,
                    week: "Week ${item.weekNumber}",
                    price: "\$${item.valueInNzd}.00nzd",
                  ),
                ),

                space24H,
              ],
            );
          }),
        ),
      ),
    );
  }
}
