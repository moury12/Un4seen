import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class SyndicateJourneyWidget extends StatelessWidget {
  final Color bgColor;
  final Color accentColor;

  const SyndicateJourneyWidget({
    super.key,
    required this.bgColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 20),
              space8W,
              CustomText(
                "Syndicate Journey",
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ],
          ),
          space8H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "Member since November 2024",
                variant: TextVariant.labelSmall,
                color: Colors.white70,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CustomText(
                  "1.5 years",
                  variant: TextVariant.labelSmall,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          space24H,

          // --- Timeline UI ---
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Active part of progress bar
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: 0.35, // Adjust based on actual progress
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Bike Marker
              Positioned(
                left: 70, // Adjust based on progress
                top: -15,
                child: Column(
                  children: [
                    const Icon(Icons.keyboard_arrow_down, color: Colors.blue, size: 16),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.directions_bike, color: Colors.white, size: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
          space16H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMilestone("3mo", true, accentColor),
              _buildMilestone("6mo", true, accentColor),
              _buildMilestone("1yr", true, accentColor),
              _buildMilestone("2yr", false, accentColor),
              _buildMilestone("3yr", false, accentColor),
              _buildMilestone("4yr", false, accentColor),
              _buildMilestone("5yr", false, accentColor),
            ],
          ),
          space24H,

          // --- Loyalty Pays Card ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: accentColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white.withOpacity(0.05),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.stars, color: Colors.blue, size: 24),
                    space8W,
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "Loyalty Pays 👊🔥\n",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                            ),
                            TextSpan(
                              text: "Be part of the Syndicate for 5 years and you're in the draw to win",
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                space8H,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: CustomText(
                      "\$100,000nzd",
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
            border: Border.all(color: reached ? accentColor : Colors.white24, width: 2),
            color: reached ? accentColor : Colors.transparent,
            boxShadow: reached ? [BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 4)] : null,
          ),
        ),
        space4H,
        CustomText(label, variant: TextVariant.labelSmall, color: reached ? accentColor : Colors.white24),
      ],
    );
  }
}