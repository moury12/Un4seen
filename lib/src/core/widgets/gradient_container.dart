import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/app_constants.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final List<Color>? gradientColors;
  final AlignmentGeometry? begin;
  final AlignmentGeometry? end;
  final Color? borderColor;
  final double? borderWidth;
  final VoidCallback? onTap;

  const GradientContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.gradientColors,
    this.begin,
    this.end,
    this.borderColor,
    this.borderWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? appRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: borderWidth ?? 1)
            : null,
        gradient: LinearGradient(
          colors:
              gradientColors ??
              [AppColors.kPrimaryColor, AppColors.kPrimaryDarkColor],
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
        ),
      ),
      child: child,
    );

    if (onTap == null) {
      return container;
    }

    return GestureDetector(onTap: onTap, child: container);
  }
}
