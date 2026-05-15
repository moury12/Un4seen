import 'package:flutter_svg/svg.dart';

import '../../../../src_export.dart';

class ActivitySummaryTileWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const ActivitySummaryTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.getPadding8(context),
      decoration: BoxDecoration(
gradient: LinearGradient(colors: [ AppColors.kPrimaryColor.withValues(alpha: 0.8),AppColors.kPrimaryDarkColor,]),        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: AppColors.kAccentColor, shape: BoxShape.circle),
            child: SvgPicture.asset(icon, height: 20),
          ),
          space12W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(title, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              CustomText(subtitle, color: Colors.white70, fontSize: 12),
            ],
          ),
        ],
      ),
    );
  }
}
