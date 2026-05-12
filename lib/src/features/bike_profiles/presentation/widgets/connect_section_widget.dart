import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/core_export.dart';

class ConnectSectionWidget extends StatelessWidget {
  final Color bgColor;

  const ConnectSectionWidget({
    super.key,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("Connect", variant: TextVariant.titleMedium, fontWeight: FontWeight.bold, color: Colors.white),
          space8H,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: 8,
              children: [
                _buildSocialButton(AppIcons.fb, "Facebook", Colors.blue),
                _buildSocialButton(AppIcons.ig, "Instagram", Colors.pink),
                _buildSocialButton(AppIcons.tictok, "TikTok", Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String icon, String label, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(spacing: 6,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         SvgPicture.asset(icon),
        
          CustomText(label, variant: TextVariant.labelMedium, fontWeight: FontWeight.bold, color: Colors.black),
          const Icon(Icons.open_in_new, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}