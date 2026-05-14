import 'package:flutter_svg/flutter_svg.dart';

import '../../../../src_export.dart';
import '../widgets/widget_export.dart';

class GiveawayPage extends StatelessWidget {
  const GiveawayPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                AppStaticStrings.week18Of52.tr,
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            space8H,

            // Weekly Prize Card
            const WeeklyPrizeCardWidget(),
            space8H,

            // Major Giveaway Card
            const MajorGiveawayCardWidget(),
            space8H,

            // Coming Up Section
            CustomText(
              AppStaticStrings.giveawaysComingUp.tr,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            space12H,
            const UpcomingGiveawayTileWidget(
              title: "250pc Pack of Hubstikers",
              week: "Week 19",
              price: "\$199.99nzd",
            ),
            const UpcomingGiveawayTileWidget(
              title: "1x Custom Graphics Kit",
              week: "Week 19",
              price: "\$389.99nzd",
            ),
            const UpcomingGiveawayTileWidget(
              title: "1 x Custom Made Gripper Ace'n seat cover",
              week: "Week 21",
              price: "\$159.99nzd",
            ),
            const UpcomingGiveawayTileWidget(
              title: "iphone 17 Pro",
              week: "Week 22",
              price: "\$2349nzd",
            ),

            space24H,
          ],
        ),
      ),
    );
  }
}
