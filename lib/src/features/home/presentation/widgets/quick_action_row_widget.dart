import 'package:flutter_svg/flutter_svg.dart';
import '../../../../src_export.dart';

class QuickActionRowWidget extends StatelessWidget {
  const QuickActionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95, // Reduced container height to eliminate excess white space
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 95,
              width: 75.0 * 8 + 20,
              child: Stack(
                children: [
                  _actionItem(
                    AppIcons.badge,
                    AppStaticStrings.points.tr,
                    0,
                    onTap: () {
                      if (Get.isRegistered<NavigationController>()) {
                        Get.find<NavigationController>().changeIndex(3);
                      }
                    },
                  ),
                  _actionItem(
                    AppIcons.reward,
                    "Comps",
                    1,
                    onTap: () {
                      if (Get.isRegistered<NavigationController>()) {
                        Get.find<NavigationController>().changeIndex(1);
                      }
                    },
                  ),
                  _actionItem(
                    AppIcons.pointsEarned,
                    AppStaticStrings.giveaway.tr,
                    2,
                    onTap: () {
                      if (Get.isRegistered<NavigationController>()) {
                        Get.find<NavigationController>().changeIndex(2);
                      }
                    },
                  ),
                  _actionItem(
                    AppIcons.ideas,
                    "Ideas",
                    3,
                    onTap: () => context.push(AppRoutes.ideasFeedback),
                  ),
                  _actionItem(
                    AppIcons.chat,
                    AppStaticStrings.chat.tr,
                    4,
                    onTap: () => context.push(AppRoutes.channels),
                  ),

                  _actionItem(
                    AppIcons.world,
                    "World",
                    5,
                    onTap: () => context.push(AppRoutes.un4seenWorld),
                  ),
                  _actionItem(
                    AppIcons.crew,
                    "Crew",
                    6,
                    onTap: () => context.push(AppRoutes.crewChoice),
                  ),
                  _actionItem(
                    AppIcons.bag,
                    "Shop",
                    7,
                    onTap: () => context.push(AppRoutes.shop),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 8,
            bottom: 24,
            child: IgnorePointer(
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withValues(alpha: .5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
      bottom: idx * 6.0,
      child: Container(
        width: 65,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor3],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ButtonTapWidget(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
