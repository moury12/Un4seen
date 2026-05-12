import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:un4seen/src/core/core_export.dart';

class SlantedBlurContainer extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double slantHeight;
  final Color? color; // For solid colors
  final Gradient? gradient; // For gradients
  final double blurSigma; // How much blur you want (e.g., 10.0)
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const SlantedBlurContainer({
    super.key,
    this.child,
    this.radius = 20.0,
    this.slantHeight = 20.0,
    this.color,
    this.gradient,
    this.blurSigma = 0.0, // Default to 0 (no blur)
    this.shadows,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // We use a Clipper to ensure the blur and color stay inside the slanted lines
    return ClipPath(
      clipper: _SlantedClipper(radius: radius, slantHeight: slantHeight),
      child: Container(
        width: width,
        height: height,
        padding: padding,

        decoration: BoxDecoration(
          color: color ?? (gradient == null ? AppColors.kPrimaryColor : null),
          gradient: gradient,
          boxShadow: shadows,
          // border: Border.all(color: AppColors.kPrimaryDarkColor, width: 1),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: child,
        ),
      ),
    );
  }
}

/// Helper to clip the Container and the Blur to the slanted shape
class _SlantedClipper extends CustomClipper<Path> {
  final double radius;
  final double slantHeight;

  _SlantedClipper({required this.radius, required this.slantHeight});

  Path getSelection(Size size) => getClip(size);

  @override
  Path getClip(Size size) {
    final rect = Offset.zero & size;
    return Path()
      ..moveTo(rect.left + radius, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
      ..lineTo(rect.right, rect.bottom - slantHeight - radius)
      ..quadraticBezierTo(
        rect.right,
        rect.bottom - slantHeight,
        rect.right - radius,
        rect.bottom - slantHeight,
      )
      ..lineTo(rect.left + radius, rect.bottom)
      ..quadraticBezierTo(
        rect.left,
        rect.bottom,
        rect.left,
        rect.bottom - radius,
      )
      ..lineTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top)
      ..close();
  }

  @override
  bool shouldReclip(_SlantedClipper oldClipper) =>
      oldClipper.radius != radius || oldClipper.slantHeight != slantHeight;
}

class SlantedContainer extends StatelessWidget {
  final Widget? child;
  final double radius;
  final double slantHeight;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const SlantedContainer({
    super.key,
    this.child,
    this.radius = 20.0,
    this.slantHeight = 25.0,
    this.gradient,
    this.shadows,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: ShapeDecoration(
        gradient:
            gradient ??
            const LinearGradient(
              colors: [Color(0xFF64B5F6), Color(0xFF2196F3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        shadows:
            shadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
        shape: _SlantedRoundedBorder(radius: radius, slantHeight: slantHeight),
      ),
      child: child,
    );
  }
}

/// Private helper class to draw the path
class _SlantedRoundedBorder extends ShapeBorder {
  final double radius;
  final double slantHeight;

  const _SlantedRoundedBorder({
    required this.radius,
    required this.slantHeight,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.left + radius, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..quadraticBezierTo(rect.right, rect.top, rect.right, rect.top + radius)
      ..lineTo(rect.right, rect.bottom - slantHeight - radius)
      ..quadraticBezierTo(
        rect.right,
        rect.bottom - slantHeight,
        rect.right - radius,
        rect.bottom - slantHeight,
      )
      ..lineTo(rect.left + radius, rect.bottom)
      ..quadraticBezierTo(
        rect.left,
        rect.bottom,
        rect.left,
        rect.bottom - radius,
      )
      ..lineTo(rect.left, rect.top + radius)
      ..quadraticBezierTo(rect.left, rect.top, rect.left + radius, rect.top)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) =>
      _SlantedRoundedBorder(radius: radius * t, slantHeight: slantHeight * t);
}
