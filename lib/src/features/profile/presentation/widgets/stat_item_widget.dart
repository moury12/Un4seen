import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class StatItemWidget extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback? onTap;

  const StatItemWidget(
    {super.key,
    required this.value,
    required this.label,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Column(
        children: [
          CustomText(
            value,
            variant: TextVariant.labelMedium,
            color: AppColors.kTextColor,
            fontWeight: FontWeight.w600,
          ),
          CustomText(
            label,
            variant: TextVariant.labelSmall,
            color: AppColors.kSecondaryTextColor,
          ),
        ],
      ),
    );
  }
}
