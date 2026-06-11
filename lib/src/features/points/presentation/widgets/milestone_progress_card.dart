import 'package:un4seen/src/features/points/data/models/point_data_model.dart';

import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class MilestoneProgressCard extends StatelessWidget {
  final CommunityMilestone model;
  const MilestoneProgressCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PointsController>();
    return GradientContainer(
      padding: EdgeInsets.zero,
      gradientColors: const [
        AppColors.kPrimaryDarkColor2,
        AppColors.kPrimaryColor,
      ],
      child: Column(
        spacing: 8,
        children: [
          CustomNetworkImage(
            imageUrl: model.image,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        model.title,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    space8W,
                    if (!model.isClaimed && model.isUnlocked)
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
                          child: controller.isSubmittingProof.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : CustomText(
                                  AppStaticStrings.claim.tr,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                        onTap: () {
                          controller.claimMilestone(model.id);
                        },
                      ),
                  ],
                ),
                space8H,
                CustomText(
                  model.description,
                  color: Colors.white70,
                  fontSize: 12,
                ),
                space12H,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "${model.currentMembers} Members",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    CustomText(
                      "${model.targetMembers} Members",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ],
                ),
                space4H,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: model.progress,
                    minHeight: 8,
                    backgroundColor: Colors.black26,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
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
