import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class UpgradeCategoryWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> items;

  const UpgradeCategoryWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppPadding.getPadding12(context),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryDarkColor2,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                space8W,
                CustomText(
                  title,
                  color: Colors.white,
                  variant: TextVariant.titleSmall,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          space8H,
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.kAccentColor),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.circle,
                      size: 8,
                      color: AppColors.kPrimaryColor,
                    ),
                    space12W,
                    Expanded(
                      child: CustomText(
                        item,
                        variant: TextVariant.labelMedium,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
