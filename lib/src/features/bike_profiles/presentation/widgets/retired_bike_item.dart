import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';
import '../../../../core/widgets/custom_network_image.dart';

class RetiredBikeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const RetiredBikeItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kPrimaryDarkColor),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl,
            width: 60,
            height: 40,
            radius: 8,
            fit: BoxFit.cover,
          ),
          space8W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: AppColors.kWhiteTextColor,
                  variant: TextVariant.labelLarge,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  subtitle,
                  color: AppColors.kWhiteTextColor,
                  variant: TextVariant.labelSmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.kWhiteTextColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ButtonTapWidget(
              onTap: onTap,
              child: const CustomText(
                "View Details",
                color: AppColors.kPrimaryColor,
                variant: TextVariant.labelSmall,
              ),
            ),
          ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}
