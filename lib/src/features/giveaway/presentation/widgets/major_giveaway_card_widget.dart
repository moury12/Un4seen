import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class MajorGiveawayCardWidget extends StatelessWidget {
  const MajorGiveawayCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GiveawayController>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor2,
        borderRadius: BorderRadius.circular(appRadius16),
        border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(appRadius16)),
                child: CustomNetworkImage(
                  imageUrl: 'https://images.unsplash.com/photo-1444491741275-3747c53c99b4?q=80&w=600',
                  height: 200,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(20)),
                  child: CustomText(AppStaticStrings.majorGiveaway.tr, color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            padding: AppPadding.getPadding12(context),
            decoration:  BoxDecoration(
       gradient: LinearGradient(colors:   [ AppColors.kPrimaryColor.withValues(alpha: 0.8),AppColors.kPrimaryDarkColor,],begin: Alignment.topCenter,end: Alignment.bottomCenter),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(appRadius16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, color: Colors.white, size: 14),
                        space8W,
                        CustomText("DRAW IN: Only 3 Months Away", color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ],
                    ),
                  ),
                ),
                space12H,
                // --- DYNAMIC MAJOR COUNTDOWN ---
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    CountdownUnitWidget(value: controller.majorMonths.value, label: "MO"),
                    CountdownUnitWidget(value: controller.majorDays.value, label: "D"),
                    CountdownUnitWidget(value: controller.majorHours.value, label: "H"),
                    CountdownUnitWidget(value: controller.majorMins.value, label: "M"),
                  ],
                )),
                space12H,
                CustomText(AppStaticStrings.christmasMajorGiveaway.tr, fontWeight: FontWeight.bold, color: Colors.white),
                CustomText(AppStaticStrings.biggestPrizeDesc.tr, color: Colors.white70, fontSize: 12),
                space12H,
                CustomText("GRAND PRIZE", color: AppColors.kPrimaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                CustomText(AppStaticStrings.hondaModel.tr, variant: TextVariant.headlineSmall, fontWeight: FontWeight.bold, color: Colors.white),
                space8H,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
                  child: CustomText("${AppStaticStrings.rrp.tr} \$16,999 nzd", color: Colors.white, fontWeight: FontWeight.bold),
                ),
                space12H,
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.crown,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          space8W,
                          Expanded(child: CustomText(AppStaticStrings.automaticEntryTitle.tr, color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14,)),
                        ],
                      ),
                      space4H,
                      CustomText(AppStaticStrings.automaticEntryDesc.tr, color: Colors.white, fontSize: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
