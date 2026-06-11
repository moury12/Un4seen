import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class RetiredBikeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const RetiredBikeItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 40,
              fit: BoxFit.cover,
            ),
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
          // CustomButton(
          //   text: 'View Details',
          //   onPressed: () {},
          //   isExpanding: false,
          //   borderRadius: 8,
          //   textStyle: const TextStyle(
          //     fontSize: 10,
          //     fontWeight: FontWeight.bold,
          //   ),
          //   backgroundColor: Colors.white,
          //   textColor: AppColors.kPrimaryColor,
          // ),
        ],
      ),
    );
  }
}
