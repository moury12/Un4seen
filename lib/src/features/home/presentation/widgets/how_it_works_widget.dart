import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../core/core_export.dart';

class HowItWorksWidget extends StatelessWidget {
  const HowItWorksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor3.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.lightbulb_outline,
                color: AppColors.kPrimaryColor,
              ),
              space8W,
              CustomText(
                AppStaticStrings.howItWorks.tr,
                variant: TextVariant.titleMedium,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          space8H,
          _bulletPoint(AppStaticStrings.howItWorksDesc1.tr),

          _bulletPoint(AppStaticStrings.howItWorksDesc2.tr),

          _bulletPoint(AppStaticStrings.howItWorksDesc3.tr),

          _bulletPoint(AppStaticStrings.howItWorksDesc4.tr),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(Icons.circle, size: 6, color: Colors.white),
        ),
        space12W,
        Expanded(
          child: CustomText(
            text,
            variant: TextVariant.bodySmall,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
