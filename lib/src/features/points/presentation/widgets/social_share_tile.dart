import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';
import '../../../../core/widgets/gradient_container.dart';

class SocialShareTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final String points;

  const SocialShareTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      margin: const EdgeInsets.only(bottom: 8),
      padding: AppPadding.getPadding12(context),
      gradientColors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryColor],
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: SvgPicture.asset(icon, height: 20),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title, color: Colors.white, fontWeight: FontWeight.bold),
                CustomText(subtitle, color: Colors.white70, fontSize: 10),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: CustomText("+$points", color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
