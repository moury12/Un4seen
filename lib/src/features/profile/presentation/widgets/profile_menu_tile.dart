import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/button_tap_widget.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      radius: appRadius,
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: AppPadding.getPadding8(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.kPrimaryDarkColor, AppColors.kPrimaryDarkColor2],
          ),
          // Dark blue tile — matches the screenshot
          borderRadius: BorderRadius.circular(appRadius16),
          border: Border.all(color: AppColors.kPrimaryDarkColor2, width: 1),
        ),
        child: Row(
          children: [
            // ── Circular icon container ──────────────────
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.kSurfaceColor,
                border: Border.all(color: AppColors.kPrimaryColor, width: 1),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // ── Title ────────────────────────────────────
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // ── Arrow ────────────────────────────────────
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
