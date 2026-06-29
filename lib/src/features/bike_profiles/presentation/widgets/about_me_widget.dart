import 'package:flutter/material.dart';
import '../../../../core/core_export.dart';

class AboutMeWidget extends StatelessWidget {
  final Color bgColor;
  final String? aboutMe; 

  const AboutMeWidget({super.key, required this.bgColor, this.aboutMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const  CustomText(
            "About",
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          space8H,
          CustomText(
            aboutMe ?? "",
            variant: TextVariant.labelMedium,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
