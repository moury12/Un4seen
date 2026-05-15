import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.icon,
    this.isOutlined = false,
    this.isLoading = false,
    this.isExpanding = true,
    this.borderRadius = 24.0,
    this.borderColor,
    this.textStyle, this.rightIcon,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final IconData? icon;
    final IconData? rightIcon ;

  final bool isOutlined;
  final bool isLoading;
  final bool isExpanding;
  final double borderRadius;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final defaultColor = AppColors.kPrimaryColor;

    return SizedBox(
      width: isExpanding ? double.infinity : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? defaultColor),
          foregroundColor:
              textColor ?? (isOutlined ? AppColors.kTextColor : Colors.white),
          elevation: 0,
          side: isOutlined || borderColor != null
              ? BorderSide(
                  color:
                      borderColor ??
                      AppColors.kPrimaryColor.withValues(alpha: 0.5),
                )
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: AppPadding.getPadding12H(context),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 20,
                      color:
                          iconColor ??
                          textColor ??
                          (isOutlined ? AppColors.kPrimaryColor : Colors.white),
                    ),
                    space8W,
                  ],
                  Text(
                    text,
                    style:
                        textStyle ??
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                          color:
                              textColor ??
                              (isOutlined
                                  ? AppColors.kPrimaryColor
                                  : Colors.white),
                        ),
                  ),
                   if (rightIcon != null) ...[
                       space8W,
                    Icon(
                      rightIcon,
                      size: 20,
                      color:
                          iconColor ??
                          textColor ??
                          (isOutlined ? AppColors.kPrimaryColor : Colors.white),
                    ),
                 
                  ],
                ],
              ),
      ),
    );
  }
}
