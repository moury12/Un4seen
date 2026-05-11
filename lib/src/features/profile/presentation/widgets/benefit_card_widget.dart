import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/features/profile/presentation/widgets/profile_menu_tile.dart';

class BenefitCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const BenefitCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ProfileMenuShapeClipper(slantAmount: 10, radius: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryDarkColor2],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          border: Border.all(color: AppColors.kPrimaryColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kSurfaceColor,
              ),
              child: SvgPicture.asset(
                icon.toString(),
                colorFilter: ColorFilter.mode(
                  AppColors.kPrimaryColor,
                  BlendMode.srcIn,
                ),
                height: 20,
              ),
            ),
            space12W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kWhiteTextColor,
                    ),
                  ),
                  space4H,
                  CustomText(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.kWhiteTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
