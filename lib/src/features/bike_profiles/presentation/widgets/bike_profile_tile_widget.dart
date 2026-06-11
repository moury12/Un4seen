import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class BikeProfileTileWidget extends StatelessWidget {
  final Color bgColor;
  final Color accentColor;

  const BikeProfileTileWidget({
    super.key,
    required this.bgColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_bike,
              color: AppColors.kPrimaryDarkColor2,
              size: 24,
            ),
          ),
          space12W,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "My Bike Profile",
                  variant: TextVariant.titleMedium,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                CustomText(
                  "View full bike setup & upgrades",
                  variant: TextVariant.labelMedium,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
