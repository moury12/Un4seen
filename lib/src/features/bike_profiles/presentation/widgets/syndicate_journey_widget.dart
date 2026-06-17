import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:un4seen/src/features/profile/data/models/user_profile_model.dart';
import '../../../../core/core_export.dart';

class SyndicateJourneyWidget extends StatelessWidget {
  final Color bgColor;
  final Color accentColor;
  final Journey? journey; // Added dynamic journey data

  const SyndicateJourneyWidget({
    super.key,
    required this.bgColor,
    required this.accentColor,
    this.journey,
  });

  // Helper to calculate the progress bar width based on reached milestones
  double _calculateProgress() {
    if (journey?.milestones == null) return 0.05;
    final m = journey!.milestones!;
    if (m.is5yrReached) return 1.0;
    if (m.is4yrReached) return 0.84;
    if (m.is3yrReached) return 0.68;
    if (m.is2yrReached) return 0.52;
    if (m.is1yrReached) return 0.36;
    if (m.is6moReached) return 0.20;
    if (m.is3moReached) return 0.05;
    return 0.02;
  }

  @override
  Widget build(BuildContext context) {
    final milestones = journey?.milestones;
    final progress = _calculateProgress();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
                size: 20,
              ),
              space8W,
              CustomText(
                "Syndicate Journey",
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Member since ${journey?.memberSince ?? '...'}",
                variant: TextVariant.labelMedium,
                color: Colors.white,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomText(
                  journey?.totalDuration ?? "0 days",
                  variant: TextVariant.labelMedium,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          space12H,

          // --- Dynamic Timeline UI ---
          LayoutBuilder(builder: (context, constraints) {
            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Background Track
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Active Progress (Dynamic Width)
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                // Bike Marker (Positioned based on progress)
                Positioned(
                  left: (constraints.maxWidth * progress) - 15,
                  top: -15,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue,
                        size: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.directions_bike,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          
          space16H,
          
          // Dynamic Milestones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMilestone("3mo", milestones?.is3moReached ?? false, accentColor),
              _buildMilestone("6mo", milestones?.is6moReached ?? false, accentColor),
              _buildMilestone("1yr", milestones?.is1yrReached ?? false, accentColor),
              _buildMilestone("2yr", milestones?.is2yrReached ?? false, accentColor),
              _buildMilestone("3yr", milestones?.is3yrReached ?? false, accentColor),
              _buildMilestone("4yr", milestones?.is4yrReached ?? false, accentColor),
              _buildMilestone("5yr", milestones?.is5yrReached ?? false, accentColor),
            ],
          ),

          // --- Loyalty Pays Card (Design preserved) ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: accentColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  AppColors.kPrimaryColor.withValues(alpha: 0.5),
                  AppColors.kPrimaryDarkColor2.withValues(alpha: 0.5),
                ],
              ),
            ),
            child: Column(
              spacing: 6,
              children: [
                Row(
                  spacing: 6,
                  children: [
                    SvgPicture.asset(AppIcons.stars, height: 24, width: 24),
                    space8W,
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            "Loyalty Pays 👊🔥",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          CustomText(
                            "Be part of the Syndicate for 5 years and you're in the draw to win",
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: CustomText(
                      "100,000nzd",
                      variant: TextVariant.headlineSmall,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestone(String label, bool reached, Color accentColor) {
    return Column(
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: reached ? accentColor : Colors.white24,
              width: 2,
            ),
            color: reached ? accentColor : Colors.transparent,
            boxShadow: reached
                ? [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.5),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
        ),
        space4H,
        CustomText(
          label,
          variant: TextVariant.labelMedium,
          color: reached ? accentColor : Colors.white24,
        ),
      ],
    );
  }
}