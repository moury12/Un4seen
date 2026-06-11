import 'package:flutter/material.dart';

enum TextVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.variant = TextVariant.labelMedium,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
    this.decoration,
    this.decorationColor,
    this.softWrap,
    this.style,
  });

  final String text;
  final TextVariant variant;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final bool? softWrap;
  final TextStyle? style;

  TextStyle? _resolveStyle(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final base = switch (variant) {
      TextVariant.displayLarge => tt.displayLarge,
      TextVariant.displayMedium => tt.displayMedium,
      TextVariant.displaySmall => tt.displaySmall,
      TextVariant.headlineLarge => tt.headlineLarge,
      TextVariant.headlineMedium => tt.headlineMedium,
      TextVariant.headlineSmall => tt.headlineSmall,
      TextVariant.titleLarge => tt.titleLarge,
      TextVariant.titleMedium => tt.titleMedium,
      TextVariant.titleSmall => tt.titleSmall,
      TextVariant.labelLarge => tt.labelLarge,
      TextVariant.labelMedium => tt.labelMedium,
      TextVariant.labelSmall => tt.labelSmall,
      TextVariant.bodyLarge => tt.bodyLarge,
      TextVariant.bodyMedium => tt.bodyMedium,
      TextVariant.bodySmall => tt.bodySmall,
    };
    return base?.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      style: style ?? _resolveStyle(context),
    );
  }
}
