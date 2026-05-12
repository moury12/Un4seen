import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class BikeDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const BikeDetailItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryDarkColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(color: AppColors.kAccentColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColors.kPrimaryColor),
              space4W,
              CustomText(
                label,
                variant: TextVariant.labelSmall,
                color: AppColors.kWhiteTextColor,
              ),
            ],
          ),
          space4H,
          CustomText(
            value,
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.kWhiteTextColor,
          ),
        ],
      ),
    );
  }
}
