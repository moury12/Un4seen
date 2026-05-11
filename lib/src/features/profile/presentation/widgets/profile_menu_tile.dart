import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:un4seen/src/core/core_export.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String? icon;
  final Widget? iconWidget;
  final VoidCallback onTap;

  const ProfileMenuTile({
    super.key,
    required this.title,
    this.icon,
    this.iconWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ProfileMenuShapeClipper(radius: 16, slantAmount: 6),
      child: ButtonTapWidget(
        onTap: onTap,
        radius: appRadius,
        child: Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: AppPadding.getPadding12(context),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryDarkColor,
                AppColors.kPrimaryDarkColor2,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
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
                  child: iconWidget ??
                      (icon != null
                          ? SvgPicture.asset(
                              icon!,
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                AppColors.kPrimaryColor,
                                BlendMode.srcIn,
                              ),
                            )
                          : const SizedBox.shrink()),
                ),
              ),
              const SizedBox(width: 8),

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
                // width: 28,
                // height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                padding: AppPadding.getPadding8(context),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuShapeClipper extends CustomClipper<Path> {
  final double slantAmount;
  final double radius;

  ProfileMenuShapeClipper({required this.slantAmount, required this.radius});

  @override
  Path getClip(Size size) {
    final path = Path();

    // ১. উপরের বাম কোণা থেকে শুরু
    path.moveTo(0, slantAmount + radius);
    path.quadraticBezierTo(0, slantAmount, radius, slantAmount);

    // ২. উপরের ডান কোণা (এটিকে আমরা নিচু করেছি slantAmount দিয়ে)
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // ৩. নিচের ডান কোণা
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );

    // ৪. নিচের বাম কোণা
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
