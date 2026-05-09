import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_images.dart';
import '../theme/app_colors.dart';

class BikeProgressBar extends StatelessWidget {
  final double progress;

  const BikeProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    //  Transform.rotate(
    //             angle: pi / .10030, // 45 degrees
    //             child: const BikeProgressBar(progress: 1.0),
    //           ),
    return Padding(
      padding: const EdgeInsets.only(top: 9.0),
      child: Transform.rotate(
        angle: pi / .10029, // 45 degrees

        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            // Make sure progress is between 0 and 1
            final double clampedProgress = progress.clamp(0.0, 1.0);
            // Calculate the horizontal position for the bike icon
            // 24 is approximate width of the bike icon to keep it within bounds
            final double bikePosition = (width - 32) * clampedProgress;

            return SizedBox(
              height: 40,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // Background track
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF1A1A2E,
                        ), // Dark background color from screenshot
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  // Progress track
                  Positioned(
                    left: 0,
                    bottom: 10,
                    child: Container(
                      width: width * clampedProgress,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor, // Blue progress color
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  // Bike icon
                  Positioned(
                    left: bikePosition,
                    // top: 10,
                    bottom: 12, // Position slightly above the bar
                    child: Transform.rotate(
                      angle: -pi / .102, // 45 degrees
                      child: SvgPicture.asset(
                        AppIcons.ride,
                        height: 32,
                        // width: 32,
                        colorFilter: const ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ), // Black silhouette
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
