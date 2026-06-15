import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:un4seen/src/core/routes/app_routes.dart';
import 'package:un4seen/src/features/profile/data/models/user_profile_model.dart';
import '../../../../core/core_export.dart';

class BikeProfileTileWidget extends StatelessWidget {
  final Color bgColor;
  final Color accentColor;
  final ActiveBike? activeBike;

  const BikeProfileTileWidget({
    super.key,
    required this.bgColor,
    required this.accentColor,
    this.activeBike,
  });

  @override
  Widget build(BuildContext context) {
    final hasBike = activeBike != null;
    return GestureDetector(
      onTap: () {
        if (hasBike && activeBike!.id != null) {
          context.push('${AppRoutes.singleBikeDetails}/${activeBike!.id}');
        } else {
          context.push(AppRoutes.bikeProfiles);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (hasBike && activeBike!.image != null && activeBike!.image!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomNetworkImage(
                  imageUrl: activeBike!.image!,
                  height: 44,
                  width: 44,
                  fit: BoxFit.cover,
                ),
              )
            else
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    hasBike 
                        ? "${activeBike!.year ?? ''} ${activeBike!.make ?? ''} ${activeBike!.model ?? ''}".trim()
                        : "Bike Profile",
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  CustomText(
                    hasBike ? "View full bike setup & upgrades" : "No active bike setup",
                    variant: TextVariant.labelMedium,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

