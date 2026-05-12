import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/core_export.dart';
import '../../../../core/widgets/custom_shape.dart';

class PointsBalanceCardWidget extends StatelessWidget {
  const PointsBalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SlantedBlurContainer(
      width: double.infinity,
      blurSigma: 20,
      gradient: LinearGradient(
        colors: [
          Color(0xff0196E7).withValues(alpha: 0.5),
          Color(0xff015A89).withValues(alpha: 0.5),
        ],
      ), // boxBorder: Border.all(color: AppColors.kPrimaryColor, width: 1),
      padding: AppPadding.getPadding12(context).copyWith(bottom: 28),

      child: Stack(
        children: [
          // Bike shadow image — top right watermark
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(AppImages.bikeShadow, height: 70),
          ),

          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppImages.bikeShadow,
                // height: 100,
              ),
              // "Your Shred Points Balance" row
              Row(
                children: [
                  SvgPicture.asset(AppIcons.pointsEarned, height: 18),
                  const SizedBox(width: 6),
                  Text(
                    AppStaticStrings.yourShredPointsBalance.tr,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              space4H,

              // Points value
              const Text(
                '2,850',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),

              space4H,

              // Birthday bonus pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🎉', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 6),
                    Text(
                      'Birthday Bonus: 2x Points Active!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
