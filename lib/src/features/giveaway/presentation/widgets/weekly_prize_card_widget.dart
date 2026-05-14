import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';


class WeeklyPrizeCardWidget extends StatelessWidget {
  const WeeklyPrizeCardWidget({super.key});

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
                  imageUrl: 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?q=80&w=600',
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
                  child: CustomText("WEEK 18 PRIZE", color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(AppStaticStrings.premiumDecalKit.tr, variant: TextVariant.titleLarge, fontWeight: FontWeight.bold, color: Colors.white),
                space4H,
                CustomText(AppStaticStrings.customUn4seenDesc.tr, color: Colors.white, fontSize: 12),
                space4H,
                Row(
                  children: [
SvgPicture.asset(
              AppIcons.reward,
              height: 20,
              // colorFilter: ColorFilter.mode(
              //   AppColors.kPrimaryColor,
              //   BlendMode.srcIn,
              // ),
            ),                    space8W,
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
