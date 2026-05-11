import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final int maxLines;

  const ProfileTextFieldWidget({
    super.key,
    required this.hint,
    this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(appRadius),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.kPrimaryColor, size: 18),
            space8W,
          ],
          Expanded(
            child: TextField(
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 12, color: Colors.white70),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
