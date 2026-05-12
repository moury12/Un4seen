import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class AboutMeWidget extends StatelessWidget {
  final Color bgColor;

  const AboutMeWidget({
    super.key,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("About Me", variant: TextVariant.titleMedium, fontWeight: FontWeight.bold, color: Colors.white),
          space8H,
          CustomText(
            "MX rider from LA. Been riding for 10+ years. Love trail Riding and practicing slow wheelies. Always down for a huss!",
            variant: TextVariant.bodySmall,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}