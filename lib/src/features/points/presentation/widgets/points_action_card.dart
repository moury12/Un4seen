import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class PointsActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Widget? trailing;

  const PointsActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.getPadding12(context),
      gradientColors: const [
        AppColors.kPrimaryDarkColor,
        AppColors.kPrimaryColor,
      ],
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                CustomText(subtitle, color: Colors.white70, fontSize: 11),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
