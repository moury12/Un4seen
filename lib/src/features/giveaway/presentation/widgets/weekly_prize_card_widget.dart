import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class WeeklyPrizeCardWidget extends StatelessWidget {
  final GiveawayItem giveaway;
  const WeeklyPrizeCardWidget({super.key, required this.giveaway});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GiveawayController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor,
        borderRadius: BorderRadius.circular(appRadius16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(appRadius16)),
                child: CustomNetworkImage(
                  imageUrl: giveaway.image,
                  height: 180,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(20)),
                  child: CustomText("WEEK ${giveaway.weekNumber} PRIZE", color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(giveaway.title, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold, color: Colors.white),
                space4H,
                CustomText(giveaway.prizeDescription, color: Colors.white, fontSize: 12),
                space4H,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.reward,
                      height: 20,
                    ),
                    space8W,
                    CustomText(AppStaticStrings.drawingIn.tr, fontWeight: FontWeight.bold, color: Colors.white),
                  ],
                ),
                space4H,
                // --- DYNAMIC COUNTDOWN ROW ---
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CountdownUnitWidget(value: controller.weeklyDays.value, label: AppStaticStrings.days.tr),
                    CountdownUnitWidget(value: controller.weeklyHours.value, label: AppStaticStrings.hours.tr),
                    CountdownUnitWidget(value: controller.weeklyMins.value, label: AppStaticStrings.mins.tr),
                    CountdownUnitWidget(value: controller.weeklySecs.value, label: AppStaticStrings.secs.tr),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
