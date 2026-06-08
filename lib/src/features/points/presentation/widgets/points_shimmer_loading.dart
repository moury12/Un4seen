import 'package:flutter/material.dart';
import '../../../../src_export.dart';

class PointsShimmerLoading extends StatelessWidget {
  const PointsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    // We define a base color that matches your dark theme
    final Color baseColor = AppColors.kPrimaryDarkColor.withValues(alpha: 0.3);
    final Color highlightColor = AppColors.kAccentColor.withValues(alpha: 0.1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top text skeletons
        _shimmerBox(height: 14, width: 200, color: baseColor),
        space8H,
        // Points Balance Card Skeleton
        _shimmerBox(height: 140, width: double.infinity, borderRadius: 20, color: baseColor),
        space12H,
        // Daily login claim skeleton
        _shimmerBox(height: 80, width: double.infinity, borderRadius: 12, color: baseColor),
        space16H,
        // Earn points title
        _shimmerBox(height: 20, width: 120, color: baseColor),
        space12H,
        // Share card skeleton
        _shimmerBox(height: 120, width: double.infinity, borderRadius: 16, color: baseColor),
        space12H,
        // List of action tiles
        ...List.generate(3, (index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _shimmerBox(height: 60, width: double.infinity, borderRadius: 12, color: baseColor),
        )),
      ],
    );
  }

  Widget _shimmerBox({required double height, required double width, double borderRadius = 8, required Color color}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}