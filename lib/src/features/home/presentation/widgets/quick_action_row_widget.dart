import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class QuickActionRowWidget extends StatelessWidget {
  const QuickActionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 130, // Adjust height as needed
        width: 70.0 * 6 + 20, // Total width: (item width * count) + padding
        child: Stack(
          children: [
            _actionItem(AppIcons.reward, AppStaticStrings.points.tr, 0),
            _actionItem(
              AppIcons.ideas,
              "Ideas",
              1,
              onTap: () => context.push(AppRoutes.ideasFeedback),
            ),
            _actionItem(
              AppIcons.crew,
              "Crew",
              2,
              onTap: () => context.push(AppRoutes.crewChoice),
            ),
            _actionItem(
              AppIcons.world,
              "World",
              3,
              onTap: () => context.push(AppRoutes.un4seenWorld),
            ),
            _actionItem(
              AppIcons.chat, 
              AppStaticStrings.chat.tr, 
              4,
              onTap: () => context.push(AppRoutes.channels),
            ),
            _actionItem(
              AppIcons.bag,
              "Shop",
              5,
              onTap: () => context.push(AppRoutes.shop),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionItem(
    String icon,
    String label,
    int idx, {
    GestureTapCallback? onTap,
  }) {
    return Positioned(
      left: (idx * 75.0),
      bottom: idx * 12.0, // Adjust offset for stacking effect
      child: Container(
        width: 65,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ButtonTapWidget(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                space4H,
                CustomText(
                  label,
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
