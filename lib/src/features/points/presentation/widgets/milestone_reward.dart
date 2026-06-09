import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/features/points/data/models/point_data_model.dart';
import 'package:un4seen/src/features/points/points_export.dart';

import '../../../../core/core_export.dart';
import '../../../../core/widgets/gradient_container.dart';


class MilestoneRewardWidget extends StatelessWidget {
  final IndividualMilestone data;
  const MilestoneRewardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
        final controller = Get.find<PointsController>();

    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
      child: Column(
        spacing: 8,
        children: [
          Row(
            children: [
              CustomNetworkImage(imageUrl: data.image, height: 50, width: 50),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data.title,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    CustomText(
                      '${data.pointsRequired} Points',
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
             if (!data.isClaimed && data.isUnlocked)
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
                              ? SizedBox(
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
                          controller.claimMilestone(data.id);
                        },
                      ),
                
              //  CustomButton(text: "Claim", onPressed: () {}, isExpanding: true, borderRadius: 20),
            ],
          ),
          LinearProgressIndicator(
            value: data.progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
    ;
  }
}
